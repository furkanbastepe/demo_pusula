import { useState, useMemo } from 'react';
import { useInView } from '../hooks/useInView';
import { Spotlight } from './Spotlight';
import { ArrowRight } from 'lucide-react';
import { CompassGraphic } from './CompassGraphic';
import { OnboardingModal } from './OnboardingModal';

export default function Hero() {
    const { ref, isVisible } = useInView(0.1);
    const [isModalOpen, setIsModalOpen] = useState(false);

    const scrollToNext = () => {
        document.getElementById('mobile-emulator')?.scrollIntoView({ behavior: 'smooth' });
    };

    /* Generate stars for ambient background */
    const stars = useMemo(() => Array.from({ length: 120 }, (_, i) => ({
        id: i,
        x: Math.random() * 100,
        y: Math.random() * 100,
        size: Math.random() * 2 + 0.5,
        dur: Math.random() * 5 + 3,
        delay: Math.random() * 5,
    })), []);

    return (
        <section className="hero-premium" id="hero" ref={ref}>
            {/* Ambient Backgrounds & Spotlights */}
            <div className="hero-premium__bg">
                <Spotlight className="hero-premium__spotlight-left" fill="rgba(56, 189, 248, 0.5)" />
                <Spotlight className="hero-premium__spotlight-right" fill="rgba(168, 85, 247, 0.4)" />

                <div className="starfield">
                    {stars.map(s => (
                        <span
                            key={s.id}
                            className="starfield__star"
                            style={{
                                left: `${s.x}%`,
                                top: `${s.y}%`,
                                width: `${s.size}px`,
                                height: `${s.size}px`,
                                '--dur': `${s.dur}s`,
                                '--delay': `${s.delay}s`,
                            } as React.CSSProperties}
                        />
                    ))}
                </div>
                {/* Vignette overlay for depth */}
                <div className="hero-premium__vignette" />
            </div>

            {/* Content Container */}
            <div className="hero-premium__container">
                {/* Left Side: Massive Typography */}
                <div className="hero-premium__content">
                    <h1 className={`hero-premium__title reveal ${isVisible ? 'visible' : ''} delay-1`}>
                        Geleceğin <br />
                        <span className="hero-premium__title-gradient">Dijital Yetenekleri</span>
                        <br /> Burada İnşa Ediliyor.
                    </h1>

                    <p className={`hero-premium__subtitle reveal ${isVisible ? 'visible' : ''} delay-2`}>
                        Problem tabanlı öğrenme ve yapay zeka ile 18-29 yaş arası
                        gençleri geleceğin dijital dünyasına mükemmel hazırlıyoruz.
                        Pasif izleyici değil, aktif problem çözücü olun.
                    </p>

                    <div className={`hero-premium__actions reveal ${isVisible ? 'visible' : ''} delay-3`}>
                        <button className="hero-premium__btn--primary" onClick={scrollToNext}>
                            <span>Simülasyonu Başlat</span>
                            <ArrowRight size={18} className="hero-premium__btn-icon" />
                        </button>
                        <button className="hero-premium__btn--secondary" onClick={() => setIsModalOpen(true)}>
                            Nasıl Çalışır?
                        </button>
                    </div>
                </div>
            </div>

            {/* Right Side: Animated SVG Compass */}
            <div className={`hero-premium__compass-container reveal ${isVisible ? 'visible' : ''} delay-2`}>
                <CompassGraphic />
            </div>

            {/* Scroll Indicator */}
            <div className={`hero-premium__scroll reveal ${isVisible ? 'visible' : ''} delay-5`}>
                <div className="hero-premium__mouse">
                    <div className="hero-premium__wheel" />
                </div>
                <span>Aşağı Kaydır</span>
            </div>

            {/* Premium Onboarding Modal Overlay */}
            <OnboardingModal isOpen={isModalOpen} onClose={() => setIsModalOpen(false)} />
        </section>
    );
}
