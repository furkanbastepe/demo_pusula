import { useState, useMemo, useCallback } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

const cases = [
    {
        id: 'katilimci',
        title: 'Katılımcı Bütçe Yönetimi',
        desc: 'Mahalle meclisi bütçesini 500 vatandaşın oyuyla dağıt.',
        sliders: [
            { label: 'Toplantı sıklığı (hafta)', key: 'toplanti', min: 1, max: 4, default: 2 },
            { label: 'Dijital oy oranı (%)', key: 'dijital', min: 10, max: 100, default: 30 },
            { label: 'Mentor desteği', key: 'mentor', min: 0, max: 5, default: 1 },
        ],
        kpi: (vals: Record<string, number>) => {
            const katilim = Math.min(95, 30 + vals.dijital * 0.4 + vals.toplanti * 8 + vals.mentor * 5);
            return { value: katilim.toFixed(0), label: 'Katılım Oranı (%)' };
        },
    },
    {
        id: 'esnaf',
        title: 'Esnaf Dijitalleşme Desteği',
        desc: 'Yerel esnafa e-ticaret ve dijital pazarlama eğitimi ver.',
        sliders: [
            { label: 'Eğitim süresi (hafta)', key: 'egitim', min: 1, max: 8, default: 2 },
            { label: 'Pratik proje sayısı', key: 'proje', min: 1, max: 5, default: 1 },
            { label: 'Takip mentorluğu (ay)', key: 'takip', min: 0, max: 6, default: 0 },
        ],
        kpi: (vals: Record<string, number>) => {
            const basari = Math.min(98, 20 + vals.egitim * 6 + vals.proje * 12 + vals.takip * 8);
            return { value: basari.toFixed(0), label: 'Dijitalleşme Skoru' };
        },
    },
];

export default function TransferCases() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);
    const [vals, setVals] = useState<Record<string, Record<string, number>>>(() => {
        const init: Record<string, Record<string, number>> = {};
        cases.forEach(c => {
            init[c.id] = {};
            c.sliders.forEach(s => { init[c.id][s.key] = s.default; });
        });
        return init;
    });
    const [submitted, setSubmitted] = useState(false);

    const isUnlocked = state.stage === 'transfer_done' || state.stage === 'decision_ready' ||
        state.stage === 'feynman_pending' || state.whyText !== '' && state.feynmanText !== '';

    const scores = useMemo(() => {
        return cases.map(c => {
            const kpi = c.kpi(vals[c.id]);
            return +kpi.value;
        });
    }, [vals]);

    const handleSubmit = useCallback(() => {
        dispatch({ type: 'COMPLETE_TRANSFER', scores });
        setSubmitted(true);
    }, [dispatch, scores]);

    return (
        <section className="section" id="transfer-cases" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className={`container ${!isUnlocked ? 'gate--locked' : ''}`}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <polyline points="17 1 21 5 17 9" /><path d="M3 11V9a4 4 0 0 1 4-4h14" /><polyline points="7 23 3 19 7 15" /><path d="M21 13v2a4 4 0 0 1-4 4H3" />
                    </svg>
                    Transfer Vakaları
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Öğrendiklerini <span style={{ color: 'var(--accent-amber)' }}>Transfer</span> Et
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Belediye kuyruğunda öğrendiğin problem çözme yaklaşımını iki yeni vakaya uygula.
                </p>

                <div className={`grid-2 reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    {cases.map((c) => {
                        const kpi = c.kpi(vals[c.id]);
                        return (
                            <div key={c.id} className="card">
                                <div className="badge badge--amber" style={{ marginBottom: '1rem' }}>{c.id === 'katilimci' ? 'Vaka 1' : 'Vaka 2'}</div>
                                <h3 style={{ fontSize: '1.05rem', marginBottom: '0.35rem' }}>{c.title}</h3>
                                <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1.25rem' }}>{c.desc}</p>

                                {c.sliders.map(s => (
                                    <div key={s.key} className="slider-group">
                                        <label>{s.label} <span>{vals[c.id][s.key]}</span></label>
                                        <input
                                            type="range"
                                            min={s.min}
                                            max={s.max}
                                            value={vals[c.id][s.key]}
                                            onChange={e => setVals(prev => ({
                                                ...prev,
                                                [c.id]: { ...prev[c.id], [s.key]: +e.target.value },
                                            }))}
                                            disabled={submitted}
                                        />
                                    </div>
                                ))}

                                <div className="kpi-card kpi-card--cyan" style={{ marginTop: '1rem' }}>
                                    <div className="kpi-card__value">%{kpi.value}</div>
                                    <div className="kpi-card__label">{kpi.label}</div>
                                </div>
                            </div>
                        );
                    })}
                </div>

                {!submitted && isUnlocked && (
                    <div style={{ textAlign: 'center', marginTop: '2rem' }}>
                        <button className="btn btn--emerald" onClick={handleSubmit}>
                            Transfer Vakalarını Tamamla ✓
                        </button>
                    </div>
                )}

                {submitted && (
                    <p className="reveal visible" style={{ marginTop: '1.5rem', textAlign: 'center', color: 'var(--accent-emerald)', fontWeight: 600 }}>
                        Transfer başarılı! Şimdi değerlendirme radarını incele. ↓
                    </p>
                )}
            </div>
        </section>
    );
}
