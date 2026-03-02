import { useInView } from '../hooks/useInView';

const steps = [
    {
        num: 1,
        numClass: 'vignette__step-number--1',
        title: 'Mevcut Durum',
        desc: 'Deniz, 22 yaşında, İstanbul\'da yaşıyor. Üniversiteden yeni mezun oldu ama dijital becerileri sınırlı. İş başvurularında sürekli reddediliyor.',
    },
    {
        num: 2,
        numClass: 'vignette__step-number--2',
        title: 'Problem',
        desc: 'Geleneksel eğitim modelleri Deniz\'e gerçek dünya becerileri kazandırmıyor. Teorik bilgi pratiğe dönüşmüyor, motivasyon düşüyor.',
    },
    {
        num: 3,
        numClass: 'vignette__step-number--3',
        title: 'Çözüm: PUSULA',
        desc: 'PUSULA ile Deniz, belediye kuyruğu gibi gerçek problemleri çözerek Python, veri analizi ve problem çözme becerilerini 8 haftada kazanıyor.',
    },
];

export default function OnboardingVignette() {
    const { ref, isVisible } = useInView(0.15);

    return (
        <section className="section" id="onboarding-vignette" ref={ref} style={{ background: 'var(--bg-cosmos)' }}>
            <div className="container">
                <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" />
                    </svg>
                    Öğrenci Hikayesi
                </div>
                <h2 className={`reveal ${isVisible ? 'visible' : ''} delay-1`} style={{ marginBottom: '2.5rem' }}>
                    Deniz'in <span style={{ color: 'var(--accent-amber)' }}>Dönüşüm</span> Yolculuğu
                </h2>

                <div className="vignette">
                    {/* Avatar */}
                    <div className={`vignette__avatar reveal ${isVisible ? 'visible' : ''} delay-2`}>
                        <svg viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                            {/* Background circle */}
                            <circle cx="100" cy="100" r="95" fill="var(--bg-nebula)" stroke="var(--border-dim)" strokeWidth="2" />
                            <circle cx="100" cy="100" r="88" fill="var(--bg-void)" stroke="rgba(56,189,248,0.1)" strokeWidth="1" />
                            {/* Face */}
                            <circle cx="100" cy="82" r="32" fill="var(--accent-cyan-dim)" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                            {/* Eyes */}
                            <circle cx="90" cy="78" r="3" fill="var(--accent-cyan)" />
                            <circle cx="110" cy="78" r="3" fill="var(--accent-cyan)" />
                            {/* Smile */}
                            <path d="M90 88 Q100 96 110 88" stroke="var(--accent-cyan)" strokeWidth="2" fill="none" strokeLinecap="round" />
                            {/* Body */}
                            <path d="M60 155 Q60 120 100 115 Q140 120 140 155" fill="var(--accent-cyan-dim)" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                            {/* Laptop */}
                            <rect x="78" y="130" rx="3" width="44" height="28" fill="var(--bg-cosmos)" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                            <line x1="82" y1="140" x2="105" y2="140" stroke="var(--accent-emerald)" strokeWidth="1.5" strokeLinecap="round" />
                            <line x1="82" y1="145" x2="96" y2="145" stroke="var(--accent-amber)" strokeWidth="1.5" strokeLinecap="round" />
                            <line x1="82" y1="150" x2="112" y2="150" stroke="var(--accent-violet)" strokeWidth="1.5" strokeLinecap="round" />
                            {/* Name */}
                            <text x="100" y="185" textAnchor="middle" fill="var(--text-primary)" fontSize="13" fontFamily="var(--font-display)" fontWeight="700">Deniz, 22</text>
                        </svg>
                    </div>

                    {/* Steps */}
                    <div className="vignette__steps">
                        {steps.map((step, i) => (
                            <div
                                key={step.num}
                                className={`vignette__step card reveal ${isVisible ? 'visible' : ''} delay-${i + 2}`}
                            >
                                <div className={`vignette__step-number ${step.numClass}`}>{step.num}</div>
                                <div>
                                    <h3 style={{ fontSize: '1.05rem', marginBottom: '0.35rem' }}>{step.title}</h3>
                                    <p style={{ fontSize: '0.9rem', lineHeight: '1.7' }}>{step.desc}</p>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </section>
    );
}
