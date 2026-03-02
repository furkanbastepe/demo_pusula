import { useMemo } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

export default function Certificate() {
    const { state } = usePusula();
    const { ref, isVisible } = useInView(0.1);

    const today = useMemo(() => {
        const d = new Date();
        return `${d.getDate()} ${['Ocak', 'Şubat', 'Mart', 'Nisan', 'Mayıs', 'Haziran', 'Temmuz', 'Ağustos', 'Eylül', 'Ekim', 'Kasım', 'Aralık'][d.getMonth()]} ${d.getFullYear()}`;
    }, []);

    const skills = useMemo(() => {
        const s: { name: string; done: boolean }[] = [
            { name: 'Değişkenler', done: state.warmupCompleted },
            { name: 'Koşullar (if/else)', done: state.warmupCompleted },
            { name: 'Fonksiyonlar', done: state.warmupCompleted },
            { name: 'Algoritmik Düşünme', done: state.warmupCompleted },
            { name: 'Problem Analizi', done: state.stage !== 'intro' },
            { name: 'Veri Modelleme', done: !!state.meridyenIntent },
        ];
        return s;
    }, [state]);

    const completedCount = skills.filter(s => s.done).length;
    const progressPct = Math.round((completedCount / skills.length) * 100);

    const handleDownload = () => {
        const svg = document.getElementById('pusula-certificate-svg');
        if (!svg) return;
        const serializer = new XMLSerializer();
        const svgStr = serializer.serializeToString(svg);
        const canvas = document.createElement('canvas');
        canvas.width = 800;
        canvas.height = 500;
        const ctx = canvas.getContext('2d');
        const img = new Image();
        img.onload = () => {
            ctx?.drawImage(img, 0, 0);
            const link = document.createElement('a');
            link.download = 'pusula-sertifika.png';
            link.href = canvas.toDataURL('image/png');
            link.click();
        };
        img.src = 'data:image/svg+xml;charset=utf-8,' + encodeURIComponent(svgStr);
    };

    return (
        <section className="section" id="certificate" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className="container" style={{ textAlign: 'center' }}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <circle cx="12" cy="8" r="6" /><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11" />
                    </svg>
                    Sertifika
                </div>
                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`}>
                    Dijital <span style={{ color: 'var(--accent-emerald)' }}>Beceri</span> Sertifikan
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ maxWidth: '550px', margin: '0 auto 2rem' }}>
                    Demo'da edindiğin becerilerin özeti. İndir, paylaş, portfolyona ekle.
                </p>

                {/* SVG Certificate */}
                <div className={`reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ maxWidth: '700px', margin: '0 auto' }}>
                    <svg id="pusula-certificate-svg" viewBox="0 0 800 500" xmlns="http://www.w3.org/2000/svg" style={{ width: '100%', borderRadius: '16px', border: '1px solid var(--border-dim)' }}>
                        {/* Background */}
                        <defs>
                            <linearGradient id="cert-bg" x1="0%" y1="0%" x2="100%" y2="100%">
                                <stop offset="0%" stopColor="#0a0e1a" />
                                <stop offset="100%" stopColor="#0f1729" />
                            </linearGradient>
                            <linearGradient id="cert-accent" x1="0%" y1="0%" x2="100%" y2="0%">
                                <stop offset="0%" stopColor="#38bdf8" />
                                <stop offset="100%" stopColor="#34d399" />
                            </linearGradient>
                        </defs>
                        <rect width="800" height="500" rx="16" fill="url(#cert-bg)" />

                        {/* Border glow */}
                        <rect x="16" y="16" width="768" height="468" rx="12" fill="none" stroke="url(#cert-accent)" strokeWidth="1" opacity="0.3" />

                        {/* Corner decorations */}
                        <path d="M40 40 L80 40 L40 40 L40 80" stroke="#38bdf8" strokeWidth="2" opacity="0.5" fill="none" />
                        <path d="M760 40 L720 40 M760 40 L760 80" stroke="#38bdf8" strokeWidth="2" opacity="0.5" fill="none" />
                        <path d="M40 460 L80 460 M40 460 L40 420" stroke="#34d399" strokeWidth="2" opacity="0.5" fill="none" />
                        <path d="M760 460 L720 460 M760 460 L760 420" stroke="#34d399" strokeWidth="2" opacity="0.5" fill="none" />

                        {/* Logo */}
                        <circle cx="400" cy="72" r="20" stroke="#38bdf8" strokeWidth="1.5" fill="none" />
                        <polygon points="400,56 403,67 400,69 397,67" fill="#38bdf8" />
                        <circle cx="400" cy="72" r="3" fill="#38bdf8" />

                        {/* Title */}
                        <text x="400" y="120" textAnchor="middle" fill="#f8fafc" fontSize="14" fontFamily="monospace" letterSpacing="4" opacity="0.6">PUSULA DİJİTAL BECERİ PROGRAMI</text>
                        <text x="400" y="156" textAnchor="middle" fill="#f8fafc" fontSize="28" fontFamily="system-ui, sans-serif" fontWeight="700">Katılım Sertifikası</text>

                        {/* Divider */}
                        <line x1="300" y1="175" x2="500" y2="175" stroke="url(#cert-accent)" strokeWidth="1.5" opacity="0.5" />

                        {/* Name */}
                        <text x="400" y="220" textAnchor="middle" fill="#38bdf8" fontSize="22" fontFamily="system-ui, sans-serif" fontWeight="600">Demo Katılımcısı</text>
                        <text x="400" y="250" textAnchor="middle" fill="#94a3b8" fontSize="13" fontFamily="system-ui, sans-serif">UNDP × TBB Dijital Gençlik Merkezi</text>

                        {/* Skills grid */}
                        {skills.map((skill, i) => {
                            const col = i % 3;
                            const row = Math.floor(i / 3);
                            const x = 180 + col * 220;
                            const y = 290 + row * 50;
                            return (
                                <g key={i}>
                                    <rect x={x - 80} y={y - 16} width="160" height="32" rx="6" fill={skill.done ? 'rgba(52,211,153,0.1)' : 'rgba(255,255,255,0.03)'} stroke={skill.done ? 'rgba(52,211,153,0.3)' : 'rgba(255,255,255,0.06)'} strokeWidth="1" />
                                    {skill.done ? (
                                        <text x={x - 64} y={y + 5} fill="#34d399" fontSize="14" fontFamily="system-ui">✓</text>
                                    ) : (
                                        <text x={x - 64} y={y + 5} fill="#475569" fontSize="14" fontFamily="system-ui">○</text>
                                    )}
                                    <text x={x - 48} y={y + 5} fill={skill.done ? '#e2e8f0' : '#64748b'} fontSize="12" fontFamily="system-ui, sans-serif">{skill.name}</text>
                                </g>
                            );
                        })}

                        {/* Progress bar */}
                        <rect x="180" y="400" width="440" height="6" rx="3" fill="rgba(255,255,255,0.06)" />
                        <rect x="180" y="400" width={440 * progressPct / 100} height="6" rx="3" fill="url(#cert-accent)" />
                        <text x="400" y="426" textAnchor="middle" fill="#64748b" fontSize="11" fontFamily="monospace">{completedCount}/{skills.length} beceri · %{progressPct} tamamlandı</text>

                        {/* Date */}
                        <text x="400" y="468" textAnchor="middle" fill="#475569" fontSize="11" fontFamily="monospace">{today}</text>
                    </svg>
                </div>

                {/* Action buttons */}
                <div className={`reveal ${isVisible ? 'visible' : ''} delay-4`} style={{ display: 'flex', gap: '1rem', justifyContent: 'center', marginTop: '1.5rem', flexWrap: 'wrap' }}>
                    <button className="btn btn--primary" onClick={handleDownload} style={{ cursor: 'pointer' }}>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginRight: '0.5rem' }}>
                            <path d="M21 15v4a2 2 0 01-2 2H5a2 2 0 01-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" />
                        </svg>
                        PNG İndir
                    </button>
                    <button className="btn btn--secondary" onClick={() => {
                        if (navigator.share) {
                            navigator.share({ title: 'PUSULA Dijital Beceri Sertifikam', text: 'PUSULA Dijital Gençlik Programı demo sertifikamı aldım!' });
                        } else {
                            navigator.clipboard.writeText(window.location.href);
                            alert('Link kopyalandı!');
                        }
                    }} style={{ cursor: 'pointer' }}>
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ marginRight: '0.5rem' }}>
                            <circle cx="18" cy="5" r="3" /><circle cx="6" cy="12" r="3" /><circle cx="18" cy="19" r="3" /><line x1="8.59" y1="13.51" x2="15.42" y2="17.49" /><line x1="15.41" y1="6.51" x2="8.59" y2="10.49" />
                        </svg>
                        Paylaş
                    </button>
                </div>

                {/* Mentor outreach CTA */}
                <div className={`card reveal ${isVisible ? 'visible' : ''} delay-5`} style={{ marginTop: '2rem', maxWidth: '600px', marginLeft: 'auto', marginRight: 'auto', borderColor: 'rgba(56,189,248,0.15)', textAlign: 'left' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', marginBottom: '0.75rem' }}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4-4v2" /><circle cx="9" cy="7" r="4" /><path d="M23 21v-2a4 4 0 00-3-3.87" /><path d="M16 3.13a4 4 0 010 7.75" />
                        </svg>
                        <h4 style={{ fontSize: '0.95rem', color: 'var(--text-primary)' }}>Dijital Gençlik Merkezinde Devam Et</h4>
                    </div>
                    <p style={{ fontSize: '0.85rem', lineHeight: 1.6, color: 'var(--text-muted)', marginBottom: '1rem' }}>
                        Bu demo yalnızca başlangıç. Dijital gençlik merkezlerinde <strong style={{ color: 'var(--text-secondary)' }}>mentor eşliğinde 8 haftalık program</strong>, Lonca sistemi ile akran öğrenme ve gerçek Bot Arena turnuvaları seni bekliyor.
                    </p>
                    <div style={{ display: 'flex', gap: '0.75rem', fontSize: '0.75rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>
                        <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2"><path d="M22 11.08V12a10 10 0 11-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" /></svg>
                            81 merkez
                        </span>
                        <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4-4v2" /><circle cx="9" cy="7" r="4" /></svg>
                            10.000+ genç
                        </span>
                        <span style={{ display: 'flex', alignItems: 'center', gap: '0.25rem' }}>
                            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2" /><line x1="16" y1="2" x2="16" y2="6" /><line x1="8" y1="2" x2="8" y2="6" /></svg>
                            8 hafta
                        </span>
                    </div>
                </div>
            </div>
        </section>
    );
}
