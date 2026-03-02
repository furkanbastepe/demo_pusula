import { useState, useCallback } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';

function countSentences(text: string): number {
    const matches = text.match(/[^.!?]*[.!?]+/g);
    return matches ? matches.length : 0;
}

export default function KivilcimGate() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);
    const [text, setText] = useState('');
    const sentences = countSentences(text);
    const isComplete = sentences >= 2;
    const isLocked = state.stage === 'intro' && !isComplete;

    const handleSubmit = useCallback(() => {
        if (!isComplete) return;
        dispatch({ type: 'SET_KIVILCIM', text });
        dispatch({ type: 'COMPLETE_KIVILCIM' });
        dispatch({ type: 'ADD_YETKINLIK', amount: 10, label: 'Problem Tanımlama', beceri: 'Problem Tanımlama' });
    }, [isComplete, text, dispatch]);

    const alreadyCompleted = state.stage !== 'intro';

    return (
        <section className="section" id="kivilcim-gate" ref={ref}>
            <div className="container container--narrow">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2" />
                    </svg>
                    Kıvılcım Kapısı
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.75rem' }}>
                    Önce <span style={{ color: 'var(--accent-amber)' }}>Düşün</span>, Sonra Çöz
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '560px' }}>
                    PUSULA'da her öğrenme yolculuğu bir kıvılcımla başlar. Kod yazmadan önce
                    problemi kendi cümlelerinle ifade et.
                </p>

                <div className={`gate ${alreadyCompleted ? 'gate--unlocked' : ''} reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    <div className={`gate__status ${alreadyCompleted ? 'gate__status--unlocked' : 'gate__status--locked'}`}>
                        {alreadyCompleted ? '✓ Kapı Açık' : 'Kilitli'}
                    </div>

                    <h3 style={{ marginBottom: '0.75rem', fontSize: '1.1rem' }}>
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ display: 'inline', verticalAlign: 'text-bottom', marginRight: '0.5rem' }}>
                            <circle cx="12" cy="12" r="10" /><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3" /><line x1="12" y1="17" x2="12.01" y2="17" />
                        </svg>
                        İstanbul'daki bir belediye vatandaş hizmetlerini nasıl iyileştirebilir?
                    </h3>

                    <textarea
                        rows={4}
                        placeholder="Düşüncelerini en az 2 cümle ile yaz..."
                        value={alreadyCompleted ? state.kivilcimText : text}
                        onChange={(e) => setText(e.target.value)}
                        disabled={alreadyCompleted}
                        style={{
                            marginBottom: '0.5rem',
                            borderColor: isComplete ? 'var(--accent-emerald)' : undefined,
                            boxShadow: isComplete ? '0 0 0 3px var(--accent-emerald-dim)' : undefined,
                        }}
                    />

                    {/* Sentence counter */}
                    <div className="sentence-counter">
                        <div className="sentence-counter__bar">
                            <div
                                className="sentence-counter__fill"
                                style={{ width: `${Math.min((sentences / 2) * 100, 100)}%` }}
                            />
                        </div>
                        <span className={`sentence-counter__text ${isComplete ? 'complete' : ''}`}>
                            {sentences}/2 cümle
                        </span>
                    </div>

                    {!alreadyCompleted && (
                        <div style={{ marginTop: '1.25rem', textAlign: 'right' }}>
                            <button
                                className="btn btn--emerald"
                                onClick={handleSubmit}
                                disabled={!isComplete}
                            >
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2" /><path d="M7 11V7a5 5 0 0 1 10 0v4" />
                                </svg>
                                Kapıyı Aç
                            </button>
                        </div>
                    )}
                </div>

                {alreadyCompleted && (
                    <p className="reveal visible" style={{ marginTop: '1.5rem', textAlign: 'center', color: 'var(--accent-emerald)', fontWeight: 600, fontSize: '0.95rem' }}>
                        Harika! Düşüncen kaydedildi. Şimdi ısınma laboratuvarına geçelim. ↓
                    </p>
                )}
            </div>
        </section>
    );
}
