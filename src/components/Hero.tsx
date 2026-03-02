import { useInView } from '../hooks/useInView';

export default function Hero() {
    const { ref, isVisible } = useInView(0.1);

    const scrollToNext = () => {
        document.getElementById('onboarding-vignette')?.scrollIntoView({ behavior: 'smooth' });
    };

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
                    position: 'absolute',
                    top: '20%',
                    left: '15%',
                    width: '400px',
                    height: '400px',
                    background: 'radial-gradient(circle, rgba(56,189,248,0.08) 0%, transparent 70%)',
                    borderRadius: '50%',
                    filter: 'blur(60px)',
                }} />
                <div style={{
                    position: 'absolute',
                    bottom: '10%',
                    right: '10%',
                    width: '350px',
                    height: '350px',
                    background: 'radial-gradient(circle, rgba(52,211,153,0.06) 0%, transparent 70%)',
                    borderRadius: '50%',
                    filter: 'blur(60px)',
                }} />
            </div>

            <div className="hero__content" ref={ref}>
                {/* Compass Logo */}
                <div className={`compass-logo reveal ${isVisible ? 'visible' : ''}`}>
                    <svg viewBox="0 0 120 120" fill="none" xmlns="http://www.w3.org/2000/svg">
                        {/* Outer ring */}
                        <circle cx="60" cy="60" r="56" stroke="rgba(56,189,248,0.3)" strokeWidth="1.5" />
                        <circle cx="60" cy="60" r="50" stroke="rgba(56,189,248,0.15)" strokeWidth="1" />
                        {/* Tick marks */}
                        {[0, 45, 90, 135, 180, 225, 270, 315].map((deg, i) => {
                            const rad = (deg * Math.PI) / 180;
                            const inner = 46;
                            const outer = 52;
                            return (
                                <line
                                    key={i}
                                    x1={60 + Math.cos(rad) * inner}
                                    y1={60 + Math.sin(rad) * inner}
                                    x2={60 + Math.cos(rad) * outer}
                                    y2={60 + Math.sin(rad) * outer}
                                    stroke="rgba(56,189,248,0.4)"
                                    strokeWidth={deg % 90 === 0 ? 2 : 1}
                                />
                            );
                        })}
                        {/* Cardinal letters */}
                        <text x="60" y="22" textAnchor="middle" fill="var(--accent-cyan)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="700">K</text>
                        <text x="60" y="105" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">G</text>
                        <text x="103" y="64" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">D</text>
                        <text x="17" y="64" textAnchor="middle" fill="var(--text-muted)" fontSize="8" fontFamily="var(--font-mono)" fontWeight="600">B</text>
                        {/* Compass needle */}
                        <g className="needle">
                            <polygon points="60,20 64,58 56,58" fill="var(--accent-cyan)" opacity="0.9" />
                            <polygon points="60,100 64,62 56,62" fill="var(--accent-rose)" opacity="0.6" />
                        </g>
                        {/* Center dot */}
                        <circle cx="60" cy="60" r="4" fill="var(--bg-cosmos)" stroke="var(--accent-cyan)" strokeWidth="2" />
                        <circle cx="60" cy="60" r="1.5" fill="var(--accent-cyan)" />
                    </svg>
                </div>

                {/* Partners */}
                <div className={`hero__partners reveal ${isVisible ? 'visible' : ''} delay-1`}>
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
            </div>
        </section>
    );
}
