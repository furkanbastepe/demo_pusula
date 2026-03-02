/**
 * BotParser — Şehir Yönetim Botu strateji ayrıştırıcı.
 * Python benzeri söz dizimini belediye hizmet aksiyonlarına dönüştürür.
 *
 * Desteklenen söz dizimi:
 *   if kuyruk > 20:
 *       gise_ac(2)
 *   elif yasli_orani > 30:
 *       oncelik_ver("yasli")
 *   else:
 *       beklet()
 */

export type CivicAction =
    | 'gise_ac'
    | 'gise_kapat'
    | 'oncelik_ver'
    | 'mesai_uzat'
    | 'dijital_yonlendir'
    | 'beklet';

export interface SehirContext {
    saat: number;            // 6-22 arası
    kuyruk: number;          // mevcut kuyruk uzunluğu
    bos_gise: number;        // kapalı/boş gişe sayısı
    acik_gise: number;       // açık gişe sayısı
    yasli_orani: number;     // 0-100 arası yüzde
    memnuniyet: number;      // 0-100 arası
    butce_kalan: number;     // 0-1000 birim
    toplam_islem: number;    // bugün yapılan toplam işlem
    tur: number;             // mevcut tur (0-15)
}

interface ParsedCondition {
    variable: string;
    operator: '>' | '<' | '>=' | '<=' | '==' | '!=';
    value: number;
}

interface ParsedBlock {
    condition?: ParsedCondition;
    isElse?: boolean;
    action: CivicAction;
    param?: number;
}

function parseCondition(condStr: string): ParsedCondition | null {
    // Handle 'and' / 'or' — take first condition for simplicity
    let singleCond = condStr;
    if (condStr.includes(' and ')) {
        singleCond = condStr.split(' and ')[0].trim();
    } else if (condStr.includes(' or ')) {
        singleCond = condStr.split(' or ')[0].trim();
    }

    const ops = ['>=', '<=', '!=', '==', '>', '<'] as const;
    for (const op of ops) {
        const parts = singleCond.split(op);
        if (parts.length === 2) {
            return {
                variable: parts[0].trim(),
                operator: op,
                value: parseFloat(parts[1].trim()),
            };
        }
    }
    return null;
}

function resolveVariable(name: string, ctx: SehirContext): number {
    const map: Record<string, number> = {
        saat: ctx.saat,
        kuyruk: ctx.kuyruk,
        bos_gise: ctx.bos_gise,
        acik_gise: ctx.acik_gise,
        yasli_orani: ctx.yasli_orani,
        memnuniyet: ctx.memnuniyet,
        butce_kalan: ctx.butce_kalan,
        butce: ctx.butce_kalan,
        toplam_islem: ctx.toplam_islem,
        tur: ctx.tur,
    };
    return map[name] ?? 0;
}

function evaluateCondition(cond: ParsedCondition, ctx: SehirContext): boolean {
    const lhs = resolveVariable(cond.variable, ctx);
    const rhs = cond.value;
    switch (cond.operator) {
        case '>': return lhs > rhs;
        case '<': return lhs < rhs;
        case '>=': return lhs >= rhs;
        case '<=': return lhs <= rhs;
        case '==': return lhs === rhs;
        case '!=': return lhs !== rhs;
        default: return false;
    }
}

function parseAction(line: string): { action: CivicAction; param?: number } {
    const l = line.trim().toLowerCase();

    // gise_ac(N) or gise_ac()
    const giseAcMatch = l.match(/gise_ac\((\d*)?\)/);
    if (giseAcMatch) {
        return { action: 'gise_ac', param: giseAcMatch[1] ? parseInt(giseAcMatch[1]) : 1 };
    }

    // gise_kapat(N) or gise_kapat()
    const giseKapatMatch = l.match(/gise_kapat\((\d*)?\)/);
    if (giseKapatMatch) {
        return { action: 'gise_kapat', param: giseKapatMatch[1] ? parseInt(giseKapatMatch[1]) : 1 };
    }

    // oncelik_ver(...)
    if (l.includes('oncelik_ver') || l.includes('öncelik_ver')) {
        return { action: 'oncelik_ver' };
    }

    // mesai_uzat()
    if (l.includes('mesai_uzat')) {
        return { action: 'mesai_uzat' };
    }

    // dijital_yonlendir() or dijital_yönlendir()
    if (l.includes('dijital_yonlendir') || l.includes('dijital_yönlendir')) {
        return { action: 'dijital_yonlendir' };
    }

    // beklet()
    if (l.includes('beklet')) {
        return { action: 'beklet' };
    }

    return { action: 'beklet' }; // default
}

export function parseStrategy(code: string): ParsedBlock[] {
    const lines = code.split('\n').filter(l => l.trim());
    const blocks: ParsedBlock[] = [];
    let currentCondition: ParsedCondition | null = null;
    let isInElse = false;

    for (const line of lines) {
        const trimmed = line.trim();

        // Skip comments and empty lines
        if (trimmed.startsWith('#') || trimmed === '') continue;

        // Skip function definitions
        if (trimmed.startsWith('def ')) continue;
        if (trimmed === 'return' || trimmed.startsWith('return ')) continue;

        // if condition:
        if (trimmed.startsWith('if ') && trimmed.endsWith(':')) {
            const condStr = trimmed.slice(3, -1).trim();
            currentCondition = parseCondition(condStr);
            isInElse = false;
            continue;
        }

        // elif condition:
        if (trimmed.startsWith('elif ') && trimmed.endsWith(':')) {
            const condStr = trimmed.slice(5, -1).trim();
            currentCondition = parseCondition(condStr);
            isInElse = false;
            continue;
        }

        // else:
        if (trimmed === 'else:') {
            isInElse = true;
            currentCondition = null;
            continue;
        }

        // Action line (indented)
        const { action, param } = parseAction(trimmed);
        blocks.push({
            condition: currentCondition ?? undefined,
            isElse: isInElse,
            action,
            param,
        });
    }

    return blocks;
}

export function executeStrategy(blocks: ParsedBlock[], ctx: SehirContext): { action: CivicAction; param?: number } {
    let conditionMet = false;

    for (const block of blocks) {
        if (block.condition) {
            const result = evaluateCondition(block.condition, ctx);
            if (result) {
                conditionMet = true;
                return { action: block.action, param: block.param };
            }
        } else if (block.isElse) {
            if (!conditionMet) {
                return { action: block.action, param: block.param };
            }
        } else {
            // Unconditional action
            return { action: block.action, param: block.param };
        }
    }

    // Default: do nothing
    return { action: 'beklet' };
}

/** Civic strategy templates */
export const STRATEGY_TEMPLATES = {
    efficient: `# Verimli Yönetici
# Yoğun saatlerde gişe aç, sakin saatlerde tasarruf et
if saat > 9 and saat < 17:
    gise_ac(2)
elif kuyruk > 20:
    oncelik_ver("yasli")
else:
    beklet()`,

    citizen: `# Vatandaş Odaklı
# Her zaman vatandaş memnuniyetini öncelikle
if kuyruk > 10:
    gise_ac(3)
elif yasli_orani > 30:
    oncelik_ver("yasli")
else:
    dijital_yonlendir()`,

    budget: `# Bütçe Tasarrufçu
# Minimum maliyetle hizmet ver
if kuyruk > 30:
    gise_ac(1)
elif butce_kalan < 200:
    dijital_yonlendir()
else:
    beklet()`,
};

/** Action display names */
export const ACTION_LABELS: Record<CivicAction, string> = {
    gise_ac: 'Gişe Aç',
    gise_kapat: 'Gişe Kapat',
    oncelik_ver: 'Öncelik Ver',
    mesai_uzat: 'Mesai Uzat',
    dijital_yonlendir: 'Dijitale Yönlendir',
    beklet: 'Beklet',
};
