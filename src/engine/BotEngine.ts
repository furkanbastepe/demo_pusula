/**
 * BotEngine — 16-turlu Şehir Yönetim Simülasyonu (06:00 - 22:00)
 * İki bot aynı 24 saatte vatandaş kuyruğunu yönetir.
 * Skor = toplam vatandaş memnuniyeti.
 */

import { SehirContext, CivicAction, parseStrategy, executeStrategy } from './BotParser';

/* ── Constants ── */
const TOTAL_TURNS = 16;
const START_HOUR = 6;
const MAX_GISE = 6;
const INITIAL_BUDGET = 800;
const GISE_COST_PER_TURN = 20; // her açık gişe tur başına maliyet

/* ── Hourly arrival rates (realistic distribution) ── */
const ARRIVAL_RATES: number[] = [
    3,   // 06:00 — erken
    5,   // 07:00 — açılış
    12,  // 08:00 — yoğun başlangıç
    18,  // 09:00 — pik sabah
    15,  // 10:00
    10,  // 11:00 — hafif düşüş
    8,   // 12:00 — öğle
    7,   // 13:00
    14,  // 14:00 — öğleden sonra pik
    16,  // 15:00
    12,  // 16:00
    8,   // 17:00 — kapanış
    5,   // 18:00
    4,   // 19:00
    3,   // 20:00
    2,   // 21:00 — son
];

/* ── Game State ── */
export interface CityState {
    turnLogs: TurnLog[];
    totalMemnuniyet: number;
    totalIslem: number;
    budgetRemaining: number;
    finalScore: number;
}

export interface TurnLog {
    saat: number;
    gelenVatandas: number;
    kuyruk: number;
    acikGise: number;
    action: CivicAction;
    param?: number;
    islemYapilan: number;
    memnuniyet: number;
    budgetKalan: number;
}

interface SimState {
    kuyruk: number;
    acikGise: number;
    memnuniyet: number;
    butce: number;
    toplamIslem: number;
    yasliOrani: number;
}

/* ── Simulation ── */
function createInitialSimState(): SimState {
    return {
        kuyruk: 0,
        acikGise: 2,
        memnuniyet: 70,
        butce: INITIAL_BUDGET,
        toplamIslem: 0,
        yasliOrani: 25, // fixed for simplicity
    };
}

function applyAction(simState: SimState, action: CivicAction, param?: number): void {
    switch (action) {
        case 'gise_ac': {
            const count = param ?? 1;
            const newTotal = Math.min(MAX_GISE, simState.acikGise + count);
            simState.acikGise = newTotal;
            break;
        }
        case 'gise_kapat': {
            const count = param ?? 1;
            simState.acikGise = Math.max(1, simState.acikGise - count);
            break;
        }
        case 'oncelik_ver':
            // Reduces effective queue for elderly — bonus memnuniyet
            simState.memnuniyet = Math.min(100, simState.memnuniyet + 3);
            break;
        case 'mesai_uzat':
            // Costs more budget but processes extra people
            simState.butce -= 30;
            simState.kuyruk = Math.max(0, simState.kuyruk - 5);
            simState.toplamIslem += 5;
            break;
        case 'dijital_yonlendir':
            // Moves some people out of physical queue
            const diverted = Math.min(simState.kuyruk, Math.floor(simState.kuyruk * 0.3));
            simState.kuyruk -= diverted;
            simState.toplamIslem += diverted;
            simState.memnuniyet = Math.min(100, simState.memnuniyet + 1);
            break;
        case 'beklet':
            // Do nothing — might hurt memnuniyet
            break;
    }
}

function simulateTurn(simState: SimState, tur: number, strategy: ReturnType<typeof parseStrategy>): TurnLog {
    const saat = START_HOUR + tur;
    const gelenVatandas = ARRIVAL_RATES[tur] + Math.floor(Math.random() * 4) - 2; // +/- 2 randomness

    // Add arrivals to queue
    simState.kuyruk += Math.max(0, gelenVatandas);

    // Build context for strategy
    const ctx: SehirContext = {
        saat,
        kuyruk: simState.kuyruk,
        bos_gise: MAX_GISE - simState.acikGise,
        acik_gise: simState.acikGise,
        yasli_orani: simState.yasliOrani,
        memnuniyet: simState.memnuniyet,
        butce_kalan: simState.butce,
        toplam_islem: simState.toplamIslem,
        tur,
    };

    // Execute strategy
    const { action, param } = executeStrategy(strategy, ctx);
    applyAction(simState, action, param);

    // Process queue (each gişe handles ~3 people per hour)
    const processed = Math.min(simState.kuyruk, simState.acikGise * 3);
    simState.kuyruk = Math.max(0, simState.kuyruk - processed);
    simState.toplamIslem += processed;

    // Operating cost for open gişe
    simState.butce -= simState.acikGise * GISE_COST_PER_TURN;

    // Calculate memnuniyet based on queue length
    if (simState.kuyruk > 25) {
        simState.memnuniyet = Math.max(0, simState.memnuniyet - 5);
    } else if (simState.kuyruk > 15) {
        simState.memnuniyet = Math.max(0, simState.memnuniyet - 2);
    } else if (simState.kuyruk > 5) {
        simState.memnuniyet = Math.max(0, simState.memnuniyet - 0.5);
    } else {
        simState.memnuniyet = Math.min(100, simState.memnuniyet + 1);
    }

    return {
        saat,
        gelenVatandas: Math.max(0, gelenVatandas),
        kuyruk: simState.kuyruk,
        acikGise: simState.acikGise,
        action,
        param,
        islemYapilan: processed,
        memnuniyet: Math.round(simState.memnuniyet),
        budgetKalan: Math.max(0, simState.butce),
    };
}

export function runFullSimulation(strategyCode: string): CityState {
    const strategy = parseStrategy(strategyCode);
    const simState = createInitialSimState();
    const turnLogs: TurnLog[] = [];

    for (let tur = 0; tur < TOTAL_TURNS; tur++) {
        const log = simulateTurn(simState, tur, strategy);
        turnLogs.push(log);
    }

    return {
        turnLogs,
        totalMemnuniyet: Math.round(simState.memnuniyet),
        totalIslem: simState.toplamIslem,
        budgetRemaining: Math.max(0, simState.butce),
        finalScore: Math.round(
            simState.memnuniyet * 0.5 +
            Math.min(100, (simState.toplamIslem / 150) * 100) * 0.3 +
            Math.min(100, (Math.max(0, simState.butce) / INITIAL_BUDGET) * 100) * 0.2
        ),
    };
}

/** Pre-built opponent strategies for demo */
export const OPPONENT_STRATEGIES = {
    lazy: `# Tembel Müdür
# Sadece çok kötü durumda müdahale eder
if kuyruk > 30:
    gise_ac(1)
else:
    beklet()`,

    reactive: `# Reaktif Müdür
# Kuyruk uzayınca hızlıca müdahale eder
if kuyruk > 15:
    gise_ac(2)
elif kuyruk < 5:
    gise_kapat(1)
else:
    beklet()`,

    balanced: `# Dengeli Müdür
# Saat bazında plan yapar
if saat > 8 and saat < 17:
    gise_ac(1)
elif kuyruk > 20:
    mesai_uzat()
else:
    beklet()`,
};
