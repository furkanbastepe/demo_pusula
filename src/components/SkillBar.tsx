import { usePusula } from '../state/PusulaContext';

const TOTAL_SECTIONS = 13;

export default function SkillBar() {
    const { state } = usePusula();
    const pct = Math.min(100, Math.round((state.currentSection / (TOTAL_SECTIONS - 1)) * 100));

    return (
        <div className="skill-bar">
            <div className="skill-bar__inner">
                {/* Progress */}
                <div className="skill-bar__progress-wrap">
                    <div className="skill-bar__progress-track">
                        <div className="skill-bar__progress-fill" style={{ width: `${pct}%` }} />
                    </div>
                    <span className="skill-bar__pct">{pct}%</span>
                </div>

                {/* XP Counter */}
                <div className="skill-bar__xp">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .963 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.963 0z" fill="var(--accent-emerald)" opacity="0.3" />
                    </svg>
                    <span>{state.yetkinlikPuani}</span>
                </div>

                {/* Skills count */}
                <div className="skill-bar__badges">
                    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                        <circle cx="12" cy="8" r="6" /><path d="M15.477 12.89L17 22l-5-3-5 3 1.523-9.11" />
                    </svg>
                    <span>{state.kazanilanBeceriler.length}</span>
                </div>
            </div>
        </div>
    );
}
