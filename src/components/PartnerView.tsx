import { useState, useMemo } from 'react';
import { usePusula } from '../state/PusulaContext';

const MOCK_CENTERS = [
    { name: 'Eskişehir Merkez', aktif: 142, tamamlama: 73, staj: 23 },
    { name: 'Ankara Merkez', aktif: 198, tamamlama: 68, staj: 31 },
    { name: 'İstanbul Merkez', aktif: 256, tamamlama: 71, staj: 44 },
    { name: 'İzmir Merkez', aktif: 167, tamamlama: 75, staj: 27 },
    { name: 'Bursa Merkez', aktif: 89, tamamlama: 62, staj: 14 },
];

const WEEKLY_TREND = [32, 45, 58, 71, 86, 79, 92, 88]; // last 8 weeks

const SDG_SCORES = [
    { label: 'SDG 4: Nitelikli Eğitim', score: 85, color: 'var(--accent-cyan)' },
    { label: 'SDG 8: İnsana Yakışır İş', score: 67, color: 'var(--accent-emerald)' },
    { label: 'SDG 11: Sürdürülebilir Şehirler', score: 45, color: 'var(--accent-violet)' },
    { label: 'SDG 17: Ortaklıklar', score: 58, color: 'var(--accent-amber)' },
];

const SKILLS_DATA = [
    { name: 'Python Temelleri', pct: 78 },
    { name: 'Veri Analizi', pct: 62 },
    { name: 'Problem Çözme', pct: 81 },
    { name: 'Algoritmik Düşünme', pct: 55 },
    { name: 'İletişim', pct: 70 },
];

export default function PartnerView() {
    const { state } = usePusula();
    const [isOpen, setIsOpen] = useState(false);
    const [activeTab, setActiveTab] = useState<'overview' | 'centers' | 'sdg'>('overview');

    const maxTrend = useMemo(() => Math.max(...WEEKLY_TREND), []);

    const totalYouth = MOCK_CENTERS.reduce((s, c) => s + c.aktif, 0);
    const avgCompletion = Math.round(MOCK_CENTERS.reduce((s, c) => s + c.tamamlama, 0) / MOCK_CENTERS.length);
    const totalInternships = MOCK_CENTERS.reduce((s, c) => s + c.staj, 0);

    if (!isOpen) {
        return (
            <button
                className="partner-view-toggle"
                onClick={() => setIsOpen(true)}
                title="Partner / Yatırımcı Görünümü"
            >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M2 3h6a4 4 0 0 1 4 4v14a3 3 0 0 0-3-3H2z" />
                    <path d="M22 3h-6a4 4 0 0 0-4 4v14a3 3 0 0 1 3-3h7z" />
                </svg>
                Partner View
            </button>
        );
    }

    return (
        <div className="partner-overlay" onClick={() => setIsOpen(false)}>
            <div className="partner-panel" onClick={e => e.stopPropagation()}>
                {/* Header */}
                <div className="partner-header">
                    <div>
                        <h2 style={{ fontSize: '1.15rem', fontWeight: 800, fontFamily: 'var(--font-display)', color: 'var(--text-primary)', margin: 0 }}>
                            PUSULA — Merkez Yönetim Paneli
                        </h2>
                        <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', margin: '0.25rem 0 0' }}>
                            Gerçek zamanlı merkez analitikleri • Demo modu
                        </p>
                    </div>
                    <button className="partner-close" onClick={() => setIsOpen(false)}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" />
                        </svg>
                    </button>
                </div>

                {/* Tabs */}
                <div className="partner-tabs">
                    {(['overview', 'centers', 'sdg'] as const).map(tab => (
                        <button
                            key={tab}
                            className={`partner-tab ${activeTab === tab ? 'partner-tab--active' : ''}`}
                            onClick={() => setActiveTab(tab)}
                        >
                            {tab === 'overview' && 'Genel Bakış'}
                            {tab === 'centers' && 'Merkezler'}
                            {tab === 'sdg' && 'SDG Etkisi'}
                        </button>
                    ))}
                </div>

                {/* Overview Tab */}
                {activeTab === 'overview' && (
                    <div className="partner-content">
                        {/* KPI Cards */}
                        <div className="partner-kpi-grid">
                            <div className="partner-kpi">
                                <div className="partner-kpi__value" style={{ color: 'var(--accent-cyan)' }}>{totalYouth}</div>
                                <div className="partner-kpi__label">Aktif Genç</div>
                            </div>
                            <div className="partner-kpi">
                                <div className="partner-kpi__value" style={{ color: 'var(--accent-emerald)' }}>%{avgCompletion}</div>
                                <div className="partner-kpi__label">Ort. Tamamlama</div>
                            </div>
                            <div className="partner-kpi">
                                <div className="partner-kpi__value" style={{ color: 'var(--accent-amber)' }}>{totalInternships}</div>
                                <div className="partner-kpi__label">Staj Eşleşme</div>
                            </div>
                            <div className="partner-kpi">
                                <div className="partner-kpi__value" style={{ color: 'var(--accent-violet)' }}>5</div>
                                <div className="partner-kpi__label">Aktif Merkez</div>
                            </div>
                        </div>

                        {/* Skill Distribution */}
                        <div className="partner-section">
                            <h3 className="partner-section__title">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <line x1="18" y1="20" x2="18" y2="10" /><line x1="12" y1="20" x2="12" y2="4" /><line x1="6" y1="20" x2="6" y2="14" />
                                </svg>
                                Ortalama Yetkinlik Dağılımı
                            </h3>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                                {SKILLS_DATA.map(skill => (
                                    <div key={skill.name} style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
                                        <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', minWidth: '120px' }}>{skill.name}</span>
                                        <div style={{ flex: 1, height: '8px', background: 'var(--bg-void)', borderRadius: '4px', overflow: 'hidden' }}>
                                            <div style={{
                                                width: `${skill.pct}%`,
                                                height: '100%',
                                                background: `linear-gradient(90deg, var(--accent-cyan), var(--accent-emerald))`,
                                                borderRadius: '4px',
                                                transition: 'width 1s ease',
                                            }} />
                                        </div>
                                        <span style={{ fontSize: '0.75rem', fontFamily: 'var(--font-mono)', color: 'var(--text-muted)', minWidth: '35px', textAlign: 'right' }}>%{skill.pct}</span>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Weekly Trend */}
                        <div className="partner-section">
                            <h3 className="partner-section__title">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <polyline points="22 12 18 12 15 21 9 3 6 12 2 12" />
                                </svg>
                                Haftalık Etkileşim Trendi (son 8 hafta)
                            </h3>
                            <div style={{ display: 'flex', alignItems: 'flex-end', gap: '4px', height: '80px' }}>
                                {WEEKLY_TREND.map((val, i) => (
                                    <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px' }}>
                                        <div style={{
                                            width: '100%',
                                            height: `${(val / maxTrend) * 70}px`,
                                            background: i === WEEKLY_TREND.length - 1
                                                ? 'linear-gradient(to top, var(--accent-emerald), rgba(52,211,153,0.3))'
                                                : 'linear-gradient(to top, var(--accent-cyan), rgba(56,189,248,0.2))',
                                            borderRadius: '3px 3px 0 0',
                                            transition: 'height 0.5s ease',
                                        }} />
                                        <span style={{ fontSize: '0.6rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>
                                            H{i + 1}
                                        </span>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Employment Pipeline */}
                        <div className="partner-section">
                            <h3 className="partner-section__title">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <rect x="2" y="7" width="20" height="14" rx="2" ry="2" /><path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16" />
                                </svg>
                                İstihdam Havuzu
                            </h3>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr 1fr', gap: '0.5rem' }}>
                                <div style={{ textAlign: 'center', padding: '0.75rem', background: 'var(--bg-void)', borderRadius: '8px', border: '1px solid var(--border-dim)' }}>
                                    <div style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--accent-cyan)', fontFamily: 'var(--font-display)' }}>139</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>Staj Eşleşme</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.75rem', background: 'var(--bg-void)', borderRadius: '8px', border: '1px solid var(--border-dim)' }}>
                                    <div style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--accent-emerald)', fontFamily: 'var(--font-display)' }}>42</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>İş Teklifi</div>
                                </div>
                                <div style={{ textAlign: 'center', padding: '0.75rem', background: 'var(--bg-void)', borderRadius: '8px', border: '1px solid var(--border-dim)' }}>
                                    <div style={{ fontSize: '1.5rem', fontWeight: 800, color: 'var(--accent-amber)', fontFamily: 'var(--font-display)' }}>18</div>
                                    <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>Freelance</div>
                                </div>
                            </div>
                        </div>
                    </div>
                )}

                {/* Centers Tab */}
                {activeTab === 'centers' && (
                    <div className="partner-content">
                        <div className="partner-section">
                            <h3 className="partner-section__title">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" /><circle cx="12" cy="10" r="3" />
                                </svg>
                                Merkez Performansları
                            </h3>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                                {MOCK_CENTERS.map((center, i) => (
                                    <div key={center.name} style={{
                                        display: 'flex', alignItems: 'center', gap: '0.75rem',
                                        padding: '0.6rem 0.75rem', background: 'var(--bg-void)', borderRadius: '8px',
                                        border: '1px solid var(--border-dim)',
                                    }}>
                                        <span style={{
                                            width: '24px', height: '24px', borderRadius: '6px',
                                            display: 'flex', alignItems: 'center', justifyContent: 'center',
                                            fontSize: '0.7rem', fontWeight: 800, fontFamily: 'var(--font-mono)',
                                            background: i === 0 ? 'var(--accent-cyan-dim)' : 'rgba(255,255,255,0.03)',
                                            color: i === 0 ? 'var(--accent-cyan)' : 'var(--text-muted)',
                                        }}>
                                            {i + 1}
                                        </span>
                                        <div style={{ flex: 1 }}>
                                            <div style={{ fontSize: '0.85rem', fontWeight: 600, color: 'var(--text-primary)' }}>{center.name}</div>
                                            <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                                                {center.aktif} genç • %{center.tamamlama} tamamlama • {center.staj} staj
                                            </div>
                                        </div>
                                        <div style={{ width: '60px', height: '6px', background: 'rgba(255,255,255,0.05)', borderRadius: '3px', overflow: 'hidden' }}>
                                            <div style={{
                                                width: `${center.tamamlama}%`, height: '100%',
                                                background: center.tamamlama > 70 ? 'var(--accent-emerald)' : 'var(--accent-amber)',
                                                borderRadius: '3px',
                                            }} />
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* Map placeholder */}
                        <div className="partner-section" style={{ textAlign: 'center' }}>
                            <div style={{
                                padding: '2rem', borderRadius: '12px',
                                background: 'var(--bg-void)', border: '1px dashed var(--border-dim)',
                            }}>
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="var(--text-muted)" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" style={{ opacity: 0.5 }}>
                                    <polygon points="1 6 1 22 8 18 16 22 23 18 23 2 16 6 8 2 1 6" />
                                    <line x1="8" y1="2" x2="8" y2="18" /><line x1="16" y1="6" x2="16" y2="22" />
                                </svg>
                                <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginTop: '0.75rem' }}>
                                    Türkiye Merkez Haritası — Canlı sistemde interaktif
                                </p>
                            </div>
                        </div>
                    </div>
                )}

                {/* SDG Tab */}
                {activeTab === 'sdg' && (
                    <div className="partner-content">
                        <div className="partner-section">
                            <h3 className="partner-section__title">
                                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <circle cx="12" cy="12" r="10" /><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20" /><path d="M2 12h20" />
                                </svg>
                                Sürdürülebilir Kalkınma Hedefleri Etkisi
                            </h3>
                            <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
                                {SDG_SCORES.map(sdg => (
                                    <div key={sdg.label}>
                                        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.35rem' }}>
                                            <span style={{ fontSize: '0.8rem', color: 'var(--text-secondary)' }}>{sdg.label}</span>
                                            <span style={{ fontSize: '0.8rem', fontFamily: 'var(--font-mono)', color: sdg.color, fontWeight: 700 }}>%{sdg.score}</span>
                                        </div>
                                        <div style={{ height: '10px', background: 'var(--bg-void)', borderRadius: '5px', overflow: 'hidden' }}>
                                            <div style={{
                                                width: `${sdg.score}%`, height: '100%',
                                                background: `linear-gradient(90deg, ${sdg.color}, color-mix(in srgb, ${sdg.color} 40%, transparent))`,
                                                borderRadius: '5px',
                                                transition: 'width 1.5s ease',
                                            }} />
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>

                        {/* UNDP Alignment */}
                        <div className="partner-section" style={{
                            background: 'rgba(52,211,153,0.04)',
                            border: '1px solid rgba(52,211,153,0.15)',
                            borderRadius: '10px', padding: '1rem',
                        }}>
                            <h3 style={{ fontSize: '0.85rem', color: 'var(--accent-emerald)', marginBottom: '0.5rem', fontWeight: 700 }}>UNDP Uyum Raporu</h3>
                            <p style={{ fontSize: '0.8rem', color: 'var(--text-secondary)', lineHeight: 1.7, margin: 0 }}>
                                PUSULA platformu, BM Sürdürülebilir Kalkınma Hedefleri'nden <strong style={{ color: 'var(--accent-cyan)' }}>4 tanesine</strong> doğrudan
                                katkı sağlamaktadır. Özellikle <strong>SDG 4</strong> (Nitelikli Eğitim) ve <strong>SDG 8</strong> (İnsana
                                Yakışır İş) alanlarında ölçülebilir çıktılar üretmektedir. 852 gencin dijital
                                yetkinlik kazanımı ve 139 staj eşleşmesi pilot sonuçlarımızdır.
                            </p>
                        </div>

                        {/* Pilot metrics */}
                        <div className="partner-section">
                            <h3 className="partner-section__title">Pilot Sonuçları (6 Ay)</h3>
                            <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.5rem' }}>
                                {[
                                    { label: 'Dijital Okuryazar', val: '852 genç', color: 'var(--accent-cyan)' },
                                    { label: 'Ortalama Öğrenme', val: '12.4 saat', color: 'var(--accent-emerald)' },
                                    { label: 'İstihdam Oranı', val: '%34 artış', color: 'var(--accent-amber)' },
                                    { label: 'NPS Skoru', val: '78/100', color: 'var(--accent-violet)' },
                                ].map(m => (
                                    <div key={m.label} style={{
                                        textAlign: 'center', padding: '0.6rem',
                                        background: 'var(--bg-void)', borderRadius: '8px',
                                        border: '1px solid var(--border-dim)',
                                    }}>
                                        <div style={{ fontSize: '1.1rem', fontWeight: 800, color: m.color, fontFamily: 'var(--font-display)' }}>{m.val}</div>
                                        <div style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>{m.label}</div>
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                )}

                {/* Footer */}
                <div className="partner-footer">
                    <span style={{ fontSize: '0.7rem', color: 'var(--text-muted)' }}>
                        Demo modu • Veriler simüle edilmiştir
                    </span>
                    <span style={{ fontSize: '0.7rem', color: 'var(--accent-cyan)' }}>
                        UNDP × TBB × PUSULA
                    </span>
                </div>
            </div>
        </div>
    );
}
