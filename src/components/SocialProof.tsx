import { useState, useEffect, useRef } from 'react';
import { useInView } from '../hooks/useInView';

/* CountUp hook — animates number from 0 to target */
function useCountUp(target: number, duration: number, start: boolean): number {
    const [value, setValue] = useState(0);
    const rafRef = useRef<number>(0);
    useEffect(() => {
        if (!start) return;
        const startTime = performance.now();
        const animate = (now: number) => {
            const elapsed = now - startTime;
            const progress = Math.min(elapsed / duration, 1);
            // ease-out cubic
            const eased = 1 - Math.pow(1 - progress, 3);
            setValue(Math.round(eased * target));
            if (progress < 1) rafRef.current = requestAnimationFrame(animate);
        };
        rafRef.current = requestAnimationFrame(animate);
        return () => cancelAnimationFrame(rafRef.current);
    }, [target, duration, start]);
    return value;
}

const weekDays = [
    {
        day: 'Pazartesi',
        label: 'Kıvılcım',
        desc: 'Problem tanımlama ve bireysel düşünme. Her öğrenci kendi kıvılcımını yazar.',
        color: 'var(--accent-amber)',
        bgColor: 'var(--accent-amber-dim)',
        icon: (
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
            </svg>
        ),
    },
    {
        day: 'Çarşamba',
        label: 'Ateşleme',
        desc: 'Takım çalışması ve peer-review. Lonca içinde fikirler çarpıştırılır.',
        color: 'var(--accent-cyan)',
        bgColor: 'var(--accent-cyan-dim)',
        icon: (
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" />
            </svg>
        ),
    },
    {
        day: 'Cuma',
        label: 'Öğretme Kanıtı',
        desc: 'Feynman tekniği ile öğrenileni başkasına aktarma. Kalfa-aday eşleşmesi.',
        color: 'var(--accent-emerald)',
        bgColor: 'var(--accent-emerald-dim)',
        icon: (
            <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z" /><path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z" />
            </svg>
        ),
    },
];

const metricsData = [
    { label: 'Öğretme Puanı', value: 87, suffix: '', color: 'var(--accent-emerald)', desc: 'Ortalama Feynman skoru' },
    { label: 'Ateşleme Katılımı', value: 92, suffix: '%', color: 'var(--accent-cyan)', desc: 'Haftalık aktif katılım' },
    { label: 'Kalfa-Aday Eşleşme', value: 78, suffix: '%', color: 'var(--accent-violet)', desc: 'Başarılı mentorluk oranı' },
    { label: 'Aktif Lonca Üyesi', value: 142, suffix: '', color: 'var(--accent-amber)', desc: 'Eskişehir Merkez' },
];

const loncaRanks = [
    { rank: 'Aday', desc: 'İlk 2 hafta — temel beceriler', pct: 100, color: 'var(--text-muted)', glow: false },
    { rank: 'Kalfa', desc: 'Hafta 3-5 — proje üretimi', pct: 72, color: 'var(--accent-cyan)', glow: false },
    { rank: 'Usta', desc: 'Hafta 6-7 — mentorluk başlar', pct: 38, color: 'var(--accent-emerald)', glow: true },
    { rank: 'Ateşleyen', desc: 'Hafta 8 — topluluk lideri', pct: 12, color: 'var(--accent-amber)', glow: true },
];

function AnimatedMetric({ m, animate }: { m: typeof metricsData[0]; animate: boolean }) {
    const count = useCountUp(m.value, 1800, animate);
    return (
        <div className="kpi-card" style={{ borderColor: `color-mix(in srgb, ${m.color} 20%, transparent)` }}>
            <div className="kpi-card__value" style={{ color: m.color }}>
                {m.suffix === '%' ? `%${count}` : count}
            </div>
            <div className="kpi-card__label">{m.label}</div>
            <div style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>{m.desc}</div>
        </div>
    );
}

export default function SocialProof() {
    const { ref, isVisible } = useInView(0.15);

    return (
        <section className="section" id="social-proof-architecture" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 0 0-3-3.87" /><path d="M16 3.13a4 4 0 0 1 0 7.75" />
                    </svg>
                    Sosyal Öğrenme
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Lonca <span style={{ color: 'var(--accent-violet)' }}>Sistemi</span> Mimarisi
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '1.5rem', maxWidth: '600px' }}>
                    PUSULA'da öğrenme bireysel değil, sosyaldir. Lonca sistemi ile akran öğrenimi, mentorluk ve takım çalışması haftalık ritimle ilerler.
                </p>

                {/* Architecture diagram */}
                <div className={`card reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ marginBottom: '2rem', padding: '2rem' }}>
                    <svg viewBox="0 0 800 220" fill="none" xmlns="http://www.w3.org/2000/svg" style={{ width: '100%', maxHeight: '220px' }}>
                        {/* Boxes */}
                        <rect x="20" y="70" width="160" height="80" rx="14" fill="var(--accent-amber-dim)" stroke="var(--accent-amber)" strokeWidth="1.5" />
                        <text x="100" y="100" textAnchor="middle" fill="var(--accent-amber)" fontSize="13" fontFamily="var(--font-display)" fontWeight="700">KIVILCIM</text>
                        <text x="100" y="120" textAnchor="middle" fill="var(--text-muted)" fontSize="10" fontFamily="var(--font-body)">Bireysel Düşünme</text>

                        <rect x="240" y="70" width="160" height="80" rx="14" fill="var(--accent-cyan-dim)" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                        <text x="320" y="100" textAnchor="middle" fill="var(--accent-cyan)" fontSize="13" fontFamily="var(--font-display)" fontWeight="700">ATEŞLEME</text>
                        <text x="320" y="120" textAnchor="middle" fill="var(--text-muted)" fontSize="10" fontFamily="var(--font-body)">Takım Çalışması</text>

                        <rect x="460" y="70" width="160" height="80" rx="14" fill="var(--accent-emerald-dim)" stroke="var(--accent-emerald)" strokeWidth="1.5" />
                        <text x="540" y="100" textAnchor="middle" fill="var(--accent-emerald)" fontSize="13" fontFamily="var(--font-display)" fontWeight="700">ÖĞRETME</text>
                        <text x="540" y="120" textAnchor="middle" fill="var(--text-muted)" fontSize="10" fontFamily="var(--font-body)">Feynman Kanıtı</text>

                        <rect x="640" y="70" width="140" height="80" rx="14" fill="var(--accent-violet-dim)" stroke="var(--accent-violet)" strokeWidth="1.5" />
                        <text x="710" y="100" textAnchor="middle" fill="var(--accent-violet)" fontSize="13" fontFamily="var(--font-display)" fontWeight="700">LONCA</text>
                        <text x="710" y="120" textAnchor="middle" fill="var(--text-muted)" fontSize="10" fontFamily="var(--font-body)">Mentorluk Ağı</text>

                        {/* Arrows */}
                        <path d="M180 110 L240 110" stroke="var(--text-muted)" strokeWidth="2" markerEnd="url(#arrowhead)" />
                        <path d="M400 110 L460 110" stroke="var(--text-muted)" strokeWidth="2" markerEnd="url(#arrowhead)" />
                        <path d="M620 110 L640 110" stroke="var(--text-muted)" strokeWidth="2" markerEnd="url(#arrowhead)" />

                        {/* Feedback loop */}
                        <path d="M710 150 L710 190 L100 190 L100 150" stroke="var(--accent-violet)" strokeWidth="1.5" strokeDasharray="6 4" markerEnd="url(#arrowViolet)" opacity="0.5" />
                        <text x="400" y="208" textAnchor="middle" fill="var(--accent-violet)" fontSize="10" fontFamily="var(--font-mono)" opacity="0.7">Geri Bildirim Döngüsü</text>

                        {/* Arrow markers */}
                        <defs>
                            <marker id="arrowhead" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                                <polygon points="0 0, 10 3.5, 0 7" fill="var(--text-muted)" />
                            </marker>
                            <marker id="arrowViolet" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto">
                                <polygon points="0 0, 10 3.5, 0 7" fill="var(--accent-violet)" opacity="0.5" />
                            </marker>
                        </defs>
                    </svg>
                </div>

                {/* Weekly Rhythm */}
                <h3 className={`reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ marginBottom: '1rem', textAlign: 'center' }}>Haftalık Ritim</h3>
                <div className={`timeline-week reveal ${isVisible ? 'visible' : ''} delay-4`}>
                    {weekDays.map(d => (
                        <div
                            key={d.day}
                            className="timeline-day"
                            style={{ borderColor: `color-mix(in srgb, ${d.color} 30%, transparent)` }}
                        >
                            <div className="timeline-day__name">{d.day}</div>
                            <div className="timeline-day__icon">{d.icon}</div>
                            <div className="timeline-day__label" style={{ color: d.color }}>{d.label}</div>
                            <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.5rem', lineHeight: '1.6' }}>{d.desc}</p>
                        </div>
                    ))}
                </div>

                {/* Lonca Ranks */}
                <h3 className={`reveal ${isVisible ? 'visible' : ''} delay-4`} style={{ marginBottom: '1rem', textAlign: 'center', marginTop: '2rem' }}>Yükseliş Yolu</h3>
                <div className={`grid-4 reveal ${isVisible ? 'visible' : ''} delay-5`}>
                    {loncaRanks.map(r => (
                        <div key={r.rank} className="card" style={{
                            textAlign: 'center', padding: '1.25rem 0.75rem',
                            border: `1px solid color-mix(in srgb, ${r.color} 25%, transparent)`,
                            boxShadow: r.glow ? `0 0 20px color-mix(in srgb, ${r.color} 10%, transparent)` : 'none',
                            transition: 'box-shadow 0.3s, border-color 0.3s',
                        }}>
                            <div style={{ fontSize: '1.4rem', fontWeight: 800, fontFamily: 'var(--font-display)', color: r.color }}>{r.rank}</div>
                            <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.35rem', lineHeight: 1.6 }}>{r.desc}</p>
                            <div style={{ width: '100%', height: '4px', background: 'rgba(255,255,255,0.05)', borderRadius: '2px', marginTop: '0.75rem', overflow: 'hidden' }}>
                                <div style={{
                                    width: isVisible ? `${r.pct}%` : '0%',
                                    height: '100%', background: r.color, borderRadius: '2px',
                                    transition: 'width 1.2s ease',
                                }} />
                            </div>
                            <span style={{ fontSize: '0.7rem', fontFamily: 'var(--font-mono)', color: r.color, marginTop: '0.35rem', display: 'block' }}>%{r.pct} öğrenci</span>
                        </div>
                    ))}
                </div>

                {/* Animated Metrics */}
                <div className={`grid-4 reveal ${isVisible ? 'visible' : ''} delay-5`} style={{ marginTop: '1.5rem' }}>
                    {metricsData.map(m => (
                        <AnimatedMetric key={m.label} m={m} animate={isVisible} />
                    ))}
                </div>
            </div>
        </section>
    );
}
