import { useEffect, useState } from 'react';
import { useScrollProgress } from '../hooks/useInView';
import { usePusula } from '../state/PusulaContext';

const sections = [
    'hero', 'onboarding-vignette', 'kivilcim-gate', 'warmup-lab', 'bot-arena', 'meridyen',
    'codelab-main', 'gate-chain', 'transfer-cases', 'rubric-radar',
    'social-proof', 'certificate', 'snapshot-cta',
];

const stageOrder = [
    'intro', 'intro', 'kivilcim_answered', 'kivilcim_answered', 'kivilcim_answered', 'meridyen_mapped',
    'main_intervention', 'why_pending', 'transfer_done', 'decision_ready',
    'decision_ready', 'decision_ready', 'decision_ready',
];

export default function Navbar() {
    const progress = useScrollProgress();
    const { state } = usePusula();
    const [activeIdx, setActiveIdx] = useState(0);

    useEffect(() => {
        const handleScroll = () => {
            const scrollY = window.scrollY + window.innerHeight / 3;
            for (let i = sections.length - 1; i >= 0; i--) {
                const el = document.getElementById(sections[i]);
                if (el && el.offsetTop <= scrollY) {
                    setActiveIdx(i);
                    break;
                }
            }
        };

        window.addEventListener('scroll', handleScroll, { passive: true });
        return () => window.removeEventListener('scroll', handleScroll);
    }, []);

    const scrollTo = (id: string) => {
        document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
    };

    return (
        <>
            {/* Progress Bar */}
            <div className="progress-bar" style={{ width: `${progress}%` }} />

            {/* Navbar */}
            <nav className="navbar" role="navigation" aria-label="İlerleme navigasyonu">
                <div className="navbar__logo" onClick={() => scrollTo('hero')} role="button" tabIndex={0}>
                    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <circle cx="12" cy="12" r="10" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                        <polygon points="12,4 13.5,11 12,12 10.5,11" fill="var(--accent-cyan)" />
                        <polygon points="12,20 13.5,13 12,12 10.5,13" fill="var(--accent-rose)" opacity="0.6" />
                        <circle cx="12" cy="12" r="1.5" fill="var(--accent-cyan)" />
                    </svg>
                    PUSULA
                </div>

                <div className="navbar__dots">
                    {sections.map((id, i) => {
                        const isCompleted = i < activeIdx;
                        const isActive = i === activeIdx;
                        return (
                            <div
                                key={id}
                                className={`navbar__dot ${isActive ? 'navbar__dot--active' : ''} ${isCompleted ? 'navbar__dot--completed' : ''}`}
                                onClick={() => scrollTo(id)}
                                role="button"
                                tabIndex={0}
                                title={id.replace(/-/g, ' ')}
                                aria-label={`Bölüm ${i + 1}`}
                            />
                        );
                    })}
                </div>
            </nav>
        </>
    );
}
