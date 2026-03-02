import { useState, useEffect, useCallback, useRef } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

interface Scenario {
    situation: string;
    context: string;
    options: { text: string; score: number; feedback: string }[];
    timeLimit: number;
}

const SCENARIOS: Scenario[] = [
    {
        situation: 'Sunucu çökmesi',
        context: 'Belediye e-devlet portalı çöktü. 500 vatandaş işlem yapamıyor. Yedek sunucu hazır ama test edilmemiş.',
        options: [
            { text: 'Yedek sunucuyu aç', score: 70, feedback: 'Hızlı ama riskli — test edilmemiş sistem hataya açık.' },
            { text: 'Önce test et, sonra geç', score: 90, feedback: 'Doğru! Hızlı test + kontrollü geçiş en iyi uygulama.' },
            { text: 'Manuel hizmete dön', score: 40, feedback: 'Yavaş çözüm — dijital dönüşümü tersine çevirir.' },
        ],
        timeLimit: 15,
    },
    {
        situation: 'Veri sızıntısı şüphesi',
        context: 'Güvenlik ekibi anormal veri trafiği tespit etti. 10.000 kullanıcı verisi risk altında olabilir.',
        options: [
            { text: 'Sistemi kapat, araştır', score: 85, feedback: 'Güvenlik öncelikli yaklaşım — doğru karar.' },
            { text: 'Sadece trafiği izle', score: 50, feedback: 'Pasif — veri kaybı riski devam ediyor.' },
            { text: 'Kullanıcıları bilgilendir', score: 75, feedback: 'Şeffaf ama önce sızıntıyı durdurmak lazım.' },
        ],
        timeLimit: 12,
    },
    {
        situation: 'Bütçe kesintisi',
        context: 'Dijital dönüşüm bütçesi %30 kesildi. 3 projeden birini durdurmak zorundasın.',
        options: [
            { text: 'En az kullanılan projeyi durdur', score: 85, feedback: 'Veri odaklı karar — en az etkiyi yaratır.' },
            { text: 'Hepsini küçült', score: 60, feedback: 'Hiçbiri etkili olamaz — kaynakları böler.' },
            { text: 'Ek bütçe talep et', score: 45, feedback: 'Gerçekçi değil — kısıtlar içinde çözüm bulmak gerekiyor.' },
        ],
        timeLimit: 18,
    },
    {
        situation: 'Yapay zeka hatası',
        context: 'Chatbot yanlış bilgi verdi ve 200 vatandaş yanlış yönlendirildi. Basın ilgileniyor.',
        options: [
            { text: 'Chatbotu kapat, özür yayınla', score: 90, feedback: 'Şeffaflık + düzeltme. En profesyonel yaklaşım!' },
            { text: 'Sessizce düzelt', score: 40, feedback: 'Güven kaybına yol açar — şeffaflık şart.' },
            { text: 'İnsan operatöre geç', score: 70, feedback: 'İyi geçiş ama hatayı kabul etmeden güven kazanılmaz.' },
        ],
        timeLimit: 12,
    },
    {
        situation: 'DDoS saldırısı',
        context: 'Belediye web sitesine yoğun DDoS saldırısı. Seçim dönemi ve vatandaşlar bilgi arıyor.',
        options: [
            { text: 'CDN + rate limiting uygula', score: 95, feedback: 'Mükemmel! Teknik çözümle hizmeti koru.' },
            { text: 'Siteyi kapat', score: 30, feedback: 'Saldırganın amacına hizmet eder.' },
            { text: 'Sosyal medyadan bilgilendir', score: 60, feedback: 'Kısmen iyi ama teknik çözüm olmadan yetersiz.' },
        ],
        timeLimit: 10,
    },
];

export default function QuickDecision() {
    const { dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.1);
    const [currentIndex, setCurrentIndex] = useState(0);
    const [selectedOption, setSelectedOption] = useState<number | null>(null);
    const [timeLeft, setTimeLeft] = useState(SCENARIOS[0].timeLimit);
    const [totalScore, setTotalScore] = useState(0);
    const [completed, setCompleted] = useState(0);
    const [phase, setPhase] = useState<'intro' | 'playing' | 'feedback' | 'done'>('intro');
    const timerRef = useRef<ReturnType<typeof setInterval> | undefined>(undefined);

    const scenario = SCENARIOS[currentIndex];

    // Timer
    useEffect(() => {
        if (phase !== 'playing') return;
        setTimeLeft(scenario.timeLimit);
        timerRef.current = setInterval(() => {
            setTimeLeft(prev => {
                if (prev <= 1) {
                    clearInterval(timerRef.current);
                    // Timeout — directly set feedback state
                    setSelectedOption(-1);
                    setTotalScore(p => p);
                    setCompleted(p => p + 1);
                    setPhase('feedback');
                    return 0;
                }
                return prev - 1;
            });
        }, 1000);
        return () => clearInterval(timerRef.current);
    }, [phase, currentIndex, scenario.timeLimit]);

    const handleSelect = useCallback((index: number) => {
        if (selectedOption !== null) return;
        clearInterval(timerRef.current);
        setSelectedOption(index);
        const score = index >= 0 ? scenario.options[index].score : 0;
        setTotalScore(prev => prev + score);
        setCompleted(prev => prev + 1);
        setPhase('feedback');
    }, [selectedOption, scenario]);

    const handleNext = useCallback(() => {
        if (currentIndex < SCENARIOS.length - 1) {
            setCurrentIndex(prev => prev + 1);
            setSelectedOption(null);
            setPhase('playing');
        } else {
            setPhase('done');
            dispatch({ type: 'ADD_YETKINLIK', amount: 25, label: 'Hızlı Karar Verme', beceri: 'Kriz Yönetimi' });
        }
    }, [currentIndex, dispatch]);

    const avgScore = completed > 0 ? Math.round(totalScore / completed) : 0;

    return (
        <section className="section" id="quick-decision" ref={ref}>
            <div className="container" style={{ maxWidth: 'var(--container-narrow)' }}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" />
                    </svg>
                    Hızlı Karar Modülü
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Zamana Karşı <span style={{ color: 'var(--accent-amber)' }}>Kriz Yönetimi</span>
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Gerçek dünya kriz senaryolarında hızlı ve doğru kararlar ver.
                    Her saniye önemli!
                </p>

                {phase === 'intro' && (
                    <div className={`card reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: '3rem', marginBottom: '1rem' }}>⚡</div>
                        <h3 style={{ marginBottom: '0.5rem' }}>5 Kriz Senaryosu</h3>
                        <p style={{ color: 'var(--text-muted)', fontSize: '0.9rem', marginBottom: '1.5rem' }}>
                            Her senaryoda sınırlı sürede en iyi kararı vermelisin.
                            Hız ve doğruluk puanını belirler.
                        </p>
                        <button className="btn btn--primary" onClick={() => setPhase('playing')}>
                            Başla
                        </button>
                    </div>
                )}

                {(phase === 'playing' || phase === 'feedback') && (
                    <div className="card">
                        {/* Progress + Timer */}
                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1rem' }}>
                            <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>
                                {currentIndex + 1}/{SCENARIOS.length}
                            </span>
                            <div style={{
                                display: 'flex', alignItems: 'center', gap: '0.4rem',
                                padding: '0.25rem 0.6rem', borderRadius: '6px',
                                background: timeLeft <= 5 ? 'rgba(251,113,133,0.1)' : 'rgba(56,189,248,0.06)',
                                border: `1px solid ${timeLeft <= 5 ? 'rgba(251,113,133,0.3)' : 'var(--border-dim)'}`,
                            }}>
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke={timeLeft <= 5 ? 'var(--accent-rose)' : 'var(--accent-cyan)'} strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <circle cx="12" cy="12" r="10" /><polyline points="12 6 12 12 16 14" />
                                </svg>
                                <span style={{
                                    fontFamily: 'var(--font-mono)', fontSize: '0.85rem', fontWeight: 700,
                                    color: timeLeft <= 5 ? 'var(--accent-rose)' : 'var(--accent-cyan)',
                                }}>
                                    {timeLeft}s
                                </span>
                            </div>
                        </div>

                        {/* Scenario */}
                        <div style={{
                            padding: '1rem', borderRadius: '10px', marginBottom: '1rem',
                            background: 'linear-gradient(135deg, rgba(251,191,36,0.05), rgba(56,189,248,0.03))',
                            border: '1px solid rgba(251,191,36,0.15)',
                        }}>
                            <h3 style={{ fontSize: '1rem', color: 'var(--accent-amber)', marginBottom: '0.35rem' }}>
                                ⚠ {scenario.situation}
                            </h3>
                            <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)', lineHeight: 1.7 }}>
                                {scenario.context}
                            </p>
                        </div>

                        {/* Options */}
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                            {scenario.options.map((opt, i) => {
                                const isSelected = selectedOption === i;
                                const isBest = phase === 'feedback' && opt.score === Math.max(...scenario.options.map(o => o.score));
                                return (
                                    <button
                                        key={i}
                                        onClick={() => phase === 'playing' && handleSelect(i)}
                                        disabled={phase === 'feedback'}
                                        style={{
                                            display: 'flex', alignItems: 'center', gap: '0.75rem',
                                            padding: '0.75rem 1rem', borderRadius: '10px',
                                            fontFamily: 'var(--font-body)', fontSize: '0.85rem', textAlign: 'left',
                                            color: isSelected ? 'var(--text-primary)' : 'var(--text-secondary)',
                                            background: isSelected
                                                ? (isBest ? 'rgba(52,211,153,0.1)' : 'rgba(251,113,133,0.08)')
                                                : isBest ? 'rgba(52,211,153,0.05)' : 'var(--bg-void)',
                                            border: isSelected
                                                ? (isBest ? '1px solid var(--accent-emerald)' : '1px solid var(--accent-rose)')
                                                : isBest ? '1px solid rgba(52,211,153,0.3)' : '1px solid var(--border-dim)',
                                            cursor: phase === 'playing' ? 'pointer' : 'default',
                                            transition: 'all 0.2s',
                                            opacity: phase === 'feedback' && !isSelected && !isBest ? 0.5 : 1,
                                        }}
                                    >
                                        <span style={{
                                            width: '24px', height: '24px', borderRadius: '50%',
                                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                                            fontSize: '0.7rem', fontWeight: 700, fontFamily: 'var(--font-mono)',
                                            background: isSelected
                                                ? (isBest ? 'var(--accent-emerald)' : 'var(--accent-rose)')
                                                : 'rgba(255,255,255,0.06)',
                                            color: isSelected ? 'var(--text-inverse)' : 'var(--text-muted)',
                                            flexShrink: 0,
                                        }}>
                                            {String.fromCharCode(65 + i)}
                                        </span>
                                        <span style={{ flex: 1 }}>{opt.text}</span>
                                        {phase === 'feedback' && isSelected && (
                                            <span style={{
                                                fontFamily: 'var(--font-mono)', fontSize: '0.75rem', fontWeight: 700,
                                                color: isBest ? 'var(--accent-emerald)' : 'var(--accent-rose)',
                                            }}>
                                                +{opt.score}
                                            </span>
                                        )}
                                    </button>
                                );
                            })}
                        </div>

                        {/* Feedback */}
                        {phase === 'feedback' && selectedOption !== null && selectedOption >= 0 && (
                            <div style={{
                                marginTop: '1rem', padding: '0.75rem 1rem', borderRadius: '8px',
                                background: 'rgba(56,189,248,0.04)', border: '1px solid var(--border-dim)',
                                fontSize: '0.85rem', color: 'var(--text-secondary)', lineHeight: 1.7,
                            }}>
                                💡 {scenario.options[selectedOption].feedback}
                            </div>
                        )}

                        {phase === 'feedback' && (
                            <button className="btn btn--primary" onClick={handleNext} style={{ marginTop: '1rem', width: '100%' }}>
                                {currentIndex < SCENARIOS.length - 1 ? 'Sonraki Senaryo →' : 'Sonuçları Gör'}
                            </button>
                        )}
                    </div>
                )}

                {phase === 'done' && (
                    <div className="card" style={{ textAlign: 'center' }}>
                        <div style={{ fontSize: '3rem', marginBottom: '0.5rem' }}>
                            {avgScore >= 80 ? '🏆' : avgScore >= 60 ? '👍' : '📚'}
                        </div>
                        <h3 style={{ marginBottom: '0.5rem', fontSize: '1.2rem' }}>Kriz Yönetim Sonuçları</h3>
                        <div style={{
                            fontSize: '2.5rem', fontWeight: 800, fontFamily: 'var(--font-display)',
                            color: avgScore >= 80 ? 'var(--accent-emerald)' : avgScore >= 60 ? 'var(--accent-amber)' : 'var(--accent-rose)',
                            marginBottom: '0.5rem',
                        }}>
                            %{avgScore}
                        </div>
                        <p style={{ color: 'var(--text-muted)', fontSize: '0.85rem', marginBottom: '1rem' }}>
                            {avgScore >= 80 ? 'Mükemmel kriz yöneticisi! Hızlı ve doğru kararlar verdin.' : avgScore >= 60 ? 'İyi performans. Bazı senaryolarda daha hızlı karar verebilirsin.' : 'Pratik yap! Kriz senaryolarını tekrar dene.'}
                        </p>
                        <button className="btn btn--secondary" onClick={() => {
                            setCurrentIndex(0);
                            setSelectedOption(null);
                            setTotalScore(0);
                            setCompleted(0);
                            setPhase('intro');
                        }}>
                            Tekrar Dene
                        </button>
                    </div>
                )}
            </div>
        </section>
    );
}
