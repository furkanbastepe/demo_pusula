import { useState, useEffect, useCallback, useRef } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

type Stage = 'intro' | 'red_set' | 'yellow_set' | 'green_set' | 'car_waiting' | 'car_moving' | 'speed_done' | 'types_lesson';

const VALID_COLORS = ['kırmızı', 'kirmizi', 'sarı', 'sari', 'yeşil', 'yesil'] as const;

function normalizeColor(val: string): 'kırmızı' | 'sarı' | 'yeşil' | null {
    const v = val.trim().toLowerCase().replace(/"/g, '').replace(/'/g, '');
    if (v === 'kırmızı' || v === 'kirmizi') return 'kırmızı';
    if (v === 'sarı' || v === 'sari') return 'sarı';
    if (v === 'yeşil' || v === 'yesil') return 'yeşil';
    return null;
}

function parseVariable(line: string): { name: string; value: string } | null {
    const match = line.match(/^\s*(\w+)\s*=\s*(.+)\s*$/);
    if (!match) return null;
    return { name: match[1], value: match[2].trim() };
}

export default function WarmupLab() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);

    const isUnlocked = state.stage !== 'intro';

    /* ── State ── */
    const [stage, setStage] = useState<Stage>('intro');
    const [codeLines, setCodeLines] = useState<string[]>([
        'trafik_lambasi = "kırmızı"',
    ]);
    const [activeLight, setActiveLight] = useState<'kırmızı' | 'sarı' | 'yeşil' | null>(null);
    const [carSpeed, setCarSpeed] = useState(0);
    const [carPosition, setCarPosition] = useState(-80);
    const [feedback, setFeedback] = useState('');
    const [feedbackType, setFeedbackType] = useState<'info' | 'success' | 'error' | 'hint'>('info');
    const [colorHistory, setColorHistory] = useState<string[]>([]);
    const [showTypesLesson, setShowTypesLesson] = useState(false);
    const [typesStep, setTypesStep] = useState(0);
    const [wrongAttempts, setWrongAttempts] = useState(0);
    const [showDebugReflection, setShowDebugReflection] = useState(false);
    const [lastErrorType, setLastErrorType] = useState<string>('');
    const inputRef = useRef<HTMLInputElement>(null);
    const carAnimRef = useRef<number | null>(null);

    /* ── Car animation loop ── */
    useEffect(() => {
        if (stage === 'car_moving' && carSpeed > 0) {
            const animate = () => {
                setCarPosition(prev => {
                    const next = prev + carSpeed * 0.03;
                    if (next > 520) {
                        setStage('speed_done');
                        setFeedback('🏁 Harika! Araba geçti! Sen az önce değişkenlerle bir sistemi kontrol ettin. Şimdi veri tiplerini öğrenelim.');
                        setFeedbackType('success');
                        return 520;
                    }
                    return next;
                });
                carAnimRef.current = requestAnimationFrame(animate);
            };
            carAnimRef.current = requestAnimationFrame(animate);
            return () => { if (carAnimRef.current) cancelAnimationFrame(carAnimRef.current); };
        }
    }, [stage, carSpeed]);

    /* ── Execute the code ── */
    const executeCode = useCallback(() => {
        const code = codeLines.join('\n');
        const lines = code.split('\n').filter(l => l.trim());

        let foundLamba = false;
        let foundHiz = false;
        let lambaValue: 'kırmızı' | 'sarı' | 'yeşil' | null = null;
        let hizValue: number | null = null;

        for (const line of lines) {
            const parsed = parseVariable(line);
            if (!parsed) continue;

            if (parsed.name === 'trafik_lambasi') {
                foundLamba = true;
                // Must be a string in quotes
                const strMatch = parsed.value.match(/^["'](.+)["']$/);
                if (!strMatch) {
                    setWrongAttempts(prev => prev + 1);
                    setLastErrorType('missing_quotes');
                    const hints = [
                        '🤔 Hmm, bir şey eksik... Bilgisayar bunu metin olarak tanıyamadı. Ne yapmalıydın?',
                        '💡 İpucu: Metin değerler tırnak işareti içinde yazılır. Örneğin: "kırmızı"',
                        '✏️ trafik_lambasi = "kırmızı" şeklinde yaz. Tırnak işaretleri string olduğunu belirtir.',
                    ];
                    setFeedback(hints[Math.min(wrongAttempts, 2)]);
                    setFeedbackType('error');
                    return;
                }
                const color = normalizeColor(strMatch[1]);
                if (!color) {
                    setWrongAttempts(prev => prev + 1);
                    setLastErrorType('wrong_color');
                    const hints = [
                        '🤔 Renk tanınmadı. Trafik lambasında hangi 3 renk var?',
                        '💡 Sadece 3 renk geçerli: "kırmızı", "sarı", "yeşil". Türkçe karakterlere dikkat!',
                        '✏️ Tam olarak şunu yaz: trafik_lambasi = "kırmızı" (veya "sarı" veya "yeşil")',
                    ];
                    setFeedback(hints[Math.min(wrongAttempts, 2)]);
                    setFeedbackType('error');
                    return;
                }
                lambaValue = color;
            }

            if (parsed.name === 'araba_hizi') {
                foundHiz = true;
                const num = parseInt(parsed.value, 10);
                if (isNaN(num)) {
                    setWrongAttempts(prev => prev + 1);
                    setLastErrorType('wrong_type_speed');
                    const hints = [
                        '🤔 araba_hizi bir metin değil... Hangi veri tipi sayıları temsil eder?',
                        '💡 Sayılar tırnak işareti OLMADAN yazılır! araba_hizi = 100 gibi.',
                        '✏️ Tırnakları kaldır: araba_hizi = 100 yaz. Bu bir integer (tam sayı).',
                    ];
                    setFeedback(hints[Math.min(wrongAttempts, 2)]);
                    setFeedbackType('error');
                    return;
                }
                hizValue = num;
            }
        }

        /* ── Stage transitions ── */
        if (foundLamba && lambaValue) {
            // Show debug reflection if student just fixed an error
            if (wrongAttempts > 0 && !showDebugReflection) {
                setShowDebugReflection(true);
            }
            setWrongAttempts(0); // Reset on success
            setActiveLight(lambaValue);

            if (lambaValue === 'kırmızı') {
                if (!colorHistory.includes('kırmızı')) setColorHistory(prev => [...prev, 'kırmızı']);
                setStage('red_set');
                setFeedback('🔴 Kırmızı yandı! DUR. Şimdi kodu değiştir → trafik_lambasi = "sarı" yaz ve Çalıştır\'a bas.');
                setFeedbackType('hint');
            } else if (lambaValue === 'sarı') {
                if (!colorHistory.includes('sarı')) setColorHistory(prev => [...prev, 'sarı']);
                setStage('yellow_set');
                setFeedback('🟡 Sarı yandı! HAZIRLAN. Şimdi kodu değiştir → trafik_lambasi = "yeşil" yaz ve Çalıştır\'a bas.');
                setFeedbackType('hint');
            } else if (lambaValue === 'yeşil') {
                if (!colorHistory.includes('yeşil')) setColorHistory(prev => [...prev, 'yeşil']);
                setStage('car_waiting');
                setCarPosition(-80);
                setCarSpeed(0);
                setFeedback('🟢 Yeşil yandı! GEÇ. Araba geldi ama duruyor. Yeni bir satır ekle → araba_hizi = 100 yaz ve Çalıştır\'a bas!');
                setFeedbackType('success');

                // Add the araba_hizi line if not present
                if (!code.includes('araba_hizi')) {
                    setCodeLines(prev => [...prev, 'araba_hizi = 0']);
                }
            }
        }

        if (foundHiz && hizValue !== null && (stage === 'car_waiting' || stage === 'car_moving')) {
            if (activeLight !== 'yeşil') {
                setFeedback('⚠️ Lamba yeşil değilken araba gidemez! Önce trafik_lambasi = "yeşil" yap.');
                setFeedbackType('error');
                return;
            }
            setCarSpeed(hizValue);
            if (hizValue > 0 && hizValue < 100) {
                setStage('car_moving');
                setFeedback(`🚗 Araba ${hizValue} km/h hızla gidiyor... Ama yeterince hızlı değil! araba_hizi = 100 yap.`);
                setFeedbackType('hint');
            } else if (hizValue >= 100) {
                setStage('car_moving');
                setFeedback(`🚀 Araba ${hizValue} km/h ile hızlanıyor! İzle...`);
                setFeedbackType('success');
            } else if (hizValue <= 0) {
                setFeedback('💤 Araba duruyor. araba_hizi değerini 100 yap!');
                setFeedbackType('hint');
            }
        }

        if (!foundLamba && !foundHiz) {
            setWrongAttempts(prev => prev + 1);
            setLastErrorType('no_variable');
            const hints = [
                '🤔 Bilgisayar bu kodu anlamadı. Bir değişken tanımlamayı dene: degisken_adi = deger',
                '💡 Değişken adı önemli! trafik_lambasi veya araba_hizi kullanmalısın.',
                '✏️ Şunu yaz: trafik_lambasi = "kırmızı" — bu ilk adımın olacak.',
            ];
            setFeedback(hints[Math.min(wrongAttempts, 2)]);
            setFeedbackType('error');
        }
    }, [codeLines, stage, activeLight, colorHistory, wrongAttempts, showDebugReflection]);

    const handleProceed = useCallback(() => {
        dispatch({ type: 'COMPLETE_WARMUP' });
        document.getElementById('meridyen')?.scrollIntoView({ behavior: 'smooth' });
    }, [dispatch]);

    const lightColor = (color: 'kırmızı' | 'sarı' | 'yeşil') => {
        if (activeLight === color) {
            if (color === 'kırmızı') return '#EF4444';
            if (color === 'sarı') return '#FBBF24';
            if (color === 'yeşil') return '#34D399';
        }
        return 'var(--bg-void)';
    };

    const lightStroke = (color: 'kırmızı' | 'sarı' | 'yeşil') => {
        if (activeLight === color) {
            if (color === 'kırmızı') return '#EF4444';
            if (color === 'sarı') return '#FBBF24';
            if (color === 'yeşil') return '#34D399';
        }
        return 'var(--border-dim)';
    };

    /* ── Data types lesson content ── */
    const typesContent = [
        {
            title: 'String (Metin)',
            icon: '📝',
            color: 'var(--accent-violet)',
            code: 'trafik_lambasi = "kırmızı"',
            explanation: 'Tırnak içinde yazılan her şey bir string\'dir (metin). "kırmızı", "sarı", "yeşil" gibi kelimeler birer string.',
            examples: ['isim = "Deniz"', 'sehir = "İstanbul"', 'renk = "mavi"'],
            highlight: 'String = Tırnak içinde metin',
        },
        {
            title: 'Integer (Tam Sayı)',
            icon: '🔢',
            color: 'var(--accent-cyan)',
            code: 'araba_hizi = 100',
            explanation: 'Tırnak işareti olmadan yazılan sayılar integer\'dır (tam sayı). 100, 42, 0 gibi. Matematiksel işlem yapabilirsin.',
            examples: ['yas = 22', 'hiz = 100', 'puan = 85'],
            highlight: 'Integer = Tırnaksız sayı',
        },
        {
            title: 'Boolean (Doğru/Yanlış)',
            icon: '✅',
            color: 'var(--accent-emerald)',
            code: 'lamba_yandi = True',
            explanation: 'Sadece iki değer alabilir: True (doğru) veya False (yanlış). Kontrol ve karar yapıları için kullanılır.',
            examples: ['lamba_yandi = True', 'araba_gecti = False', 'hazir_mi = True'],
            highlight: 'Boolean = True veya False',
        },
    ];

    return (
        <section className="section" id="warmup-lab" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className={`container ${!isUnlocked ? 'gate--locked' : ''}`}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <polyline points="16 18 22 12 16 6" /><polyline points="8 6 2 12 8 18" />
                    </svg>
                    Kodlama Laboratuvarı
                </div>
                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Kodla <span style={{ color: 'var(--accent-emerald)' }}>Kontrol Et</span>
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Değişkenleri değiştirerek trafik lambasını kontrol et. Kodun gücünü ilk elden deneyimle.
                </p>

                {!showTypesLesson ? (
                    <div className={`traffic-light-container reveal ${isVisible ? 'visible' : ''} delay-3`}>
                        {/* LEFT: Traffic Light + Road Scene */}
                        <div className="traffic-light" style={{ position: 'relative' }}>
                            {/* Traffic Light SVG */}
                            <svg width="100" height="260" viewBox="0 0 100 260" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <rect x="15" y="10" width="70" height="200" rx="16" fill="var(--bg-nebula)" stroke="var(--border-dim)" strokeWidth="2" />
                                {/* Red */}
                                <circle cx="50" cy="55" r="26" fill={lightColor('kırmızı')} stroke={lightStroke('kırmızı')} strokeWidth="2">
                                    {activeLight === 'kırmızı' && <animate attributeName="opacity" values="1;0.7;1" dur="1s" repeatCount="indefinite" />}
                                </circle>
                                {activeLight === 'kırmızı' && <circle cx="50" cy="55" r="26" fill="none" stroke="#EF4444" strokeWidth="1" opacity="0.3"><animate attributeName="r" values="26;38" dur="1.5s" repeatCount="indefinite" /><animate attributeName="opacity" values="0.3;0" dur="1.5s" repeatCount="indefinite" /></circle>}
                                <text x="50" y="59" textAnchor="middle" fill={activeLight === 'kırmızı' ? '#fff' : 'var(--text-muted)'} fontSize="11" fontFamily="var(--font-display)" fontWeight="700">DUR</text>

                                {/* Yellow */}
                                <circle cx="50" cy="115" r="26" fill={lightColor('sarı')} stroke={lightStroke('sarı')} strokeWidth="2">
                                    {activeLight === 'sarı' && <animate attributeName="opacity" values="1;0.7;1" dur="0.5s" repeatCount="indefinite" />}
                                </circle>
                                {activeLight === 'sarı' && <circle cx="50" cy="115" r="26" fill="none" stroke="#FBBF24" strokeWidth="1" opacity="0.3"><animate attributeName="r" values="26;38" dur="1.5s" repeatCount="indefinite" /><animate attributeName="opacity" values="0.3;0" dur="1.5s" repeatCount="indefinite" /></circle>}
                                <text x="50" y="119" textAnchor="middle" fill={activeLight === 'sarı' ? '#000' : 'var(--text-muted)'} fontSize="9" fontFamily="var(--font-display)" fontWeight="700">HAZIR</text>

                                {/* Green */}
                                <circle cx="50" cy="175" r="26" fill={lightColor('yeşil')} stroke={lightStroke('yeşil')} strokeWidth="2" />
                                {activeLight === 'yeşil' && <circle cx="50" cy="175" r="26" fill="none" stroke="#34D399" strokeWidth="1" opacity="0.3"><animate attributeName="r" values="26;38" dur="1.5s" repeatCount="indefinite" /><animate attributeName="opacity" values="0.3;0" dur="1.5s" repeatCount="indefinite" /></circle>}
                                <text x="50" y="179" textAnchor="middle" fill={activeLight === 'yeşil' ? '#fff' : 'var(--text-muted)'} fontSize="10" fontFamily="var(--font-display)" fontWeight="700">GEÇ</text>

                                {/* Pole */}
                                <rect x="42" y="210" width="16" height="50" fill="var(--bg-nebula)" stroke="var(--border-dim)" strokeWidth="1.5" />
                            </svg>

                            {/* Road + Car scene */}
                            {(stage === 'car_waiting' || stage === 'car_moving' || stage === 'speed_done') && (
                                <svg width="500" height="120" viewBox="0 0 500 120" fill="none" xmlns="http://www.w3.org/2000/svg" style={{ position: 'absolute', bottom: '-30px', left: '-40px' }}>
                                    {/* Road */}
                                    <rect x="0" y="40" width="500" height="50" rx="4" fill="var(--bg-nebula)" stroke="var(--border-dim)" strokeWidth="1" />
                                    {/* Road dashes */}
                                    {[0, 60, 120, 180, 240, 300, 360, 420].map(x => (
                                        <rect key={x} x={x + 15} y="62" width="30" height="4" rx="2" fill="var(--accent-amber)" opacity="0.4" />
                                    ))}
                                    {/* Finish line */}
                                    <rect x="480" y="40" width="4" height="50" fill="var(--accent-emerald)" opacity="0.6" />
                                    <text x="488" y="35" fill="var(--accent-emerald)" fontSize="10" fontFamily="var(--font-mono)">🏁</text>

                                    {/* Car */}
                                    <g transform={`translate(${carPosition}, 30)`} style={{ transition: stage === 'car_moving' ? 'none' : 'transform 0.3s ease' }}>
                                        {/* Car body */}
                                        <rect x="8" y="18" width="55" height="22" rx="4" fill="var(--accent-cyan)" />
                                        <rect x="16" y="8" width="35" height="16" rx="4" fill="rgba(56,189,248,0.7)" />
                                        {/* Windshield */}
                                        <rect x="38" y="10" width="11" height="12" rx="2" fill="rgba(56,189,248,0.3)" stroke="var(--accent-cyan)" strokeWidth="0.5" />
                                        {/* Headlights */}
                                        <circle cx="63" cy="28" r="3" fill="#FBBF24" />
                                        {carSpeed > 0 && <circle cx="63" cy="28" r="3" fill="#FBBF24" opacity="0.3"><animate attributeName="r" values="3;8" dur="0.8s" repeatCount="indefinite" /><animate attributeName="opacity" values="0.4;0" dur="0.8s" repeatCount="indefinite" /></circle>}
                                        {/* Wheels */}
                                        <circle cx="20" cy="42" r="6" fill="var(--bg-void)" stroke="var(--text-muted)" strokeWidth="1.5">
                                            {carSpeed > 0 && <animateTransform attributeName="transform" type="rotate" from="0 20 42" to="360 20 42" dur={`${Math.max(0.1, 1 - carSpeed / 150)}s`} repeatCount="indefinite" />}
                                        </circle>
                                        <circle cx="50" cy="42" r="6" fill="var(--bg-void)" stroke="var(--text-muted)" strokeWidth="1.5">
                                            {carSpeed > 0 && <animateTransform attributeName="transform" type="rotate" from="0 50 42" to="360 50 42" dur={`${Math.max(0.1, 1 - carSpeed / 150)}s`} repeatCount="indefinite" />}
                                        </circle>
                                        {/* Speed trail */}
                                        {carSpeed > 50 && (
                                            <>
                                                <line x1="5" y1="25" x2={-carSpeed / 5} y2="25" stroke="var(--accent-cyan)" strokeWidth="1.5" opacity="0.3" />
                                                <line x1="5" y1="30" x2={-carSpeed / 4} y2="30" stroke="var(--accent-cyan)" strokeWidth="1" opacity="0.2" />
                                                <line x1="5" y1="35" x2={-carSpeed / 6} y2="35" stroke="var(--accent-cyan)" strokeWidth="1" opacity="0.15" />
                                            </>
                                        )}
                                    </g>

                                    {/* Speed indicator */}
                                    <text x="250" y="110" textAnchor="middle" fill="var(--accent-cyan)" fontSize="12" fontFamily="var(--font-mono)" fontWeight="700">
                                        🚗 {carSpeed} km/h
                                    </text>
                                </svg>
                            )}
                        </div>

                        {/* RIGHT: Code Editor + Feedback */}
                        <div className="traffic-controls">
                            {/* Code Editor */}
                            <div className="card" style={{ padding: 0, overflow: 'hidden' }}>
                                {/* Editor title bar */}
                                <div style={{
                                    padding: '0.625rem 1rem',
                                    background: 'var(--bg-void)',
                                    borderBottom: '1px solid var(--border-dim)',
                                    display: 'flex',
                                    alignItems: 'center',
                                    gap: '0.5rem',
                                }}>
                                    <div style={{ display: 'flex', gap: '5px' }}>
                                        <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#EF4444' }} />
                                        <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#FBBF24' }} />
                                        <span style={{ width: '10px', height: '10px', borderRadius: '50%', background: '#34D399' }} />
                                    </div>
                                    <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.75rem', color: 'var(--text-muted)', marginLeft: '0.5rem' }}>
                                        trafik_lambasi.py
                                    </span>
                                </div>

                                {/* Code area */}
                                <div style={{ padding: '1rem', background: 'rgba(5,10,25,0.8)' }}>
                                    {codeLines.map((line, i) => (
                                        <div key={i} style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.5rem' }}>
                                            <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.7rem', color: 'var(--text-muted)', width: '20px', textAlign: 'right', flexShrink: 0 }}>
                                                {i + 1}
                                            </span>
                                            <input
                                                ref={i === codeLines.length - 1 ? inputRef : undefined}
                                                type="text"
                                                value={line}
                                                onChange={e => {
                                                    const newLines = [...codeLines];
                                                    newLines[i] = e.target.value;
                                                    setCodeLines(newLines);
                                                }}
                                                style={{
                                                    flex: 1,
                                                    fontFamily: 'var(--font-mono)',
                                                    fontSize: '0.9rem',
                                                    background: 'transparent',
                                                    border: 'none',
                                                    outline: 'none',
                                                    color: 'var(--text-primary)',
                                                    padding: '0.375rem 0',
                                                    borderBottom: '1px solid rgba(255,255,255,0.05)',
                                                    letterSpacing: '0.02em',
                                                }}
                                                spellCheck={false}
                                            />
                                        </div>
                                    ))}
                                </div>

                                {/* Run button */}
                                <div style={{ padding: '0.75rem 1rem', borderTop: '1px solid var(--border-dim)', display: 'flex', gap: '0.75rem', alignItems: 'center' }}>
                                    <button className="btn btn--primary" onClick={executeCode} style={{ fontSize: '0.85rem', padding: '0.5rem 1.25rem' }}>
                                        <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor" stroke="none" style={{ marginRight: '0.375rem' }}>
                                            <polygon points="5 3 19 12 5 21 5 3" />
                                        </svg>
                                        Çalıştır
                                    </button>
                                    <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                                        Ctrl + Enter
                                    </span>
                                </div>
                            </div>

                            {/* Feedback console */}
                            {feedback && (
                                <div className={`code-feedback code-feedback--${feedbackType}`} style={{ marginTop: '1rem' }}>
                                    <div style={{ display: 'flex', alignItems: 'flex-start', gap: '0.5rem' }}>
                                        <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.75rem', color: 'var(--text-muted)', flexShrink: 0 }}>{'>'}</span>
                                        <span style={{ fontSize: '0.85rem', lineHeight: '1.7' }}>{feedback}</span>
                                    </div>
                                    {wrongAttempts > 0 && (
                                        <div style={{ marginTop: '0.5rem', display: 'flex', alignItems: 'center', gap: '0.375rem' }}>
                                            {Array.from({ length: Math.min(wrongAttempts, 3) }).map((_, i) => (
                                                <span key={i} style={{ width: '6px', height: '6px', borderRadius: '50%', background: i < wrongAttempts ? 'var(--accent-rose)' : 'var(--border-dim)' }} />
                                            ))}
                                            <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)', marginLeft: '0.25rem' }}>
                                                {wrongAttempts === 1 ? 'İlk deneme' : wrongAttempts === 2 ? 'İkinci deneme — yaklaşıyorsun!' : 'Üçüncü deneme — detaylı ipucu açıldı'}
                                            </span>
                                        </div>
                                    )}
                                </div>
                            )}

                            {/* Debug Reflection Card — Productive Failure moment */}
                            {showDebugReflection && (
                                <div className="card" style={{ marginTop: '0.75rem', borderColor: 'rgba(167,139,250,0.2)', background: 'rgba(167,139,250,0.04)' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.5rem', marginBottom: '0.5rem' }}>
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                            <circle cx="12" cy="12" r="10" /><line x1="12" y1="16" x2="12" y2="12" /><line x1="12" y1="8" x2="12.01" y2="8" />
                                        </svg>
                                        <span style={{ fontSize: '0.85rem', fontWeight: 700, color: 'var(--accent-violet)' }}>PUSULA Mentor — Hata Analizi</span>
                                        <button onClick={() => setShowDebugReflection(false)} style={{ marginLeft: 'auto', background: 'none', border: 'none', color: 'var(--text-muted)', cursor: 'pointer', fontSize: '0.8rem' }}>✕</button>
                                    </div>
                                    <p style={{ fontSize: '0.8rem', color: 'var(--text-secondary)', lineHeight: 1.7, margin: 0 }}>
                                        {lastErrorType === 'missing_quotes' && (
                                            <>🏆 <strong style={{ color: 'var(--accent-emerald)' }}>Tebrikler, hatayı düzelttin!</strong> Bilgisayar metin (string) ile sayı (integer) farklı tanır. Tırnak işaretleri bilgisayara "bu bir metin" der. Hata yapmak öğrenmenin en güçlü yoludur.</>
                                        )}
                                        {lastErrorType === 'wrong_color' && (
                                            <>🏆 <strong style={{ color: 'var(--accent-emerald)' }}>Doğru rengi buldun!</strong> Yazılımda tam eşleşme önemlidir — "kirmizi" ≠ "kırmızı". Gerçek programcılar da sürekli bu tür hataları ayıklar (debug eder).</>
                                        )}
                                        {lastErrorType === 'wrong_type_speed' && (
                                            <>🏆 <strong style={{ color: 'var(--accent-emerald)' }}>Veri tipini anladın!</strong> "100" (string) ile 100 (integer) bilgisayar için farklıdır. String ile matematik yapamazsın, integer ile metin oluşturamazsın.</>
                                        )}
                                        {lastErrorType === 'no_variable' && (
                                            <>🏆 <strong style={{ color: 'var(--accent-emerald)' }}>Değişken tanımını öğrendin!</strong> Bilgisayar sadece tanımladığın değişkenleri tanır. Her değişkenin bir adı ve değeri olmalı: ad = değer.</>
                                        )}
                                    </p>
                                </div>
                            )}

                            {/* Color progress */}
                            <div style={{ marginTop: '1rem', display: 'flex', gap: '0.5rem', alignItems: 'center' }}>
                                <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>İlerleme:</span>
                                {['kırmızı', 'sarı', 'yeşil'].map(c => (
                                    <span
                                        key={c}
                                        style={{
                                            padding: '0.2rem 0.6rem',
                                            borderRadius: '6px',
                                            fontSize: '0.7rem',
                                            fontWeight: 600,
                                            fontFamily: 'var(--font-mono)',
                                            background: colorHistory.includes(c)
                                                ? c === 'kırmızı' ? 'rgba(239,68,68,0.2)' : c === 'sarı' ? 'rgba(251,191,36,0.2)' : 'rgba(52,211,153,0.2)'
                                                : 'var(--bg-nebula)',
                                            color: colorHistory.includes(c)
                                                ? c === 'kırmızı' ? '#EF4444' : c === 'sarı' ? '#FBBF24' : '#34D399'
                                                : 'var(--text-muted)',
                                            border: `1px solid ${colorHistory.includes(c)
                                                ? c === 'kırmızı' ? 'rgba(239,68,68,0.3)' : c === 'sarı' ? 'rgba(251,191,36,0.3)' : 'rgba(52,211,153,0.3)'
                                                : 'var(--border-dim)'}`,
                                        }}
                                    >
                                        {colorHistory.includes(c) ? '✓ ' : ''}{c}
                                    </span>
                                ))}
                                {stage === 'speed_done' && (
                                    <span style={{
                                        padding: '0.2rem 0.6rem', borderRadius: '6px', fontSize: '0.7rem', fontWeight: 600,
                                        fontFamily: 'var(--font-mono)', background: 'rgba(56,189,248,0.2)', color: 'var(--accent-cyan)',
                                        border: '1px solid rgba(56,189,248,0.3)',
                                    }}>
                                        ✓ araba
                                    </span>
                                )}
                            </div>

                            {/* STAGE: Types lesson trigger */}
                            {stage === 'speed_done' && (
                                <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                                    <button className="btn btn--secondary" onClick={() => { setShowTypesLesson(true); setTypesStep(0); }}>
                                        🎓 Veri Tiplerini Öğren →
                                    </button>
                                </div>
                            )}
                        </div>
                    </div>
                ) : (
                    /* ── DATA TYPES LESSON ── */
                    <div className={`reveal ${isVisible ? 'visible' : ''} delay-3`}>
                        <div style={{ display: 'flex', gap: '1rem', marginBottom: '2rem', justifyContent: 'center' }}>
                            {typesContent.map((t, i) => (
                                <button
                                    key={i}
                                    onClick={() => setTypesStep(i)}
                                    className={`btn ${typesStep === i ? 'btn--primary' : 'btn--secondary'}`}
                                    style={{ fontSize: '0.85rem', padding: '0.5rem 1rem' }}
                                >
                                    {t.icon} {t.title}
                                </button>
                            ))}
                        </div>

                        {/* Active type card */}
                        <div className="card" style={{ borderColor: `color-mix(in srgb, ${typesContent[typesStep].color} 30%, transparent)`, maxWidth: '700px', margin: '0 auto' }}>
                            <h3 style={{ fontSize: '1.2rem', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                                <span style={{ fontSize: '1.5rem' }}>{typesContent[typesStep].icon}</span>
                                <span style={{ color: typesContent[typesStep].color }}>{typesContent[typesStep].title}</span>
                            </h3>

                            {/* Code example */}
                            <div style={{
                                padding: '1rem 1.25rem',
                                background: 'rgba(5,10,25,0.8)',
                                borderRadius: '10px',
                                border: '1px solid var(--border-dim)',
                                fontFamily: 'var(--font-mono)',
                                fontSize: '1.05rem',
                                color: typesContent[typesStep].color,
                                marginBottom: '1.25rem',
                                letterSpacing: '0.02em',
                            }}>
                                {typesContent[typesStep].code}
                            </div>

                            <p style={{ fontSize: '0.95rem', lineHeight: '1.9', color: 'var(--text-secondary)', marginBottom: '1.25rem' }}>
                                {typesContent[typesStep].explanation}
                            </p>

                            {/* Key takeaway badge */}
                            <div style={{
                                display: 'inline-block',
                                padding: '0.5rem 1rem',
                                borderRadius: '8px',
                                background: `color-mix(in srgb, ${typesContent[typesStep].color} 10%, transparent)`,
                                border: `1px solid color-mix(in srgb, ${typesContent[typesStep].color} 25%, transparent)`,
                                color: typesContent[typesStep].color,
                                fontWeight: 700,
                                fontSize: '0.9rem',
                                fontFamily: 'var(--font-display)',
                                marginBottom: '1.25rem',
                            }}>
                                💡 {typesContent[typesStep].highlight}
                            </div>

                            {/* Examples */}
                            <h4 style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '0.75rem', textTransform: 'uppercase', letterSpacing: '0.1em' }}>Örnekler</h4>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                                {typesContent[typesStep].examples.map((ex, j) => (
                                    <div key={j} style={{
                                        padding: '0.5rem 1rem',
                                        background: 'var(--bg-void)',
                                        borderRadius: '6px',
                                        border: '1px solid var(--border-dim)',
                                        fontFamily: 'var(--font-mono)',
                                        fontSize: '0.85rem',
                                        color: 'var(--text-primary)',
                                        display: 'flex',
                                        alignItems: 'center',
                                        gap: '0.5rem',
                                    }}>
                                        <span style={{ color: 'var(--text-muted)', fontSize: '0.75rem' }}>{j + 1}.</span>
                                        {ex}
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* What you learned summary */}
                        <div className="card" style={{ marginTop: '1.5rem', maxWidth: '700px', margin: '1.5rem auto 0', borderColor: 'rgba(52,211,153,0.15)' }}>
                            <h3 style={{ fontSize: '1rem', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" />
                                </svg>
                                Az Önce Ne Öğrendin?
                            </h3>
                            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(3, 1fr)', gap: '0.75rem' }}>
                                <div style={{ textAlign: 'center', padding: '0.75rem', borderRadius: '8px', background: 'rgba(167,139,250,0.08)', border: '1px solid rgba(167,139,250,0.15)' }}>
                                    <div style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--accent-violet)', marginBottom: '0.25rem' }}>String</div>
                                    <div style={{ fontFamily: 'var(--font-mono)', fontSize: '0.75rem', color: 'var(--text-muted)' }}>"kırmızı"</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.75rem', borderRadius: '8px', background: 'rgba(56,189,248,0.08)', border: '1px solid rgba(56,189,248,0.15)' }}>
                                    <div style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--accent-cyan)', marginBottom: '0.25rem' }}>Integer</div>
                                    <div style={{ fontFamily: 'var(--font-mono)', fontSize: '0.75rem', color: 'var(--text-muted)' }}>100</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.75rem', borderRadius: '8px', background: 'rgba(52,211,153,0.08)', border: '1px solid rgba(52,211,153,0.15)' }}>
                                    <div style={{ fontSize: '0.8rem', fontWeight: 700, color: 'var(--accent-emerald)', marginBottom: '0.25rem' }}>Boolean</div>
                                    <div style={{ fontFamily: 'var(--font-mono)', fontSize: '0.75rem', color: 'var(--text-muted)' }}>True</div>
                                </div>
                            </div>
                        </div>

                        {/* Proceed button */}
                        <div style={{ textAlign: 'center', marginTop: '2rem' }}>
                            <button className="btn btn--primary" onClick={handleProceed} style={{ fontSize: '1.05rem', padding: '0.875rem 2.25rem' }}>
                                Şehir Yönetim Botunu Programla →
                            </button>
                            <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.75rem' }}>
                                Değişkenleri öğrendin. Şimdi bu bilgiyle bir belediye hizmet botu yazacaksın.
                            </p>
                        </div>
                    </div>
                )}
            </div>
        </section>
    );
}
