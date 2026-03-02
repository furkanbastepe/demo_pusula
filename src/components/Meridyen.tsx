import { useState, useCallback } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

const intentTemplates = [
    {
        id: 'capacity',
        label: 'Kapasiteyi Artır',
        desc: 'Daha fazla gişe açarak hizmet kapasitesini artırmak',
        icon: 'bar-chart',
        variables: [
            { label: 'Açık gişe sayısı', variable: 'acik_gise', op: '+' },
        ],
    },
    {
        id: 'speed',
        label: 'İşlem Hızlandır',
        desc: 'Her bir işlemin süresini kısaltarak akışı hızlandırmak',
        icon: 'zap',
        variables: [
            { label: 'İşlem süresi', variable: 'islem_suresi_dk', op: '−' },
        ],
    },
    {
        id: 'priority',
        label: 'Yoğun Saat Yönetimi',
        desc: 'Yoğun saatlerde önceliklendirme ile kuyruğu yönetmek',
        icon: 'target',
        variables: [
            { label: 'Gelen müşteri/saat', variable: 'gelen_musteri_saat', op: '÷' },
            { label: 'Öncelikli oran', variable: 'oncelikli_oran', op: '×' },
        ],
    },
];

export default function Meridyen() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);
    const [freeText, setFreeText] = useState('');
    const [selectedId, setSelectedId] = useState<string | null>(null);
    const [showMapping, setShowMapping] = useState(false);

    const isUnlocked = state.stage !== 'intro';
    const alreadyMapped = state.meridyenIntent !== null;

    const handleSelect = useCallback((id: string) => {
        if (alreadyMapped) return;
        setSelectedId(id);
    }, [alreadyMapped]);

    const handleConfirm = useCallback(() => {
        if (!selectedId) return;
        const template = intentTemplates.find(t => t.id === selectedId);
        if (!template) return;
        dispatch({
            type: 'SET_MERIDYEN',
            intent: template.label,
            variables: template.variables,
        });
        setShowMapping(true);
    }, [selectedId, dispatch]);

    const chosenTemplate = intentTemplates.find(t => t.id === (alreadyMapped ? intentTemplates.find(t2 => t2.label === state.meridyenIntent)?.id : selectedId));

    return (
        <section className="section" id="meridyen" ref={ref}>
            <div className={`container container--narrow ${!isUnlocked ? 'gate--locked' : ''}`}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <circle cx="12" cy="12" r="10" /><line x1="2" y1="12" x2="22" y2="12" /><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
                    </svg>
                    Meridyen Anı
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Düşüncen <span style={{ color: 'var(--accent-violet)' }}>Modele</span> Dönüşüyor
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem' }}>
                    Belediye kuyruğu sorununu çözmek için yaklaşımını yaz.
                    Sistem düşünceni analiz edecek ve bir model değişkenine eşleyecek.
                </p>

                {/* Free text input */}
                <div className={`card reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ marginBottom: '1.5rem' }}>
                    <textarea
                        rows={3}
                        placeholder="Belediye kuyruğunu nasıl çözersin? Düşünceni yaz..."
                        value={alreadyMapped ? `"${state.meridyenIntent}" yaklaşımı seçildi.` : freeText}
                        onChange={e => setFreeText(e.target.value)}
                        disabled={alreadyMapped}
                    />
                </div>

                {/* Intent cards */}
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ fontSize: '0.9rem', color: 'var(--text-muted)', marginBottom: '0.75rem' }}>
                    Senin düşüncene en yakın yaklaşımı seç:
                </p>

                <div className={`meridyen-cards reveal ${isVisible ? 'visible' : ''} delay-4`}>
                    {intentTemplates.map((tmpl) => {
                        const isSelected = (alreadyMapped && state.meridyenIntent === tmpl.label) ||
                            (!alreadyMapped && selectedId === tmpl.id);
                        return (
                            <div
                                key={tmpl.id}
                                className={`card meridyen-card ${isSelected ? 'meridyen-card--selected' : ''}`}
                                onClick={() => handleSelect(tmpl.id)}
                                role="button"
                                tabIndex={0}
                                onKeyDown={(e) => { if (e.key === 'Enter') handleSelect(tmpl.id); }}
                            >
                                <div style={{ marginBottom: '0.5rem' }}>
                                    {tmpl.icon === 'bar-chart' && (
                                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                            <line x1="18" y1="20" x2="18" y2="10" /><line x1="12" y1="20" x2="12" y2="4" /><line x1="6" y1="20" x2="6" y2="14" />
                                        </svg>
                                    )}
                                    {tmpl.icon === 'zap' && (
                                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                            <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
                                        </svg>
                                    )}
                                    {tmpl.icon === 'target' && (
                                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-rose)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                            <circle cx="12" cy="12" r="10" /><circle cx="12" cy="12" r="6" /><circle cx="12" cy="12" r="2" />
                                        </svg>
                                    )}
                                </div>
                                <h3 style={{ fontSize: '1rem', marginBottom: '0.35rem', color: isSelected ? 'var(--accent-violet)' : 'var(--text-primary)' }}>
                                    {tmpl.label}
                                </h3>
                                <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>{tmpl.desc}</p>
                            </div>
                        );
                    })}
                </div>

                {/* Confirm */}
                {!alreadyMapped && selectedId && (
                    <div style={{ marginTop: '1.5rem', textAlign: 'center' }}>
                        <button className="btn btn--primary" onClick={handleConfirm}>
                            Bu Yaklaşımı Seç →
                        </button>
                    </div>
                )}

                {/* Mapping visualization */}
                {(showMapping || alreadyMapped) && chosenTemplate && (
                    <div className="mapping-viz">
                        <p style={{ fontSize: '0.85rem', color: 'var(--accent-emerald)', fontWeight: 600, marginBottom: '1rem' }}>
                            ✦ Az önce yazdığın düşünce model kararına dönüştü:
                        </p>
                        {chosenTemplate.variables.map((v, i) => (
                            <div key={i} className="mapping-row" style={{ animationDelay: `${i * 200}ms` }}>
                                <span className="mapping-intent">{chosenTemplate.label}</span>
                                <span className="mapping-arrow">→</span>
                                <span className="mapping-var">{v.variable}</span>
                                <span className="mapping-op">{v.op}</span>
                            </div>
                        ))}
                    </div>
                )}
            </div>
        </section>
    );
}
