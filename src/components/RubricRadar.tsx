import { useMemo } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

const dimensions = [
    { key: 'problemTanimlama', label: 'Problem Tanımlama', color: 'var(--accent-cyan)' },
    { key: 'veriAnalizi', label: 'Veri Analizi', color: 'var(--accent-emerald)' },
    { key: 'yaraticiCozum', label: 'Yaratıcı Çözüm', color: 'var(--accent-amber)' },
    { key: 'iletisim', label: 'İletişim', color: 'var(--accent-violet)' },
    { key: 'transfer', label: 'Transfer', color: 'var(--accent-rose)' },
] as const;

function polarToCart(cx: number, cy: number, r: number, angleDeg: number) {
    const rad = ((angleDeg - 90) * Math.PI) / 180;
    return { x: cx + r * Math.cos(rad), y: cy + r * Math.sin(rad) };
}

export default function RubricRadar() {
    const { state } = usePusula();
    const { ref, isVisible } = useInView(0.15);

    const cx = 160, cy = 160, maxR = 130;
    const angleStep = 360 / dimensions.length;

    const scores = dimensions.map(d => state.rubricScores[d.key as keyof typeof state.rubricScores]);
    const avg = scores.reduce((a, b) => a + b, 0) / scores.length;

    /* Build radar polygon */
    const radarPoints = useMemo(() => {
        return dimensions.map((_, i) => {
            const r = (scores[i] / 100) * maxR;
            const { x, y } = polarToCart(cx, cy, r, i * angleStep);
            return `${x},${y}`;
        }).join(' ');
    }, [scores]);

    return (
        <section className="section" id="rubric-radar" ref={ref}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
                    </svg>
                    Değerlendirme Radarı
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Yetkinlik <span style={{ color: 'var(--accent-cyan)' }}>Radar</span> Haritanız
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Tüm etkileşimleriniz 5 boyutta skorlandı. Her bölümde yaptığınız seçimler radar grafiğini şekillendirdi.
                </p>

                <div className={`radar-container reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    {/* SVG Radar Chart */}
                    <svg className="radar-svg" viewBox="0 0 320 320" fill="none" xmlns="http://www.w3.org/2000/svg">
                        {/* Grid rings */}
                        {[0.2, 0.4, 0.6, 0.8, 1].map((ratio, ri) => {
                            const r = maxR * ratio;
                            const pts = dimensions.map((_, i) => {
                                const { x, y } = polarToCart(cx, cy, r, i * angleStep);
                                return `${x},${y}`;
                            }).join(' ');
                            return (
                                <polygon
                                    key={ri}
                                    points={pts}
                                    fill="none"
                                    stroke="var(--border-dim)"
                                    strokeWidth={ratio === 1 ? 1.5 : 0.75}
                                />
                            );
                        })}

                        {/* Axis lines */}
                        {dimensions.map((_, i) => {
                            const { x, y } = polarToCart(cx, cy, maxR, i * angleStep);
                            return (
                                <line key={i} x1={cx} y1={cy} x2={x} y2={y} stroke="var(--border-dim)" strokeWidth="0.75" />
                            );
                        })}

                        {/* Data polygon */}
                        <polygon
                            points={radarPoints}
                            fill="rgba(56,189,248,0.12)"
                            stroke="var(--accent-cyan)"
                            strokeWidth="2.5"
                            strokeLinejoin="round"
                            style={{
                                transition: 'all 0.8s cubic-bezier(0.25,0.46,0.45,0.94)',
                            }}
                        />

                        {/* Data points */}
                        {dimensions.map((d, i) => {
                            const r = (scores[i] / 100) * maxR;
                            const { x, y } = polarToCart(cx, cy, r, i * angleStep);
                            return (
                                <g key={d.key}>
                                    <circle cx={x} cy={y} r="5" fill={d.color} stroke="var(--bg-void)" strokeWidth="2">
                                        <animate attributeName="r" values="5;7;5" dur="2s" repeatCount="indefinite" />
                                    </circle>
                                </g>
                            );
                        })}

                        {/* Labels */}
                        {dimensions.map((d, i) => {
                            const { x, y } = polarToCart(cx, cy, maxR + 22, i * angleStep);
                            return (
                                <text
                                    key={d.key}
                                    x={x}
                                    y={y + 4}
                                    textAnchor="middle"
                                    fill={d.color}
                                    fontSize="10"
                                    fontFamily="var(--font-display)"
                                    fontWeight="600"
                                >
                                    {d.label}
                                </text>
                            );
                        })}
                    </svg>

                    {/* Dimension details */}
                    <div className="radar-details">
                        <div className="card" style={{ marginBottom: '1rem' }}>
                            <h3 style={{ fontSize: '1.05rem', marginBottom: '1rem' }}>Boyut Skorları</h3>
                            {dimensions.map((d, i) => (
                                <div key={d.key} style={{ marginBottom: '0.75rem' }}>
                                    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.25rem' }}>
                                        <span style={{ fontSize: '0.85rem', fontWeight: 500, color: d.color }}>{d.label}</span>
                                        <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.85rem', fontWeight: 700, color: d.color }}>{scores[i]}</span>
                                    </div>
                                    <div style={{ height: '4px', borderRadius: '100px', background: 'var(--bg-nebula)', overflow: 'hidden' }}>
                                        <div style={{
                                            width: `${scores[i]}%`,
                                            height: '100%',
                                            borderRadius: '100px',
                                            background: d.color,
                                            transition: 'width 0.8s ease',
                                        }} />
                                    </div>
                                </div>
                            ))}
                        </div>

                        <div className="kpi-card kpi-card--cyan">
                            <div className="kpi-card__value">{avg.toFixed(0)}</div>
                            <div className="kpi-card__label">Ortalama Yetkinlik Skoru</div>
                        </div>

                        {/* Mentor comment */}
                        <div className="card" style={{ marginTop: '1rem', borderColor: 'rgba(167, 139, 250, 0.2)' }}>
                            <p style={{ fontSize: '0.85rem', fontStyle: 'italic', color: 'var(--text-secondary)', lineHeight: '1.8' }}>
                                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ display: 'inline', verticalAlign: 'text-bottom', marginRight: '0.5rem' }}>
                                    <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                                </svg>
                                <strong style={{ color: 'var(--accent-violet)' }}>Mentor Notu:</strong>{' '}
                                {avg >= 50
                                    ? 'Etkileyici bir performans! Problem tanımlama ve analiz becerilerinde güçlü bir temel var. Transfer yetkinliğini daha da geliştirmek için farklı vaka çalışmaları öneriyorum.'
                                    : 'İyi bir başlangıç! Her bölümle etkileşime geçtikçe radar grafiğin dolacak. Denemekten çekinme — öğrenme yolculuğu burada başlıyor.'}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    );
}
