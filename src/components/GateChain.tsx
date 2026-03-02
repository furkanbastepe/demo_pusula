import { useState, useCallback } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

function countSentences(text: string): number {
    const matches = text.match(/[^.!?]*[.!?]+/g);
    return matches ? matches.length : 0;
}

export default function GateChain() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);

    const [whyText, setWhyText] = useState('');
    const [feynmanText, setFeynmanText] = useState('');
    const [whySubmitted, setWhySubmitted] = useState(false);
    const [feynmanSubmitted, setFeynmanSubmitted] = useState(false);

    const isUnlocked = state.stage === 'main_intervention' || state.stage === 'why_pending' || state.stage === 'feynman_pending' || state.stage === 'transfer_done' || state.stage === 'decision_ready';
    const whyValid = countSentences(whyText) >= 1;
    const feynmanValid = countSentences(feynmanText) >= 1;

    const handleWhySubmit = useCallback(() => {
        if (!whyValid) return;
        dispatch({ type: 'SET_WHY', text: whyText });
        setWhySubmitted(true);
    }, [whyValid, whyText, dispatch]);

    const handleFeynmanSubmit = useCallback(() => {
        if (!feynmanValid) return;
        dispatch({ type: 'SET_FEYNMAN', text: feynmanText });
        setFeynmanSubmitted(true);
        dispatch({ type: 'COMPLETE_GATES' });
    }, [feynmanValid, feynmanText, dispatch]);

    const allDone = state.stage === 'transfer_done' || state.stage === 'decision_ready' || (whySubmitted && feynmanSubmitted);

    return (
        <section className="section" id="gate-chain" ref={ref}>
            <div className={`container container--narrow ${!isUnlocked ? 'gate--locked' : ''}`}>
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" /><polyline points="16 17 21 12 16 7" /><line x1="21" y1="12" x2="9" y2="12" />
                    </svg>
                    Kalite Kapıları
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    <span style={{ color: 'var(--accent-amber)' }}>Neden</span> ve <span style={{ color: 'var(--accent-violet)' }}>Feynman</span> Kapısı
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem' }}>
                    Çözümünü derinleştirmek için iki kritik düşünme kapısını geç.
                </p>

                {/* WHY Gate */}
                <div className={`gate ${whySubmitted || state.whyText ? 'gate--unlocked' : ''} reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ marginBottom: '2rem' }}>
                    <div className={`gate__status ${whySubmitted || state.whyText ? 'gate__status--unlocked' : 'gate__status--locked'}`}>
                        {whySubmitted || state.whyText ? '✓ Geçildi' : 'Kapı 1'}
                    </div>

                    <h3 style={{ fontSize: '1.05rem', marginBottom: '0.75rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <circle cx="12" cy="12" r="10" /><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3" /><line x1="12" y1="17" x2="12.01" y2="17" />
                        </svg>
                        Neden bu değerleri seçtin?
                    </h3>
                    <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
                        Müdahale kararlarının arkasındaki mantığı açıkla.
                    </p>

                    <textarea
                        rows={3}
                        placeholder="Neden bu gişe sayısını ve işlem süresini seçtin? Mantığını açıkla..."
                        value={state.whyText || whyText}
                        onChange={e => setWhyText(e.target.value)}
                        disabled={whySubmitted || !!state.whyText}
                    />

                    {!whySubmitted && !state.whyText && (
                        <div style={{ marginTop: '1rem', textAlign: 'right' }}>
                            <button className="btn btn--secondary" onClick={handleWhySubmit} disabled={!whyValid}>
                                Onayla
                            </button>
                        </div>
                    )}
                </div>

                {/* FEYNMAN Gate */}
                <div className={`gate ${feynmanSubmitted || state.feynmanText ? 'gate--unlocked' : whySubmitted || state.whyText ? '' : 'gate--locked'} reveal ${isVisible ? 'visible' : ''} delay-4`}>
                    <div className={`gate__status ${feynmanSubmitted || state.feynmanText ? 'gate__status--unlocked' : 'gate__status--locked'}`}>
                        {feynmanSubmitted || state.feynmanText ? '✓ Geçildi' : 'Kapı 2'}
                    </div>

                    <h3 style={{ fontSize: '1.05rem', marginBottom: '0.75rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--accent-violet)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" /><path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
                        </svg>
                        Feynman Testi: 10 yaşındaki birine anlat
                    </h3>
                    <p style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
                        Çözümünü basit bir dille, bir çocuğun anlayacağı şekilde açıkla.
                    </p>

                    <textarea
                        rows={3}
                        placeholder="Belediyedeki kuyruk neden uzun ve sen bunu nasıl çözdün? Basitçe anlat..."
                        value={state.feynmanText || feynmanText}
                        onChange={e => setFeynmanText(e.target.value)}
                        disabled={feynmanSubmitted || !!state.feynmanText || (!whySubmitted && !state.whyText)}
                    />

                    {!feynmanSubmitted && !state.feynmanText && (whySubmitted || !!state.whyText) && (
                        <div style={{ marginTop: '1rem', textAlign: 'right' }}>
                            <button className="btn btn--secondary" onClick={handleFeynmanSubmit} disabled={!feynmanValid}>
                                Onayla
                            </button>
                        </div>
                    )}
                </div>

                {allDone && (
                    <p className="reveal visible" style={{ marginTop: '1.5rem', textAlign: 'center', color: 'var(--accent-emerald)', fontWeight: 600 }}>
                        Her iki kapıyı da geçtin! Şimdi öğrendiklerini yeni vakalara transfer et. ↓
                    </p>
                )}
            </div>
        </section>
    );
}
