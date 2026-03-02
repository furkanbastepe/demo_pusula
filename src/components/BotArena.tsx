import { useState, useCallback, useMemo } from 'react';
import { usePusula } from '../state/PusulaContext';
import { useInView } from '../hooks/useInView';
import { STRATEGY_TEMPLATES, ACTION_LABELS } from '../engine/BotParser';
import { runFullSimulation, OPPONENT_STRATEGIES, TurnLog, CityState } from '../engine/BotEngine';

type Phase = 'pick' | 'edit' | 'running' | 'result' | 'tournament';
type StrategyKey = keyof typeof STRATEGY_TEMPLATES;

export default function BotArena() {
    const { dispatch } = usePusula();
    const { ref, isVisible } = useInView(0.1);
    const [phase, setPhase] = useState<Phase>('pick');
    const [code, setCode] = useState('');
    const [selectedTemplate, setSelectedTemplate] = useState<StrategyKey | null>(null);
    const [playerResult, setPlayerResult] = useState<CityState | null>(null);
    const [opponentResult, setOpponentResult] = useState<CityState | null>(null);
    const [currentTurn, setCurrentTurn] = useState(0);
    const [showLog, setShowLog] = useState(false);

    const strategyCards = useMemo(() => [
        {
            key: 'efficient' as StrategyKey,
            title: 'Verimli Yönetici',
            desc: 'Yoğun saatlerde gişe aç, sakin saatlerde tasarruf et.',
            color: 'var(--accent-cyan)',
            bgColor: 'var(--accent-cyan-dim)',
            icon: (
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <rect x="3" y="3" width="7" height="7" /><rect x="14" y="3" width="7" height="7" /><rect x="14" y="14" width="7" height="7" /><rect x="3" y="14" width="7" height="7" />
                </svg>
            ),
        },
        {
            key: 'citizen' as StrategyKey,
            title: 'Vatandaş Odaklı',
            desc: 'Her zaman vatandaş memnuniyetini öncelikle.',
            color: 'var(--accent-emerald)',
            bgColor: 'var(--accent-emerald-dim)',
            icon: (
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                </svg>
            ),
        },
        {
            key: 'budget' as StrategyKey,
            title: 'Bütçe Tasarrufçu',
            desc: 'Minimum maliyetle hizmet ver.',
            color: 'var(--accent-amber)',
            bgColor: 'var(--accent-amber-dim)',
            icon: (
                <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <line x1="12" y1="1" x2="12" y2="23" /><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6" />
                </svg>
            ),
        },
    ], []);

    const handlePickStrategy = useCallback((key: StrategyKey) => {
        setSelectedTemplate(key);
        setCode(STRATEGY_TEMPLATES[key]);
        setPhase('edit');
        // Dispatch mentor trigger
        window.dispatchEvent(new CustomEvent('pusula-mentor-trigger', {
            detail: { section: 'bot-arena', trigger: 'strategy_select' },
        }));
    }, []);

    const handleRun = useCallback(() => {
        setPhase('running');
        setCurrentTurn(0);

        // Run both simulations immediately
        const pResult = runFullSimulation(code);
        // Pick a random opponent strategy
        const oppKeys = Object.keys(OPPONENT_STRATEGIES) as (keyof typeof OPPONENT_STRATEGIES)[];
        const oppKey = oppKeys[Math.floor(Math.random() * oppKeys.length)];
        const oResult = runFullSimulation(OPPONENT_STRATEGIES[oppKey]);

        setPlayerResult(pResult);
        setOpponentResult(oResult);

        // Animate turns one by one
        let turn = 0;
        const interval = setInterval(() => {
            turn++;
            setCurrentTurn(turn);
            if (turn >= 16) {
                clearInterval(interval);
                setPhase('result');
                dispatch({ type: 'ADD_YETKINLIK', amount: 20, label: 'Algoritmik Düşünme', beceri: 'Algoritmik Düşünme' });
                dispatch({
                    type: 'UPDATE_RUBRIC',
                    scores: {
                        veriAnalizi: Math.min(100, 15 + Math.round(pResult.finalScore * 0.3)),
                        yaraticiCozum: Math.min(100, 10 + Math.round(pResult.finalScore * 0.25)),
                    },
                });
            }
        }, 350);
    }, [code, dispatch]);

    const handleReset = useCallback(() => {
        setPhase('pick');
        setCode('');
        setSelectedTemplate(null);
        setPlayerResult(null);
        setOpponentResult(null);
        setCurrentTurn(0);
        setShowLog(false);
    }, []);

    const maxKuyruk = useMemo(() => {
        if (!playerResult || !opponentResult) return 30;
        const allLogs = [...playerResult.turnLogs, ...opponentResult.turnLogs];
        return Math.max(30, ...allLogs.map(l => l.kuyruk));
    }, [playerResult, opponentResult]);

    const playerWon = playerResult && opponentResult && playerResult.finalScore > opponentResult.finalScore;

    return (
        <section className="section" id="bot-arena" ref={ref}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" /><polyline points="9 22 9 12 15 12 15 22" />
                    </svg>
                    Şehir Yönetim Botu
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Python ile <span style={{ color: 'var(--accent-cyan)' }}>Belediye</span> Yönet
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '2rem', maxWidth: '600px' }}>
                    Bir belediye hizmet botu yaz. 16 saatlik (06:00-22:00) bir günde vatandaş kuyruğunu
                    en iyi şekilde yönet ve rakip botu yen!
                </p>

                {/* Phase: Pick Strategy */}
                {phase === 'pick' && (
                    <div className={`reveal ${isVisible ? 'visible' : ''} delay-3`}>
                        <p style={{ fontSize: '0.9rem', color: 'var(--text-muted)', marginBottom: '1rem' }}>
                            Bir strateji şablonu seç ve düzenle:
                        </p>
                        <div className="grid-3" style={{ marginBottom: '1.5rem' }}>
                            {strategyCards.map(card => (
                                <div
                                    key={card.key}
                                    className="card"
                                    style={{
                                        cursor: 'pointer',
                                        textAlign: 'center',
                                        transition: 'border-color 0.2s, box-shadow 0.2s',
                                    }}
                                    onClick={() => handlePickStrategy(card.key)}
                                    role="button"
                                    tabIndex={0}
                                    onKeyDown={e => { if (e.key === 'Enter') handlePickStrategy(card.key); }}
                                >
                                    <div style={{
                                        width: '52px', height: '52px', borderRadius: '12px',
                                        background: card.bgColor, display: 'flex', alignItems: 'center',
                                        justifyContent: 'center', margin: '0 auto 0.75rem',
                                    }}>
                                        {card.icon}
                                    </div>
                                    <h3 style={{ fontSize: '1rem', marginBottom: '0.35rem', color: card.color }}>{card.title}</h3>
                                    <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)' }}>{card.desc}</p>
                                </div>
                            ))}
                        </div>
                    </div>
                )}

                {/* Phase: Edit Code */}
                {phase === 'edit' && (
                    <div className={`reveal visible`}>
                        <div className="card" style={{ marginBottom: '1.5rem' }}>
                            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.75rem' }}>
                                <h3 style={{ fontSize: '0.95rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                        <polyline points="16 18 22 12 16 6" /><polyline points="8 6 2 12 8 18" />
                                    </svg>
                                    Strateji Kodunu Düzenle
                                </h3>
                                <span className="badge badge--cyan">{selectedTemplate}</span>
                            </div>
                            <textarea
                                className="code-editor"
                                rows={10}
                                value={code}
                                onChange={e => setCode(e.target.value)}
                                spellCheck={false}
                                style={{
                                    fontFamily: 'var(--font-mono)',
                                    fontSize: '0.85rem',
                                    lineHeight: '1.7',
                                    background: 'var(--bg-void)',
                                    color: 'var(--accent-cyan)',
                                    border: '1px solid var(--border-dim)',
                                    borderRadius: '8px',
                                    padding: '1rem',
                                    width: '100%',
                                    resize: 'vertical',
                                }}
                            />
                            <div style={{ display: 'flex', gap: '0.75rem', marginTop: '1rem', justifyContent: 'flex-end' }}>
                                <button className="btn btn--secondary" onClick={handleReset}>
                                    ← Geri
                                </button>
                                <button className="btn btn--emerald" onClick={handleRun}>
                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                                        <polygon points="5 3 19 12 5 21 5 3" />
                                    </svg>
                                    Simülasyonu Başlat
                                </button>
                            </div>
                        </div>

                        {/* Available commands reference */}
                        <div className="card" style={{ padding: '0.75rem 1rem' }}>
                            <p style={{ fontSize: '0.8rem', color: 'var(--text-muted)', marginBottom: '0.5rem', fontWeight: 600 }}>
                                Kullanılabilir Komutlar:
                            </p>
                            <div style={{ display: 'flex', flexWrap: 'wrap', gap: '0.5rem' }}>
                                {Object.entries(ACTION_LABELS).map(([key, label]) => (
                                    <span key={key} className="badge badge--cyan" style={{ fontSize: '0.7rem' }}>
                                        {key}() → {label}
                                    </span>
                                ))}
                            </div>
                            <p style={{ fontSize: '0.75rem', color: 'var(--text-muted)', marginTop: '0.5rem' }}>
                                Değişkenler: <code>saat</code>, <code>kuyruk</code>, <code>acik_gise</code>, <code>bos_gise</code>, <code>yasli_orani</code>, <code>memnuniyet</code>, <code>butce_kalan</code>
                            </p>
                        </div>
                    </div>
                )}

                {/* Phase: Running / Result — Bar Chart */}
                {(phase === 'running' || phase === 'result') && playerResult && opponentResult && (
                    <div className="reveal visible">
                        {/* Score Cards */}
                        {phase === 'result' && (
                            <div className="grid-2" style={{ marginBottom: '1.5rem' }}>
                                <div className={`card ${playerWon ? '' : ''}`} style={{
                                    textAlign: 'center',
                                    border: playerWon ? '2px solid var(--accent-emerald)' : '1px solid var(--border-dim)',
                                    boxShadow: playerWon ? '0 0 20px var(--accent-emerald-dim)' : 'none',
                                }}>
                                    {playerWon && (
                                        <div className="badge badge--emerald" style={{ marginBottom: '0.5rem' }}>Kazandın!</div>
                                    )}
                                    <div style={{ fontSize: '2rem', fontWeight: 800, fontFamily: 'var(--font-display)', color: 'var(--accent-cyan)' }}>
                                        %{playerResult.finalScore}
                                    </div>
                                    <div style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>Senin Belediye Skoru</div>
                                    <div style={{ display: 'flex', justifyContent: 'center', gap: '1.5rem', marginTop: '0.75rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                        <span>Memnuniyet: %{playerResult.totalMemnuniyet}</span>
                                        <span>İşlem: {playerResult.totalIslem}</span>
                                        <span>Bütçe: {playerResult.budgetRemaining}</span>
                                    </div>
                                </div>
                                <div className="card" style={{ textAlign: 'center' }}>
                                    {!playerWon && (
                                        <div className="badge badge--rose" style={{ marginBottom: '0.5rem' }}>Rakip Kazandı</div>
                                    )}
                                    <div style={{ fontSize: '2rem', fontWeight: 800, fontFamily: 'var(--font-display)', color: 'var(--accent-rose)' }}>
                                        %{opponentResult.finalScore}
                                    </div>
                                    <div style={{ fontSize: '0.85rem', color: 'var(--text-muted)' }}>Rakip Belediye Skoru</div>
                                    <div style={{ display: 'flex', justifyContent: 'center', gap: '1.5rem', marginTop: '0.75rem', fontSize: '0.75rem', color: 'var(--text-muted)' }}>
                                        <span>Memnuniyet: %{opponentResult.totalMemnuniyet}</span>
                                        <span>İşlem: {opponentResult.totalIslem}</span>
                                        <span>Bütçe: {opponentResult.budgetRemaining}</span>
                                    </div>
                                </div>
                            </div>
                        )}

                        {/* Bar Chart — Queue over time */}
                        <div className="card" style={{ marginBottom: '1.5rem' }}>
                            <h3 style={{ fontSize: '0.95rem', marginBottom: '1rem' }}>
                                Saatlik Kuyruk Karşılaştırması
                            </h3>
                            <div style={{ display: 'flex', alignItems: 'flex-end', gap: '3px', height: '180px', padding: '0 0.25rem' }}>
                                {playerResult.turnLogs.slice(0, currentTurn).map((log, i) => {
                                    const oppLog = opponentResult.turnLogs[i];
                                    return (
                                        <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '2px' }}>
                                            <div style={{ display: 'flex', gap: '1px', alignItems: 'flex-end', width: '100%', height: '150px' }}>
                                                {/* Player bar */}
                                                <div style={{
                                                    flex: 1,
                                                    height: `${(log.kuyruk / maxKuyruk) * 140}px`,
                                                    background: 'linear-gradient(to top, var(--accent-cyan), rgba(56,189,248,0.4))',
                                                    borderRadius: '3px 3px 0 0',
                                                    minHeight: '2px',
                                                    transition: 'height 0.3s ease',
                                                }} />
                                                {/* Opponent bar */}
                                                <div style={{
                                                    flex: 1,
                                                    height: `${(oppLog.kuyruk / maxKuyruk) * 140}px`,
                                                    background: 'linear-gradient(to top, var(--accent-rose), rgba(251,113,133,0.4))',
                                                    borderRadius: '3px 3px 0 0',
                                                    minHeight: '2px',
                                                    transition: 'height 0.3s ease',
                                                }} />
                                            </div>
                                            <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.6rem', color: 'var(--text-muted)' }}>
                                                {String(log.saat).padStart(2, '0')}
                                            </span>
                                        </div>
                                    );
                                })}
                            </div>
                            <div style={{ display: 'flex', justifyContent: 'center', gap: '1.5rem', marginTop: '0.75rem', paddingTop: '0.5rem', borderTop: '1px solid var(--border-dim)' }}>
                                <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                                    <span style={{ width: '12px', height: '8px', borderRadius: '2px', background: 'var(--accent-cyan)' }} />
                                    Senin Bot
                                </span>
                                <span style={{ fontSize: '0.75rem', color: 'var(--text-muted)', display: 'flex', alignItems: 'center', gap: '0.35rem' }}>
                                    <span style={{ width: '12px', height: '8px', borderRadius: '2px', background: 'var(--accent-rose)' }} />
                                    Rakip Bot
                                </span>
                            </div>
                        </div>

                        {/* Game Log Toggle */}
                        {phase === 'result' && (
                            <>
                                <button
                                    className="btn btn--secondary"
                                    onClick={() => setShowLog(!showLog)}
                                    style={{ marginBottom: '1rem', width: '100%' }}
                                >
                                    {showLog ? 'Logu Gizle ↑' : 'Detaylı Logu Göster ↓'}
                                </button>

                                {showLog && (
                                    <div className="card" style={{ maxHeight: '300px', overflowY: 'auto', marginBottom: '1.5rem' }}>
                                        <table style={{ width: '100%', fontSize: '0.75rem', fontFamily: 'var(--font-mono)', borderCollapse: 'collapse' }}>
                                            <thead>
                                                <tr style={{ borderBottom: '1px solid var(--border-dim)' }}>
                                                    <th style={{ padding: '0.5rem 0.25rem', textAlign: 'left', color: 'var(--text-muted)' }}>Saat</th>
                                                    <th style={{ padding: '0.5rem 0.25rem', textAlign: 'left', color: 'var(--accent-cyan)' }}>Senin Aksiyon</th>
                                                    <th style={{ padding: '0.5rem 0.25rem', textAlign: 'right', color: 'var(--accent-cyan)' }}>Kuyruk</th>
                                                    <th style={{ padding: '0.5rem 0.25rem', textAlign: 'right', color: 'var(--accent-rose)' }}>Rakip K.</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {playerResult.turnLogs.map((log, i) => {
                                                    const oppLog = opponentResult.turnLogs[i];
                                                    return (
                                                        <tr key={i} style={{ borderBottom: '1px solid rgba(255,255,255,0.03)' }}>
                                                            <td style={{ padding: '0.35rem 0.25rem', color: 'var(--text-muted)' }}>
                                                                {String(log.saat).padStart(2, '0')}:00
                                                            </td>
                                                            <td style={{ padding: '0.35rem 0.25rem', color: 'var(--accent-cyan)' }}>
                                                                {ACTION_LABELS[log.action]}{log.param ? `(${log.param})` : ''}
                                                            </td>
                                                            <td style={{ padding: '0.35rem 0.25rem', textAlign: 'right', color: log.kuyruk > 20 ? 'var(--accent-rose)' : 'var(--accent-emerald)' }}>
                                                                {log.kuyruk}
                                                            </td>
                                                            <td style={{ padding: '0.35rem 0.25rem', textAlign: 'right', color: oppLog.kuyruk > 20 ? 'var(--accent-rose)' : 'var(--text-muted)' }}>
                                                                {oppLog.kuyruk}
                                                            </td>
                                                        </tr>
                                                    );
                                                })}
                                            </tbody>
                                        </table>
                                    </div>
                                )}

                                {/* Learning summary */}
                                <div className="card" style={{ border: '1px solid var(--accent-emerald-dim)', background: 'rgba(52,211,153,0.04)' }}>
                                    <h3 style={{ fontSize: '0.9rem', marginBottom: '0.5rem', color: 'var(--accent-emerald)', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" /><polyline points="22 4 12 14.01 9 11.01" />
                                        </svg>
                                        Ne Öğrendin?
                                    </h3>
                                    <p style={{ fontSize: '0.85rem', color: 'var(--text-secondary)', lineHeight: '1.7' }}>
                                        Koşullu ifadeler (<code style={{ color: 'var(--accent-cyan)', fontFamily: 'var(--font-mono)', fontSize: '0.8rem' }}>if/elif/else</code>) ile
                                        veri analizi ve karar verme becerilerini deneyimledin.
                                        Belediye kuyruğu gibi gerçek bir problemi kod yazarak çözdün!
                                    </p>
                                    <div style={{ display: 'flex', gap: '1rem', marginTop: '0.75rem' }}>
                                        <button className="btn btn--secondary" onClick={handleReset} style={{ fontSize: '0.85rem' }}>
                                            Tekrar Dene
                                        </button>
                                        <button className="btn btn--primary" onClick={() => setPhase('tournament')} style={{ fontSize: '0.85rem' }}>
                                            🏆 Turnuva Tablosu
                                        </button>
                                    </div>
                                </div>
                            </>
                        )}
                    </div>
                )}

                {/* Phase: Tournament */}
                {phase === 'tournament' && (
                    <TournamentBracket
                        playerScore={playerResult?.finalScore ?? 0}
                        onBack={handleReset}
                    />
                )}
            </div>
        </section>
    );
}

/* ── Tournament Bracket Sub-component ── */
const SIMULATED_PLAYERS = [
    { name: 'Elif K.', score: 82 },
    { name: 'Ahmet D.', score: 76 },
    { name: 'Zeynep B.', score: 89 },
    { name: 'Mert Y.', score: 71 },
    { name: 'Ayşe T.', score: 85 },
    { name: 'Can Ö.', score: 68 },
    { name: 'Deniz A.', score: 91 },
];

function TournamentBracket({ playerScore, onBack }: { playerScore: number; onBack: () => void }) {
    const allPlayers = useMemo(() => {
        const players = [
            { name: 'Sen', score: playerScore, isPlayer: true },
            ...SIMULATED_PLAYERS.map(p => ({ ...p, isPlayer: false })),
        ].sort((a, b) => b.score - a.score);
        return players;
    }, [playerScore]);

    const playerRank = allPlayers.findIndex(p => p.isPlayer) + 1;

    return (
        <div className="reveal visible" style={{ animation: 'fadeSlideUp 0.5s ease' }}>
            {/* Ranking header */}
            <div className="card" style={{
                textAlign: 'center', marginBottom: '1.5rem',
                border: playerRank <= 3 ? '2px solid var(--accent-amber)' : '1px solid var(--border-dim)',
                boxShadow: playerRank <= 3 ? '0 0 30px rgba(251,191,36,0.1)' : 'none',
            }}>
                <div style={{ fontSize: '2.5rem', marginBottom: '0.25rem' }}>
                    {playerRank === 1 ? '🥇' : playerRank === 2 ? '🥈' : playerRank === 3 ? '🥉' : '🏅'}
                </div>
                <div style={{ fontSize: '1.3rem', fontWeight: 800, fontFamily: 'var(--font-display)', color: 'var(--text-primary)' }}>
                    {playerRank}. Sıra
                </div>
                <div style={{ fontSize: '0.85rem', color: 'var(--text-muted)', marginTop: '0.25rem' }}>
                    Eskişehir Merkez Turnuvası — 8 Yarışmacı
                </div>
            </div>

            {/* Leaderboard */}
            <div className="card" style={{ marginBottom: '1.5rem' }}>
                <h3 style={{ fontSize: '0.95rem', marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.5rem' }}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6" /><path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18" /><path d="M4 22h16" /><path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20.24 7 22" /><path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20.24 17 22" /><path d="M18 2H6v7a6 6 0 0 0 12 0V2Z" />
                    </svg>
                    Liderlik Tablosu
                </h3>
                <div style={{ display: 'flex', flexDirection: 'column', gap: '0.35rem' }}>
                    {allPlayers.map((p, i) => (
                        <div key={p.name} style={{
                            display: 'flex', alignItems: 'center', gap: '0.75rem',
                            padding: '0.55rem 0.75rem',
                            background: p.isPlayer ? 'rgba(56,189,248,0.08)' : 'var(--bg-void)',
                            border: p.isPlayer ? '1px solid rgba(56,189,248,0.3)' : '1px solid transparent',
                            borderRadius: '8px',
                            transition: 'all 0.2s',
                        }}>
                            <span style={{
                                width: '22px', height: '22px', borderRadius: '50%',
                                display: 'flex', alignItems: 'center', justifyContent: 'center',
                                fontSize: i < 3 ? '0.85rem' : '0.7rem',
                                fontWeight: 800, fontFamily: 'var(--font-mono)',
                                background: i === 0 ? 'rgba(251,191,36,0.15)' : i === 1 ? 'rgba(148,163,184,0.15)' : i === 2 ? 'rgba(205,127,50,0.15)' : 'rgba(255,255,255,0.03)',
                                color: i === 0 ? 'var(--accent-amber)' : i === 1 ? 'var(--text-secondary)' : i === 2 ? '#CD7F32' : 'var(--text-muted)',
                            }}>
                                {i < 3 ? ['🥇', '🥈', '🥉'][i] : i + 1}
                            </span>
                            <span style={{
                                flex: 1, fontSize: '0.85rem',
                                fontWeight: p.isPlayer ? 700 : 400,
                                color: p.isPlayer ? 'var(--accent-cyan)' : 'var(--text-secondary)',
                            }}>
                                {p.name}
                                {p.isPlayer && <span style={{ fontSize: '0.7rem', color: 'var(--accent-cyan)', marginLeft: '0.3rem' }}>★</span>}
                            </span>
                            <div style={{ width: '60px', height: '6px', background: 'rgba(255,255,255,0.05)', borderRadius: '3px', overflow: 'hidden' }}>
                                <div style={{
                                    width: `${p.score}%`, height: '100%',
                                    background: p.isPlayer
                                        ? 'linear-gradient(90deg, var(--accent-cyan), var(--accent-emerald))'
                                        : 'linear-gradient(90deg, var(--text-muted), rgba(148,163,184,0.3))',
                                    borderRadius: '3px',
                                }} />
                            </div>
                            <span style={{
                                fontFamily: 'var(--font-mono)', fontSize: '0.8rem', fontWeight: 700,
                                color: p.isPlayer ? 'var(--accent-cyan)' : 'var(--text-muted)',
                                minWidth: '35px', textAlign: 'right',
                            }}>
                                %{p.score}
                            </span>
                        </div>
                    ))}
                </div>
            </div>

            {/* Actions */}
            <div style={{ display: 'flex', gap: '1rem', justifyContent: 'center' }}>
                <button className="btn btn--secondary" onClick={onBack}>
                    ← Yeniden Yarış
                </button>
            </div>
        </div>
    );
}
