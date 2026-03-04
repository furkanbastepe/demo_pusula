import { useInView } from '../hooks/useInView';
import { Smartphone, Zap, Globe, Shield, CircleQuestionMark, Ribbon, Users } from 'lucide-react';

const features = [
    {
        icon: CircleQuestionMark,
        title: 'Problem Tabanlı Öğrenme',
        desc: 'Sektörün gerçek problemlerini çözerek öğrenir. Bunu neden öğreniyorum hissiyatı kaybolur.',
        color: 'var(--accent-amber)',
    },
    {
        icon: Ribbon,
        title: 'Gönüllülük Projeleri',
        desc: 'Sivil toplum kuruluşlarını ihtiyaç duyduğu projelerde gönüllü olarak çalışması teşvik edilir.',
        color: 'var(--accent-cyan)',
    },
    {
        icon: Users,
        title: 'Ahilik Sistemi',
        desc: 'Usta-Çırak sistemi sayesinde akran öğrenmesi desteklenir.',
        color: 'var(--accent-emerald)',
    },
];

export default function MobileEmulator() {
    const { ref, isVisible } = useInView(0.1);

    return (
        <section className="section emulator-section" id="mobile-emulator" ref={ref} style={{ background: 'var(--bg-void)' }}>
            {/* Ambient Glow */}
            <div className="emulator-section__glow" />

            <div className="container emulator-section__layout">
                {/* Left — Copy */}
                <div className="emulator-section__copy">
                    <div className={`section-label reveal ${isVisible ? 'visible' : ''}`}>
                        <Smartphone size={16} />
                        Canlı Demo
                    </div>
                    <h2 className={`emulator-section__title reveal ${isVisible ? 'visible' : ''} delay-1`}>
                        Uygulamayı <span style={{ color: 'var(--accent-cyan)' }}>Hemen</span> Dene
                    </h2>
                    <p className={`emulator-section__subtitle reveal ${isVisible ? 'visible' : ''} delay-2`}>
                        PUSULA demo uygulamasını indirmeden, doğrudan tarayıcında deneyimle.
                    </p>

                    <div className="emulator-section__features">
                        {features.map((f, i) => (
                            <div
                                key={f.title}
                                className={`emulator-section__feature reveal ${isVisible ? 'visible' : ''} delay-${i + 3}`}
                            >
                                <div className="emulator-section__feature-icon" style={{ color: f.color, borderColor: f.color }}>
                                    <f.icon size={20} />
                                </div>
                                <div>
                                    <h4 className="emulator-section__feature-title">{f.title}</h4>
                                    <p className="emulator-section__feature-desc">{f.desc}</p>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* Right — Phone Frame */}
                <div className={`emulator-section__device reveal ${isVisible ? 'visible' : ''} delay-2`} style={{ marginLeft: '-90px', marginTop: '50px' }}>
                    <div className="emu-phone">
                        <div className="emu-phone__notch" />
                        <div className="emu-phone__screen">
                            <iframe
                                src="/pusula-app/index.html"
                                title="PUSULA Mobil Uygulama"
                                className="emu-phone__iframe"
                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope"
                                loading="lazy"
                            />
                        </div>
                        {/* Side Buttons */}
                        <div className="emu-phone__btn emu-phone__btn--power" />
                        <div className="emu-phone__btn emu-phone__btn--vol-up" />
                        <div className="emu-phone__btn emu-phone__btn--vol-down" />
                    </div>
                </div>
            </div>
        </section>
    );
}
