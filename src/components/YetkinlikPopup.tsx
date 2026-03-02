import { useEffect } from 'react';
import { usePusula } from '../state/PusulaContext';

export default function YetkinlikPopup() {
    const { state, dispatch } = usePusula();
    const popup = state.showYetkinlikPopup;

    useEffect(() => {
        if (!popup) return;
        const t = setTimeout(() => dispatch({ type: 'HIDE_YETKINLIK_POPUP' }), 2500);
        return () => clearTimeout(t);
    }, [popup, dispatch]);

    if (!popup) return null;

    return (
        <div className="yetkinlik-popup" key={`${popup.amount}-${popup.label}-${Date.now()}`}>
            <div className="yetkinlik-popup__inner">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="var(--accent-emerald)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                    <path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .963 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.963 0z" fill="var(--accent-emerald)" opacity="0.3" />
                </svg>
                <span className="yetkinlik-popup__amount">+{popup.amount}</span>
                <span className="yetkinlik-popup__label">{popup.label}</span>
            </div>
        </div>
    );
}
