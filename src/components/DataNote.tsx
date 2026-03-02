export default function DataNote() {
    return (
        <footer className="data-note" id="data-note">
            <div style={{ marginBottom: '1rem' }}>
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="var(--text-muted)" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" style={{ margin: '0 auto 0.5rem', display: 'block' }}>
                    <circle cx="12" cy="12" r="10" />
                    <line x1="12" y1="16" x2="12" y2="12" />
                    <line x1="12" y1="8" x2="12.01" y2="8" />
                </svg>
            </div>
            <p style={{ marginBottom: '0.75rem' }}>
                <strong style={{ color: 'var(--text-secondary)' }}>Veri Notu:</strong> Bu demoda kullanılan tüm veriler simülasyon amaçlıdır.
                Gerçek pilot veriler proje başlangıcında entegre edilecektir.
            </p>
            <p>
                Kaynak seviyeleri: <em>Meta-analiz</em> (en güçlü), <em>RCT</em> (güçlü), <em>Deneysel çalışma</em> (orta), <em>Uzman görüşü</em> (düşük).
            </p>
            <p style={{ marginTop: '1.5rem', fontSize: '0.75rem' }}>
                © 2026 PUSULA — UNDP × TBB Dijital Gençlik Merkezi
            </p>
        </footer>
    );
}
