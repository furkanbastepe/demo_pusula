import { useInView, useAnimatedCounter } from '../hooks/useInView';

const kpis = [
    { label: 'Günlük Aktif Kullanıcı', target: 342, suffix: '', color: 'cyan' as const },
    { label: 'Tamamlanan Vaka', target: 1847, suffix: '', color: 'emerald' as const },
    { label: 'Ortalama Yetkinlik', target: 73, suffix: '%', color: 'amber' as const },
    { label: 'Öğretme Puanı', target: 87, suffix: '', color: 'violet' as const },
];

const timelineData = [
    { week: 'H1', users: 45, cases: 120 },
    { week: 'H2', users: 89, cases: 310 },
    { week: 'H3', users: 156, cases: 580 },
    { week: 'H4', users: 210, cases: 870 },
    { week: 'H5', users: 268, cases: 1200 },
    { week: 'H6', users: 310, cases: 1520 },
    { week: 'H7', users: 335, cases: 1720 },
    { week: 'H8', users: 342, cases: 1847 },
];

function KPICard({ label, target, suffix, color }: { label: string; target: number; suffix: string; color: string }) {
    const { ref, isVisible } = useInView(0.3);
    const value = useAnimatedCounter(target, 1500, isVisible);

    return (
        <div ref={ref} className={`kpi-card kpi-card--${color}`}>
            <div className="kpi-card__value">{value.toLocaleString()}{suffix}</div>
            <div className="kpi-card__label">{label}</div>
        </div>
    );
}

export default function OpsCockpit() {
    const { ref, isVisible } = useInView(0.15);
    const maxUsers = Math.max(...timelineData.map(d => d.users));

    return (
        <section className="section" id="ops-cockpit" ref={ref}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <rect x="3" y="3" width="7" height="7" /><rect x="14" y="3" width="7" height="7" /><rect x="14" y="14" width="7" height="7" /><rect x="3" y="14" width="7" height="7" />
                    </svg>
                    Operasyon Kokpiti
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Platform <span style={{ color: 'var(--accent-cyan)' }}>Performansı</span>
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    8 haftalık pilot projeksiyonu. Tüm metrikler simülasyon verileridir; gerçek rakamlar pilot sonrasında güncellenecektir.
                </p>

                {/* KPI Grid */}
                <div className={`grid-4 reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ marginBottom: '2rem' }}>
                    {kpis.map(k => (
                        <KPICard key={k.label} {...k} />
                    ))}
                </div>

                {/* Timeline chart */}
                <div className={`card reveal ${isVisible ? 'visible' : ''} delay-4`}>
                    <h3 style={{ fontSize: '1rem', marginBottom: '1.25rem' }}>8 Haftalık Büyüme Projeksiyonu</h3>
                    <div style={{ display: 'flex', alignItems: 'flex-end', gap: '8px', height: '180px', padding: '0 0.5rem' }}>
                        {timelineData.map(d => (
                            <div key={d.week} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px' }}>
                                <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.7rem', color: 'var(--accent-cyan)', fontWeight: 600 }}>
                                    {d.users}
                                </span>
                                <div
                                    style={{
                                        width: '100%',
                                        height: `${(d.users / maxUsers) * 140}px`,
                                        background: 'linear-gradient(to top, var(--accent-cyan), rgba(56,189,248,0.4))',
                                        borderRadius: '6px 6px 2px 2px',
                                        transition: 'height 0.8s ease',
                                        minHeight: '8px',
                                    }}
                                />
                                <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                                    {d.week}
                                </span>
                            </div>
                        ))}
                    </div>
                    <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '0.75rem', paddingTop: '0.75rem', borderTop: '1px solid var(--border-dim)' }}>
                        <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>
                            <span style={{ display: 'inline-block', width: '10px', height: '10px', borderRadius: '2px', background: 'var(--accent-cyan)', marginRight: '0.5rem', verticalAlign: 'middle' }} />
                            Aktif Kullanıcı
                        </span>
                        <span style={{ fontSize: '0.8rem', color: 'var(--text-muted)', fontStyle: 'italic' }}>Simülasyon Verisi</span>
                    </div>
                </div>
            </div>
        </section>
    );
}
