import { useState, useCallback, useEffect } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';
import { Database, Users, AlertTriangle, Sparkles, CheckCircle2 } from 'lucide-react';

const STRATEGIES = [
    {
        id: 'data',
        icon: <Database size={20} />,
        title: 'Veri Analitiği',
        desc: 'Tahmine dayalı algoritma kullanımı',
        aiSynthesis: 'Şehirdeki trafik ve altyapı verilerini yapay zeka ile analiz ederek, krizler oluşmadan önce tahmine dayalı proaktif modellemeler geliştirebiliriz. Böylece kaynak yönetimi reaktif değil, önleyici hale gelir.'
    },
    {
        id: 'social',
        icon: <Users size={20} />,
        title: 'Katılımcı Ağ',
        desc: 'Vatandaş destekli geri bildirim',
        aiSynthesis: 'Vatandaşların mobil cihazları üzerinden anlık altyapı bildirimi yapabileceği kitle kaynaklı (crowdsourced) bir şeffaflık ağı kurarak, belediyenin kör noktalarını gerçek zamanlı aydınlatabiliriz.'
    },
    {
        id: 'crisis',
        icon: <AlertTriangle size={20} />,
        title: 'Kriz İletişimi',
        desc: 'Acil durum optimizasyonu',
        aiSynthesis: 'Afet ve acil durum anlarında resmi kurumların ve gönüllü ağlarının eşzamanlı çalışabileceği, kesintisiz ve merkeziyetsiz bir dijital iletişim protokolü devreye sokulmalıdır.'
    }
];

export default function KivilcimGate() {
    const { state, dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.15);
    const [selectedStrategy, setSelectedStrategy] = useState<string | null>(null);
    const [isSynthesizing, setIsSynthesizing] = useState(false);
    const [displayedText, setDisplayedText] = useState('');
    const [isComplete, setIsComplete] = useState(false);

    const alreadyCompleted = state.stage !== 'intro';

    const handleSelectStrategy = useCallback((strategyId: string, synthesisText: string) => {
        if (alreadyCompleted || isSynthesizing) return;

        setSelectedStrategy(strategyId);
        setIsSynthesizing(true);
        setDisplayedText('');

        // Typewriter effect simulation
        let i = 0;
        const typingSpeed = 30; // ms per character

        const typeChar = () => {
            if (i < synthesisText.length) {
                setDisplayedText(synthesisText.substring(0, i + 1));
                i++;
                setTimeout(typeChar, typingSpeed);
            } else {
                setIsSynthesizing(false);
                setIsComplete(true);
                // Dispatch completion events
                dispatch({ type: 'SET_KIVILCIM', text: synthesisText });
                dispatch({ type: 'COMPLETE_KIVILCIM' });
                dispatch({ type: 'ADD_YETKINLIK', amount: 10, label: 'Problem Sentezi', beceri: 'Problem Tanımlama' });
            }
        };

        // Start typing after a short perceived "thinking" delay
        setTimeout(typeChar, 600);
    }, [alreadyCompleted, isSynthesizing, dispatch]);

    // If already completed in previous state, show the complete UI instantly
    useEffect(() => {
        if (alreadyCompleted && state.kivilcimText) {
            setIsComplete(true);
            setDisplayedText(state.kivilcimText);
            setSelectedStrategy('social'); // default visual fallback
        }
    }, [alreadyCompleted, state.kivilcimText]);

    return (
        <section className="section" id="kivilcim-gate" ref={ref}>
            <div className="container container--narrow">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <Sparkles size={16} /> {/* Replaced star polygon with Sparkles */}
                    Kıvılcım: Yapay Zeka Sentezi
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.75rem' }}>
                    Stratejini <span style={{ color: 'var(--accent-amber)' }}>Seç</span>, AI Sentezlesin
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '560px' }}>
                    Sıradan sistemler sizden satır satır metin yazmanızı bekler. PUSULA'da stratejik kararı siz verirsiniz, AI Mentorünüz bu kararı profesyonel bir problem tanımına dönüştürür.
                </p>

                <div className={`gate ${isComplete || alreadyCompleted ? 'gate--unlocked' : ''} reveal ${isVisible ? 'visible' : ''} delay-3`}>
                    <div className={`gate__status ${isComplete || alreadyCompleted ? 'gate__status--unlocked' : 'gate__status--locked'}`}>
                        {isComplete || alreadyCompleted ? '✓ Kilit Açıldı' : 'Bekleniyor'}
                    </div>

                    <h3 style={{ marginBottom: '1.25rem', fontSize: '1.1rem', color: 'var(--text-primary)' }}>
                        <strong style={{ color: 'var(--accent-amber)' }}>Vaka:</strong> İstanbul'daki bir belediye vatandaş hizmetlerini nasıl iyileştirebilir? Yöntem seçin:
                    </h3>

                    {/* STRATEGY CARDS */}
                    {!isSynthesizing && !isComplete && (
                        <div className="strategy-grid fade-in">
                            {STRATEGIES.map((strategy) => (
                                <button
                                    key={strategy.id}
                                    className={`strategy-card ${selectedStrategy === strategy.id ? 'selected' : ''}`}
                                    onClick={() => handleSelectStrategy(strategy.id, strategy.aiSynthesis)}
                                    disabled={alreadyCompleted}
                                >
                                    <div className="strategy-icon">{strategy.icon}</div>
                                    <span className="strategy-title">{strategy.title}</span>
                                    <span className="strategy-desc">{strategy.desc}</span>
                                </button>
                            ))}
                        </div>
                    )}

                    {/* AI SYNTHESIS TYPEWRITER */}
                    {(isSynthesizing || isComplete) && (
                        <div className="synthesis-box fade-in">
                            <div className="synthesis-header">
                                <Sparkles size={16} className={isSynthesizing ? 'spinning' : ''} />
                                <span>PUSULA AI Mentor Sentezliyor...</span>
                            </div>
                            <div className="synthesis-content">
                                {displayedText}
                                {isSynthesizing && <span className="typewriter-cursor">|</span>}
                            </div>
                            {isComplete && (
                                <div className="synthesis-success fade-in">
                                    <CheckCircle2 size={16} /> Akademik Problem Tanımı Doğrulandı
                                </div>
                            )}
                        </div>
                    )}
                </div>

                {(isComplete || alreadyCompleted) && (
                    <p className="reveal visible" style={{ marginTop: '1.5rem', textAlign: 'center', color: 'var(--accent-emerald)', fontWeight: 600, fontSize: '0.95rem' }}>
                        Mükemmel strateji! Kapı açıldı. Şimdi ısınma laboratuvarına geçelim. ↓
                    </p>
                )}
            </div>
        </section>
    );
}
