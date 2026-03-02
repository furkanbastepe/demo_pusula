import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

export default function SnapshotCTA() {
    const { state } = usePusula();
    const { ref, isVisible } = useInView(0.15);

    const snapshot = {
        platform: 'PUSULA',
        ortaklik: 'UNDP × TBB Dijital Gençlik Merkezi',
        hedefKitle: '18-29 yaş gençler',
        yontem: 'Problem Tabanlı Öğrenme',
        pilot: '8 hafta, 50 katılımcı',
        stage: state.stage,
        rubric: state.rubricScores,
        claims: [
            { id: 'c1', text: 'Problem tabanlı öğrenme geleneksel yöntemlere göre %23 daha etkili', level: 'Meta-analiz', sourceUrl: 'doi:10.3102/0034654315626799' },
            { id: 'c2', text: 'Feynman tekniği bilgi kalıcılığını artırır', level: 'Deneysel çalışma', sourceUrl: 'doi:10.1016/j.learninstruc.2014.02.003' },
            { id: 'c3', text: 'Akran öğretimi motivasyonu %34 artırır', level: 'RCT', sourceUrl: 'doi:10.1080/01443410.2016.1160925' },
        ],
    };

    const handleExport = () => {
        const blob = new Blob([JSON.stringify(snapshot, null, 2)], { type: 'application/json' });
        const url = URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = 'pusula-snapshot.json';
        a.click();
        URL.revokeObjectURL(url);
    };

    return (
        <section className="section" id="snapshot-cta" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className="container container--narrow" style={{ textAlign: 'center' }}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`} style={{ justifyContent: 'center' }}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" />
                    </svg>
                    Karar Noktası
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.75rem' }}>
                    <span style={{ color: 'var(--accent-emerald)' }}>Pilot Projeyi</span> Başlatalım
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2.5rem', maxWidth: '500px', margin: '0 auto 2.5rem' }}>
                    Az önce PUSULA'nın problem tabanlı öğrenme döngüsünü deneyimledin.
                    Bu modeli dijital gençlik merkezinde uygulamaya hazırız.
                </p>

                {/* Snapshot summary */}
                <div className={`snapshot-grid reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    <div className="card" style={{ textAlign: 'left' }}>
                        <h3 style={{ fontSize: '0.95rem', marginBottom: '0.75rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" /><polyline points="14 2 14 8 20 8" />
                            </svg>
                            Proje Özeti
                        </h3>
                        <div style={{ fontSize: '0.85rem', lineHeight: '2' }}>
                            <div><span style={{ color: 'var(--text-muted)' }}>Platform:</span> <strong>PUSULA</strong></div>
                            <div><span style={{ color: 'var(--text-muted)' }}>Ortaklık:</span> UNDP × TBB</div>
                            <div><span style={{ color: 'var(--text-muted)' }}>Hedef Kitle:</span> 18-29 yaş gençler</div>
                            <div><span style={{ color: 'var(--text-muted)' }}>Yöntem:</span> Problem Tabanlı Öğrenme</div>
                            <div><span style={{ color: 'var(--text-muted)' }}>Pilot:</span> 8 hafta, 50 katılımcı</div>
                        </div>
                    </div>

                    <div className="card" style={{ textAlign: 'left' }}>
                        <h3 style={{ fontSize: '0.95rem', marginBottom: '0.75rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                <polyline points="9 11 12 14 22 4" /><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11" />
                            </svg>
                            Kanıt Tabanı
                        </h3>
                        {snapshot.claims.map(c => (
                            <div key={c.id} style={{ fontSize: '0.8rem', lineHeight: '1.7', marginBottom: '0.5rem', paddingLeft: '0.75rem', borderLeft: '2px solid var(--border-dim)' }}>
                                <div style={{ color: 'var(--text-secondary)' }}>{c.text}</div>
                                <div style={{ color: 'var(--text-muted)', fontFamily: 'var(--font-mono)', fontSize: '0.7rem' }}>
                                    <span className="badge badge--cyan" style={{ fontSize: '0.65rem', padding: '0.125rem 0.5rem' }}>{c.level}</span>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* CTA Buttons */}
                <div className={`reveal ${isVisible ? 'visible' : ''} delay-4`} style={{ display: 'flex', gap: '1rem', justifyContent: 'center', flexWrap: 'wrap', marginTop: '0.5rem' }}>
                    <button className="btn btn--emerald" style={{ fontSize: '1.1rem', padding: '1rem 2.5rem' }}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z" />
                        </svg>
                        Pilot Projesi Başlatalım
                    </button>
                    <button className="btn btn--secondary" onClick={handleExport}>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" />
                        </svg>
                        Snapshot İndir (JSON)
                    </button>
                </div>
            </div>
        </section>
    );
}
