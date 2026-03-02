import { useState, useMemo } from 'react';
import { useInView } from '../hooks/useInView';
import { usePusula } from '../state/PusulaContext';

interface Question {
    id: number;
    chart: { labels: string[]; values: number[]; color: string; title: string };
    question: string;
    options: string[];
    correct: number;
    explanation: string;
}

const QUESTIONS: Question[] = [
    {
        id: 1,
        chart: {
            labels: ['08:00', '10:00', '12:00', '14:00', '16:00', '18:00'],
            values: [12, 28, 35, 42, 38, 15],
            color: 'var(--accent-cyan)',
            title: 'Saatlik Kuyruk Yoğunluğu',
        },
        question: 'Bu grafiğe göre en yoğun saat dilimi hangisi?',
        options: ['08:00 – 10:00', '12:00 – 14:00', '14:00 – 16:00', '16:00 – 18:00'],
        correct: 2,
        explanation: '14:00 diliminde 42 vatandaş ile en yüksek kuyruk yoğunluğu gözlemleniyor. Bu dönemde ek gişe açmak kritik.',
    },
    {
        id: 2,
        chart: {
            labels: ['2 gişe', '3 gişe', '4 gişe', '5 gişe', '6 gişe'],
            values: [25, 18, 12, 8, 7],
            color: 'var(--accent-emerald)',
            title: 'Gişe Sayısı vs Ortalama Bekleme (dk)',
        },
        question: 'Gişe sayısı arttıkça bekleme süresi nasıl değişiyor?',
        options: ['Doğrusal azalıyor', 'Azalan oranda düşüyor', 'Sabit kalıyor', 'Artıyor'],
        correct: 1,
        explanation: '2→3 gişeye geçişte 7dk düşüş, 5→6 gişeye geçişte sadece 1dk düşüş var. Bu azalan getiri yasasıdır (diminishing returns).',
    },
    {
        id: 3,
        chart: {
            labels: ['Pzt', 'Sal', 'Çar', 'Per', 'Cum'],
            values: [85, 78, 91, 65, 88],
            color: 'var(--accent-violet)',
            title: 'Günlük Memnuniyet Skoru (%)',
        },
        question: 'Perşembe günü memnuniyet neden düştü?',
        options: [
            'Personel eksikliği',
            'Sistem arızası nedeniyle dijital hizmet kesintisi',
            'Hava koşulları',
            'Tatil dönüşü yoğunluk',
        ],
        correct: 1,
        explanation: 'Çarşamba günü %91 olan memnuniyet Perşembe %65\'e düştü. Ani düşüş genellikle sistem arızası gibi operasyonel bir sorunun işaretçisidir.',
    },
];

/* Mini bar chart */
function MiniChart({ chart, visible }: { chart: Question['chart']; visible: boolean }) {
    const maxVal = Math.max(...chart.values);

    return (
        <div style={{ marginBottom: '1rem' }}>
            <div style={{ fontSize: '0.75rem', fontFamily: 'var(--font-mono)', color: chart.color, marginBottom: '0.75rem' }}>
                📊 {chart.title}
            </div>
            <div style={{ display: 'flex', alignItems: 'flex-end', gap: '6px', height: '100px', padding: '0 0.5rem' }}>
                {chart.values.map((v, i) => (
                    <div key={i} style={{ flex: 1, display: 'flex', flexDirection: 'column', alignItems: 'center', gap: '4px' }}>
                        <span style={{ fontSize: '0.65rem', fontFamily: 'var(--font-mono)', color: 'var(--text-muted)' }}>{v}</span>
                        <div style={{
                            width: '100%', maxWidth: '40px',
                            height: visible ? `${(v / maxVal) * 80}px` : '0',
                            background: `linear-gradient(180deg, ${chart.color}, color-mix(in srgb, ${chart.color} 40%, transparent))`,
                            borderRadius: '4px 4px 0 0',
                            transition: `height 0.8s ease ${i * 0.1}s`,
                        }} />
                        <span style={{ fontSize: '0.6rem', color: 'var(--text-muted)' }}>{chart.labels[i]}</span>
                    </div>
                ))}
            </div>
        </div>
    );
}

export default function DataInterpret() {
    const { ref, isVisible } = useInView(0.15);
    const [currentQ, setCurrentQ] = useState(0);
    const [selected, setSelected] = useState<number | null>(null);
    const [score, setScore] = useState(0);
    const [phase, setPhase] = useState<'quiz' | 'done'>('quiz');
    const { dispatch } = usePusula();

    const q = useMemo(() => QUESTIONS[currentQ], [currentQ]);

    const handleSelect = (idx: number) => {
        if (selected !== null) return;
        setSelected(idx);
        if (idx === q.correct) setScore(s => s + 1);

        setTimeout(() => {
            if (currentQ < QUESTIONS.length - 1) {
                setCurrentQ(p => p + 1);
                setSelected(null);
            } else {
                setPhase('done');
                dispatch({ type: 'ADD_YETKINLIK', amount: 20, label: 'Veri Yorumlama', beceri: 'Veri Yorumlama' });
            }
        }, 2500);
    };

    return (
        <section className="section" id="data-interpret" ref={ref} style={{ background: 'var(--bg-deep)' }}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M21 12V7H5a2 2 0 0 1 0-4h14v4" /><path d="M3 5v14a2 2 0 0 0 2 2h16v-5" /><path d="M18 12a2 2 0 0 0 0 4h4v-4Z" />
                    </svg>
                    Veri Okuryazarlığı
                </div>

                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '0.5rem' }}>
                    Veriyi <span style={{ color: 'var(--accent-emerald)' }}>Yorumla</span>
                </h2>
                <p className={`reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginBottom: '1.5rem', maxWidth: '600px' }}>
                    Simülasyondan elde edilen grafikleri analiz et. Doğru yorumlama = doğru karar.
                </p>

                {phase === 'quiz' ? (
                    <div className={`card reveal ${isVisible ? 'visible' : ''} delay-3`} style={{ padding: '2rem', maxWidth: '700px', margin: '0 auto' }}>
                        <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '0.75rem' }}>
                            <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.8rem', color: 'var(--text-muted)' }}>{currentQ + 1}/{QUESTIONS.length}</span>
                            <span style={{ fontFamily: 'var(--font-mono)', fontSize: '0.8rem', color: 'var(--accent-emerald)' }}>✓ {score}</span>
                        </div>

                        <MiniChart chart={q.chart} visible={isVisible} />

                        <p style={{ fontWeight: 600, fontSize: '1rem', marginBottom: '1rem' }}>{q.question}</p>

                        <div style={{ display: 'flex', flexDirection: 'column', gap: '0.5rem' }}>
                            {q.options.map((opt, i) => {
                                let bg = 'rgba(255,255,255,0.03)';
                                let border = 'rgba(255,255,255,0.08)';
                                if (selected !== null) {
                                    if (i === q.correct) { bg = 'rgba(16,185,129,0.1)'; border = 'var(--accent-emerald)'; }
                                    else if (i === selected && i !== q.correct) { bg = 'rgba(244,63,94,0.1)'; border = 'var(--accent-rose)'; }
                                }
                                return (
                                    <button
                                        key={i}
                                        onClick={() => handleSelect(i)}
                                        style={{
                                            background: bg, border: `1px solid ${border}`, borderRadius: '10px',
                                            padding: '0.75rem 1rem', color: 'var(--text-primary)', textAlign: 'left',
                                            cursor: selected === null ? 'pointer' : 'default',
                                            transition: 'all 0.2s', fontSize: '0.85rem',
                                        }}
                                    >
                                        <span style={{ fontWeight: 600, marginRight: '0.5rem', opacity: 0.5 }}>{String.fromCharCode(65 + i)}</span>
                                        {opt}
                                    </button>
                                );
                            })}
                        </div>

                        {selected !== null && (
                            <div style={{
                                marginTop: '1rem', padding: '1rem', borderRadius: '10px',
                                background: 'rgba(255,255,255,0.03)', borderLeft: `3px solid ${selected === q.correct ? 'var(--accent-emerald)' : 'var(--accent-rose)'}`,
                                fontSize: '0.85rem', color: 'var(--text-secondary)', lineHeight: 1.7,
                            }}>
                                {selected === q.correct ? '✅ ' : '❌ '}
                                {q.explanation}
                            </div>
                        )}
                    </div>
                ) : (
                    <div className={`card reveal ${isVisible ? 'visible' : ''}`} style={{ padding: '2rem', textAlign: 'center', maxWidth: '500px', margin: '0 auto' }}>
                        <div style={{ fontSize: '3rem', marginBottom: '0.5rem' }}>📊</div>
                        <h3 style={{ marginBottom: '0.5rem' }}>Veri Analizi Tamamlandı!</h3>
                        <p style={{ color: 'var(--text-muted)', marginBottom: '1rem' }}>
                            {score}/{QUESTIONS.length} doğru cevap
                        </p>
                        <div style={{
                            display: 'inline-block', padding: '0.5rem 1.5rem', borderRadius: '8px',
                            background: 'rgba(16,185,129,0.1)', border: '1px solid var(--accent-emerald)',
                            fontFamily: 'var(--font-mono)', fontSize: '0.85rem', color: 'var(--accent-emerald)',
                        }}>
                            +20 Yetkinlik — Veri Yorumlama 📈
                        </div>
                    </div>
                )}
            </div>
        </section>
    );
}
