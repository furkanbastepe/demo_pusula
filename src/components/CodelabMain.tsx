import { useState, useMemo, useCallback } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

export default function CodelabMain() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);

    const [acikGise, setAcikGise] = useState(3);
    const [islemSuresi, setIslemSuresi] = useState(8);
    const [oncelikliOran, setOncelikliOran] = useState(0.2);
    const [hasInteracted, setHasInteracted] = useState(false);

    const isUnlocked = state.meridyenIntent !== null;

    /* Simulation formulas */
    const sim = useMemo(() => {
        const gelenMusteriSaat = 40;
        const kapasite = (60 / islemSuresi) * acikGise;
        const bekleme = Math.max(0, ((gelenMusteriSaat - kapasite) / kapasite) * islemSuresi + islemSuresi * 0.3);
        const memnuniyet = Math.max(10, Math.min(98, 95 - bekleme * 2.5 + oncelikliOran * 15));
        const islemSayi = Math.min(gelenMusteriSaat, kapasite);
        return {
            bekleme: bekleme.toFixed(1),
            memnuniyet: memnuniyet.toFixed(0),
            islemSayi: Math.round(islemSayi),
            kapasite: Math.round(kapasite),
            kuyruk: Math.max(0, gelenMusteriSaat - kapasite),
        };
    }, [acikGise, islemSuresi, oncelikliOran]);

    /* Defaults for comparison */
    const defaults = useMemo(() => {
        const kap = (60 / 8) * 3;
        const bek = Math.max(0, ((40 - kap) / kap) * 8 + 8 * 0.3);
        const mem = Math.max(10, Math.min(98, 95 - bek * 2.5 + 0.2 * 15));
        return { bekleme: bek.toFixed(1), memnuniyet: mem.toFixed(0) };
    }, []);

    const handleSliderChange = useCallback((setter: (v: number) => void, val: number) => {
        setter(val);
        setHasInteracted(true);
        dispatch({ type: 'SET_CODELAB', values: { acikGise, islemSuresi, oncelikliOran } });
    }, [acikGise, islemSuresi, oncelikliOran, dispatch]);

    /* Queue bars */
    const queueBars = useMemo(() => {
        return Array.from({ length: 24 }, (_, i) => {
            const hour = i;
            const peak = hour >= 9 && hour <= 14 ? 1.6 : hour >= 15 && hour <= 17 ? 1.2 : 0.6;
            const base = 40 * peak;
            const served = Math.min(base, sim.kapasite);
            const waiting = Math.max(0, base - served);
            return { hour, served, waiting, total: base };
        });
    }, [sim.kapasite]);

    const maxQ = Math.max(...queueBars.map(b => b.total), 1);

    return (
        <section className="section" id="codelab-main" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className={`container ${!isUnlocked ? 'gate--locked' : ''}`}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <rect x="2" y="3" width="20" height="14" rx="2" ry="2" /><line x1="8" y1="21" x2="16" y2="21" /><line x1="12" y1="17" x2="12" y2="21" />
                    </svg>
                    Ana Laboratuvar
                </div>
                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Belediye Kuyruğu <span style={{ color: 'var(--accent-cyan)' }}>Simülasyonu</span>
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Slider'ları ayarlayarak müdahaleni yap. KPI'lar anlık güncellenir. Varsayılan değerlerle karşılaştır.
                </p>

                <div className={`codelab-layout reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    {/* Left: Controls */}
                    <div className="codelab-panel">
                        <div className="card">
                            <h3 style={{ fontSize: '1rem', marginBottom: '1.25rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                    <circle cx="12" cy="12" r="3" /><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z" />
                                </svg>
                                Müdahale Parametreleri
                            </h3>
                            <div className="slider-group">
                                <label>Açık Gişe Sayısı <span>{acikGise}</span></label>
                                <input type="range" min="1" max="10" value={acikGise} onChange={e => handleSliderChange(setAcikGise, +e.target.value)} />
                            </div>
                            <div className="slider-group">
                                <label>İşlem Süresi (dk) <span>{islemSuresi}</span></label>
                                <input type="range" min="2" max="15" value={islemSuresi} onChange={e => handleSliderChange(setIslemSuresi, +e.target.value)} />
                            </div>
                            <div className="slider-group">
                                <label>Öncelikli Oran <span>{(oncelikliOran * 100).toFixed(0)}%</span></label>
                                <input type="range" min="0" max="100" value={oncelikliOran * 100} onChange={e => handleSliderChange(setOncelikliOran, +e.target.value / 100)} />
                            </div>
                        </div>

                        {/* Queue Visualization */}
                        <div className="card">
                            <h3 style={{ fontSize: '0.9rem', marginBottom: '1rem', color: 'var(--text-muted)' }}>
                                Saatlik Kuyruk Yoğunluğu
                            </h3>
                            <div className="queue-viz">
                                {queueBars.map((bar, i) => (
                                    <div
                                        key={i}
                                        className="queue-bar"
                                        title={`${bar.hour}:00 — ${Math.round(bar.waiting)} bekleyen`}
                                        style={{
                                            height: `${(bar.total / maxQ) * 100}%`,
                                            background: bar.waiting > 10
                                                ? `linear-gradient(to top, var(--accent-emerald) ${(bar.served / bar.total) * 100}%, var(--accent-rose) ${(bar.served / bar.total) * 100}%)`
                                                : bar.waiting > 0
                                                    ? `linear-gradient(to top, var(--accent-emerald) ${(bar.served / bar.total) * 100}%, var(--accent-amber) ${(bar.served / bar.total) * 100}%)`
                                                    : 'var(--accent-emerald)',
                                            opacity: bar.hour >= 8 && bar.hour <= 18 ? 1 : 0.3,
                                        }}
                                    />
                                ))}
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginTop: '0.5rem', fontSize: '0.7rem', color: 'var(--text-muted)', fontFamily: 'var(--font-mono)' }}>
                                <span>00:00</span><span>06:00</span><span>12:00</span><span>18:00</span><span>23:00</span>
                            </div>
                        </div>
                    </div>

                    {/* Right: KPIs */}
                    <div className="codelab-panel">
                        <div className="grid-2">
                            <div className="kpi-card kpi-card--amber">
                                <div className="kpi-card__value">{sim.bekleme}<span style={{ fontSize: '0.9rem' }}>dk</span></div>
                                <div className="kpi-card__label">Ort. Bekleme</div>
                                {hasInteracted && (
                                    <div style={{ marginTop: '0.5rem', fontSize: '0.75rem', color: +sim.bekleme < +defaults.bekleme ? 'var(--accent-emerald)' : 'var(--accent-rose)' }}>
                                        {+sim.bekleme < +defaults.bekleme ? '↓' : '↑'} Varsayılan: {defaults.bekleme}dk
                                    </div>
                                )}
                            </div>
                            <div className="kpi-card kpi-card--emerald">
                                <div className="kpi-card__value">%{sim.memnuniyet}</div>
                                <div className="kpi-card__label">Memnuniyet</div>
                                {hasInteracted && (
                                    <div style={{ marginTop: '0.5rem', fontSize: '0.75rem', color: +sim.memnuniyet > +defaults.memnuniyet ? 'var(--accent-emerald)' : 'var(--accent-rose)' }}>
                                        {+sim.memnuniyet > +defaults.memnuniyet ? '↑' : '↓'} Varsayılan: %{defaults.memnuniyet}
                                    </div>
                                )}
                            </div>
                            <div className="kpi-card kpi-card--cyan">
                                <div className="kpi-card__value">{sim.islemSayi}</div>
                                <div className="kpi-card__label">İşlem/Saat</div>
                            </div>
                            <div className="kpi-card kpi-card--rose">
                                <div className="kpi-card__value">{Math.round(sim.kuyruk)}</div>
                                <div className="kpi-card__label">Kuyrukta Bekleyen</div>
                            </div>
                        </div>

                        {/* Impact summary */}
                        {hasInteracted && (
                            <div className="card" style={{ marginTop: '1.5rem', borderColor: 'rgba(52, 211, 153, 0.2)' }}>
                                <h3 style={{ fontSize: '1rem', marginBottom: '0.75rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <polyline points="23 6 13.5 15.5 8.5 10.5 1 18" /><polyline points="17 6 23 6 23 12" />
                                    </svg>
                                    Müdahale Etkisi
                                </h3>
                                <p style={{ fontSize: '0.9rem', lineHeight: '1.8' }}>
                                    <strong>{acikGise}</strong> gişe ile <strong>{islemSuresi}dk</strong> işlem süresi belirlediğinde,
                                    saatte <strong>{sim.islemSayi}</strong> vatandaşa hizmet verebiliyorsun. Bekleme süresi{' '}
                                    <span style={{ color: +sim.bekleme < +defaults.bekleme ? 'var(--accent-emerald)' : 'var(--accent-rose)', fontWeight: 700 }}>
                                        {sim.bekleme}dk
                                    </span>.
                                </p>
                            </div>
                        )}

                        {/* Info note */}
                        <div style={{ marginTop: '1rem', padding: '1rem', fontSize: '0.8rem', color: 'var(--text-muted)', borderRadius: '8px', border: '1px solid var(--border-dim)', background: 'var(--bg-void)' }}>
                            <strong style={{ color: 'var(--text-secondary)' }}>Kaynak Seviyesi:</strong> Simülasyon modeli. Gerçek belediye verileri pilot aşamasında entegre edilecektir.
                        </div>
                    </div>
                </div>
            </div>
        </section>
    );
}
