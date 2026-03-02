import React from 'react';

export const CompassGraphic = () => {
    return (
        <div className="hero-premium__compass-wrapper">
            <svg
                className="hero-premium__compass-svg"
                viewBox="0 0 400 400"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
            >
                {/* Outer Glow definitions */}
                <defs>
                    <filter id="glow" x="-20%" y="-20%" width="140%" height="140%">
                        <feGaussianBlur stdDeviation="8" result="blur" />
                        <feComposite in="SourceGraphic" in2="blur" operator="over" />
                    </filter>
                    <filter id="glow-intense" x="-50%" y="-50%" width="200%" height="200%">
                        <feGaussianBlur stdDeviation="15" result="blur" />
                        <feComposite in="SourceGraphic" in2="blur" operator="over" />
                    </filter>
                    <linearGradient id="ring-grad" x1="0%" y1="0%" x2="100%" y2="100%">
                        <stop offset="0%" stopColor="#38bdf8" stopOpacity="0.8" />
                        <stop offset="100%" stopColor="#818cf8" stopOpacity="0.2" />
                    </linearGradient>
                    <linearGradient id="needle-grad" x1="50%" y1="0%" x2="50%" y2="100%">
                        <stop offset="0%" stopColor="#38bdf8" />
                        <stop offset="50%" stopColor="#c084fc" />
                        <stop offset="100%" stopColor="#818cf8" />
                    </linearGradient>
                </defs>

                {/* Outer dashed ring - rotating slowly clockwise */}
                <g className="compass-ring-outer" style={{ transformOrigin: '200px 200px' }}>
                    <circle
                        cx="200"
                        cy="200"
                        r="160"
                        stroke="url(#ring-grad)"
                        strokeWidth="2"
                        strokeDasharray="4 8"
                        opacity="0.6"
                    />
                    {/* Cardinal Points on Outer Ring */}
                    <text x="200" y="25" fill="#64748b" fontSize="14" fontWeight="bold" textAnchor="middle" letterSpacing="0.1em">N</text>
                    <text x="200" y="385" fill="#64748b" fontSize="14" fontWeight="bold" textAnchor="middle" letterSpacing="0.1em">S</text>
                    <text x="385" y="205" fill="#64748b" fontSize="14" fontWeight="bold" textAnchor="middle" letterSpacing="0.1em">E</text>
                    <text x="15" y="205" fill="#64748b" fontSize="14" fontWeight="bold" textAnchor="middle" letterSpacing="0.1em">W</text>
                </g>

                {/* Middle solid ring - rotating counter-clockwise */}
                <g className="compass-ring-inner" style={{ transformOrigin: '200px 200px' }}>
                    <circle
                        cx="200"
                        cy="200"
                        r="130"
                        stroke="rgba(129, 140, 248, 0.3)"
                        strokeWidth="1"
                    />
                    {/* Degree markers */}
                    {[...Array(12)].map((_, i) => (
                        <line
                            key={i}
                            x1="200"
                            y1="70"
                            x2="200"
                            y2="80"
                            stroke="#818cf8"
                            strokeWidth="2"
                            opacity="0.5"
                            transform={`rotate(${i * 30} 200 200)`}
                        />
                    ))}
                </g>

                {/* Inner geometric core */}
                <circle cx="200" cy="200" r="90" fill="rgba(3, 7, 18, 0.6)" stroke="rgba(56, 189, 248, 0.4)" strokeWidth="1" />
                <circle cx="200" cy="200" r="15" fill="#38bdf8" filter="url(#glow-intense)" />

                {/* Dynamic Needles */}
                <g className="compass-needle-main" style={{ transformOrigin: '200px 200px' }}>
                    {/* North/South primary needle */}
                    <path
                        d="M200 80 L215 200 L200 320 L185 200 Z"
                        fill="url(#needle-grad)"
                        filter="url(#glow)"
                        opacity="0.9"
                    />
                    {/* East/West secondary needle */}
                    <path
                        d="M90 200 L200 190 L310 200 L200 210 Z"
                        fill="rgba(192, 132, 252, 0.4)"
                    />
                    {/* Center pinpoint */}
                    <circle cx="200" cy="200" r="4" fill="#fff" />
                </g>
            </svg>
        </div>
    );
};
