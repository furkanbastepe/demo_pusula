import { useState, useEffect, useCallback, useRef } from 'react';
import { useInView } from '../hooks/useInView';

const TERMINAL_LINES = [
    { text: 'PUSULA Dijital Gençlik Sistemi v3.2.1', delay: 0, type: 'system' as const },
    { text: 'Merkez ağına bağlanılıyor...', delay: 600, type: 'system' as const },
    { text: '✓ Eskişehir Merkez — 142 aktif genç', delay: 1200, type: 'success' as const },
    { text: '', delay: 1600, type: 'blank' as const },
    { text: '⚠ KRİZ SENARYOSU YÜKLENIYOR', delay: 1800, type: 'warning' as const },
    { text: 'Belediye hizmet noktasında 28 vatandaş bekliyor.', delay: 2400, type: 'info' as const },
    { text: 'Sadece 2 gişe açık. Memnuniyet: %34. Bütçe: 200₺', delay: 3000, type: 'info' as const },
    { text: '', delay: 3400, type: 'blank' as const },
    { text: 'İlk kararını ver:', delay: 3600, type: 'prompt' as const },
];

const CHOICES = [
    { key: '1', label: 'Yeni gişe aç', icon: '🏢', result: 'Kuyruk %40 azaldı! Bütçe: 120₺. Memnuniyet: %58', skill: 'Kaynak Yönetimi', xp: 15 },
    { key: '2', label: 'Dijitale yönlendir', icon: '📱', result: '%30 vatandaş dijitale geçti! Bütçe sabit. Memnuniyet: %52', skill: 'Dijital Dönüşüm', xp: 20 },
    { key: '3', label: 'Öncelik sırası uygula', icon: '⚡', result: 'Yaşlı memnuniyeti %85! Ortalama bekleme: 12dk.', skill: 'Empati & Planlama', xp: 15 },
];

export default function Hero() {
    const { ref, isVisible } = useInView(0.1);
    const [mode, setMode] = useState<'terminal' | 'classic'>('terminal');
    const [visibleLines, setVisibleLines] = useState(0);
    const [showChoices, setShowChoices] = useState(false);
    const [chosen, setChosen] = useState<number | null>(null);
    const [showResult, setShowResult] = useState(false);
    const timerRefs = useRef<ReturnType<typeof setTimeout>[]>([]);

    const scrollToNext = () => {
        document.getElementById('onboarding-vignette')?.scrollIntoView({ behavior: 'smooth' });
    };

    // Terminal typewriter effect
    useEffect(() => {
        if (mode !== 'terminal') return;
        timerRefs.current.forEach(clearTimeout);
        timerRefs.current = [];

        TERMINAL_LINES.forEach((line, i) => {
            const t = setTimeout(() => setVisibleLines(i + 1), line.delay);
            timerRefs.current.push(t);
        });

        const choiceTimer = setTimeout(() => setShowChoices(true), 4200);
        timerRefs.current.push(choiceTimer);

        return () => timerRefs.current.forEach(clearTimeout);
    }, [mode]);

    const handleChoice = useCallback((index: number) => {
        if (chosen !== null) return;
        setChosen(index);
        setTimeout(() => setShowResult(true), 400);
    }, [chosen]);

    /* Generate stars */
    const stars = Array.from({ length: 80 }, (_, i) => ({
        id: i,
        x: Math.random() * 100,
        y: Math.random() * 100,
        size: Math.random() * 2.5 + 0.5,
        dur: Math.random() * 4 + 2,
        delay: Math.random() * 5,
    }));

    return (
        <section className="hero" id="hero">
            {/* Starfield Background */}
            <div className="hero__bg">
                <div className="starfield">
                    {stars.map(s => (
                        <span
                            key={s.id}
                            className="starfield__star"
                            style={{
                                left: `${s.x}%`,
                                top: `${s.y}%`,
                                width: `${s.size}px`,
                                height: `${s.size}px`,
                                '--dur': `${s.dur}s`,
                                '--delay': `${s.delay}s`,
                            } as React.CSSProperties}
                        />
                    ))}
                </div>
                {/* Gradient orbs */}
                <div style={{
                    position: 'absolute', top: '20%', left: '15%',
                    width: '400px', height: '400px',
                    background: 'radial-gradient(circle, rgba(56,189,248,0.08) 0%, transparent 70%)',
                    borderRadius: '50%', filter: 'blur(60px)',
                }} />
                <div style={{
                    position: 'absolute', bottom: '10%', right: '10%',
                    width: '350px', height: '350px',
                    background: 'radial-gradient(circle, rgba(52,211,153,0.06) 0%, transparent 70%)',
                    borderRadius: '50%', filter: 'blur(60px)',
                }} />
            </div>

            <div className="hero__content" ref={ref}>
                {/* Mode switcher */}
                <div className={`hero__mode-switch reveal ${isVisible ? 'visible' : ''}`}>
                    <button
                        className={`hero__mode-btn ${mode === 'terminal' ? 'hero__mode-btn--active' : ''}`}
                        onClick={() => setMode('terminal')}
                    >
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <polyline points="4 17 10 11 4 5" /><line x1="12" y1="19" x2="20" y2="19" />
                        </svg>
                        Etkileşimli Giriş
                    </button>
                    <button
                        className={`hero__mode-btn ${mode === 'classic' ? 'hero__mode-btn--active' : ''}`}
                        onClick={() => setMode('classic')}
                    >
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <circle cx="12" cy="12" r="10" /><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20" /><path d="M2 12h20" />
                        </svg>
                        Hakkında
                    </button>
                </div>

                {mode === 'terminal' ? (
                    /* ── TERMINAL MODE ── */
                    <div className={`terminal-hero reveal ${isVisible ? 'visible' : ''} delay-1`}>
                        {/* Terminal chrome */}
                        <div className="terminal-hero__chrome">
                            <span className="terminal-hero__dot" style={{ background: '#FF5F57' }} />
                            <span className="terminal-hero__dot" style={{ background: '#FEBC2E' }} />
                            <span className="terminal-hero__dot" style={{ background: '#28C840' }} />
                            <span className="terminal-hero__chrome-title">pusula@merkez:~</span>
                        </div>

                        {/* Terminal body */}
                        <div className="terminal-hero__body">
                            {TERMINAL_LINES.slice(0, visibleLines).map((line, i) => (
                                <div key={i} className={`terminal-hero__line terminal-hero__line--${line.type}`}>
                                    {line.type === 'prompt' && <span className="terminal-hero__prompt">{'>'} </span>}
                                    {line.type === 'system' && <span className="terminal-hero__prompt" style={{ color: 'var(--text-muted)' }}>$ </span>}
                                    {line.text}
                                </div>
                            ))}

                            {/* Choices */}
                            {showChoices && chosen === null && (
                                <div className="terminal-hero__choices">
                                    {CHOICES.map((c, i) => (
                                        <button
                                            key={i}
                                            className="terminal-hero__choice"
                                            onClick={() => handleChoice(i)}
                                        >
                                            <span className="terminal-hero__choice-key">[{c.key}]</span>
                                            <span className="terminal-hero__choice-icon">{c.icon}</span>
                                            <span>{c.label}</span>
                                        </button>
                                    ))}
                                </div>
                            )}

                            {/* Result */}
                            {chosen !== null && (
                                <div className="terminal-hero__result-block">
                                    <div className="terminal-hero__line terminal-hero__line--system">
                                        <span className="terminal-hero__prompt">{'>'} </span>
                                        Seçim: {CHOICES[chosen].label}
                                    </div>
                                    {showResult && (
                                        <>
                                            <div className="terminal-hero__line terminal-hero__line--success" style={{ marginTop: '0.5rem' }}>
                                                ✓ {CHOICES[chosen].result}
                                            </div>
                                            <div className="terminal-hero__skill-earned">
                                                <span className="terminal-hero__xp-badge">+{CHOICES[chosen].xp} Yetkinlik</span>
                                                <span style={{ color: 'var(--text-secondary)', fontSize: '0.8rem' }}>
                                                    Kazanılan beceri: <strong style={{ color: 'var(--accent-cyan)' }}>{CHOICES[chosen].skill}</strong>
                                                </span>
                                            </div>
                                            <div className="terminal-hero__line terminal-hero__line--prompt" style={{ marginTop: '0.75rem' }}>
                                                İlk kararını verdin. Şimdi bunu Python ile kodlayacaksın.
                                            </div>
                                            <button className="btn btn--primary" style={{ marginTop: '1rem', width: '100%' }} onClick={scrollToNext}>
                                                <span>Kodlamaya Başla</span>
                                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                                                    <path d="M12 5v14M19 12l-7 7-7-7" />
                                                </svg>
                                            </button>
                                        </>
                                    )}
                                </div>
                            )}

                            {/* Blinking cursor */}
                            {!showChoices && <span className="terminal-hero__cursor">▌</span>}
                        </div>
                    </div>
                ) : (
                    /* ── CLASSIC MODE ── */
                    <>
                        {/* Compass Logo */}
                        <div className={`compass-logo reveal ${isVisible ? 'visible' : ''} delay-1`}>
                            <svg viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <circle cx="60" cy="60" r="56" stroke="rgba(56,189,248,0.3)" strokeWidth="1.5" />
                                <circle cx="60" cy="60" r="50" stroke="rgba(56,189,248,0.15)" strokeWidth="1" />
                                {[0, 45, 90, 135, 180, 225, 270, 315].map((deg, i) => {
                                    const rad = (deg * Math.PI) / 180;
                                    return (
                                        <line key={i}
                                            x1={60 + Math.cos(rad) * 46} y1={60 + Math.sin(rad) * 46}
                                            x2={60 + Math.cos(rad) * 52} y2={60 + Math.sin(rad) * 52}
                                            stroke="rgba(56,189,248,0.4)" strokeWidth={deg % 90 === 0 ? 2 : 1}
                                        />
                                    );
                                })}
                                <text x="60" y="22" textAnchor="middle" fill="var(--accent-cyan)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="700">K</text>
                                <text x="60" y="105" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">G</text>
                                <text x="103" y="64" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">D</text>
                                <text x="17" y="64" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">B</text>
                                <g className="needle">
                                    <polygon points="60,20 64,58 56,58" fill="var(--accent-cyan)" opacity="0.9" />
                                    <polygon points="60,100 64,62 56,62" fill="var(--accent-rose)" opacity="0.6" />
                                </g>
                                <circle cx="60" cy="60" r="4" fill="var(--bg-cosmos)" stroke="var(--accent-cyan)" strokeWidth="2" />
                                <circle cx="60" cy="60" r="1.5" fill="var(--accent-cyan)" />
                            </svg>
                        </div>

                        {/* Partners */}
                        <div className={`hero__partners reveal ${isVisible ? 'visible' : ''} delay-2`}>
                            <span>UNDP</span>
                            <div className="divider" />
                            <span>TBB</span>
                            <div className="divider" />
                            <span>Dijital Gençlik Merkezi</span>
                        </div>

                        {/* Title */}
                        <h1 className={`hero__title reveal ${isVisible ? 'visible' : ''} delay-2`}>
                            Gençlerin <span className="highlight">Dijital Geleceğini</span> İnşa Ediyoruz
                        </h1>

                        {/* Subtitle */}
                        <p className={`hero__subtitle reveal ${isVisible ? 'visible' : ''} delay-3`}>
                            Problem tabanlı öğrenme ile 18-29 yaş arası gençlere dijital becerileri
                            gerçek dünya problemleri çözerek kazandıran yenilikçi EdTech platformu.
                        </p>

                        {/* CTA */}
                        <div className={`hero__cta-wrapper reveal ${isVisible ? 'visible' : ''} delay-4`}>
                            <button className="btn btn--primary" onClick={scrollToNext} id="hero-cta">
                                <span>Deneyimi Başlat</span>
                                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M12 5v14M19 12l-7 7-7-7" />
                                </svg>
                            </button>
                            <span className="hero__scroll-hint">↓ Aşağı kaydırarak keşfedin</span>
                        </div>
                    </>
                )}
            </div>
        </section>
    );
}
