import React, { useEffect, useState } from 'react';
import { X, Brain, Target, Rocket, Zap, ChevronRight } from 'lucide-react';

interface OnboardingModalProps {
    isOpen: boolean;
    onClose: () => void;
}

export const OnboardingModal: React.FC<OnboardingModalProps> = ({ isOpen, onClose }) => {
    const [activeTab, setActiveTab] = useState(0);
    const [isRendered, setIsRendered] = useState(false);

    // Mount/Unmount animation logic
    useEffect(() => {
        if (isOpen) {
            setIsRendered(true);
            // Prevent body scroll
            document.body.style.overflow = 'hidden';
        } else {
            // Delay unmount to allow exit animation
            const timer = setTimeout(() => setIsRendered(false), 400);
            document.body.style.overflow = '';
            return () => clearTimeout(timer);
        }
    }, [isOpen]);

    if (!isOpen && !isRendered) return null;

    return (
        <div className={`om-overlay ${isOpen ? 'om-overlay--visible' : 'om-overlay--hidden'}`}>
            {/* Backdrop click to close */}
            <div className="om-backdrop" onClick={onClose} />

            {/* Modal Container */}
            <div className={`om-container ${isOpen ? 'om-container--open' : 'om-container--close'}`}>
                {/* Header */}
                <div className="om-header">
                    <div className="om-header-title">
                        <Zap className="om-header-icon" />
                        <h2>Öğrenmenin Yeni Boyutu</h2>
                    </div>
                    <button className="om-close-btn" onClick={onClose}>
                        <X size={24} />
                    </button>
                </div>

                {/* Content Area */}
                <div className="om-content">
                    {/* Left Sidebar / Tabs */}
                    <div className="om-sidebar">
                        <ul className="om-tab-list">
                            <li
                                className={`om-tab-item ${activeTab === 0 ? 'active' : ''}`}
                                onClick={() => setActiveTab(0)}
                            >
                                <Brain size={18} /> Geleneksel Çöküş
                            </li>
                            <li
                                className={`om-tab-item ${activeTab === 1 ? 'active' : ''}`}
                                onClick={() => setActiveTab(1)}
                            >
                                <Target size={18} /> Edgar Dale Piramidi
                            </li>
                            <li
                                className={`om-tab-item ${activeTab === 2 ? 'active' : ''}`}
                                onClick={() => setActiveTab(2)}
                            >
                                <Rocket size={18} /> PUSULA Farkı
                            </li>
                        </ul>
                    </div>

                    {/* Right Panel / Tab Content */}
                    <div className="om-panel">
                        {activeTab === 0 && (
                            <div className="om-pane-content fade-in">
                                <h3>Pasif Tüketim Dönemi Bitti.</h3>
                                <p className="om-lead">
                                    Geleneksel eğitim sistemleri sizi bir izleyici koltuğuna oturtur. Saatlerce video izler, teorik metinler okur ve sonunda <strong>"Şimdi bunu gerçek dünyada nasıl uygulayacağım?"</strong> sorusuyla baş başa kalırsınız.
                                </p>
                                <div className="om-comparison">
                                    <div className="om-comp-col bad">
                                        <h4>Geleneksel</h4>
                                        <ul>
                                            <li>Pasif dinleme (%10 kalıcılık)</li>
                                            <li>Teorik ezber</li>
                                            <li>Gerçek dünya kopukluğu</li>
                                            <li>Sıfır hata toleransı</li>
                                        </ul>
                                    </div>
                                    <div className="om-comp-col good">
                                        <h4>Yeni Nesil (PUSULA)</h4>
                                        <ul>
                                            <li>Aktif problem çözme (%90 kalıcılık)</li>
                                            <li>Simüle edilmiş krizler</li>
                                            <li>Anında yapay zeka geri bildirimi</li>
                                            <li>Deneyerek yanılma özgürlüğü</li>
                                        </ul>
                                    </div>
                                </div>
                                <button className="om-next-btn" onClick={() => setActiveTab(1)}>
                                    Bilimin Arkasındaki Gerçek <ChevronRight size={16} />
                                </button>
                            </div>
                        )}

                        {activeTab === 1 && (
                            <div className="om-pane-content fade-in">
                                <h3>Edgar Dale'in Yaşantı Konisi</h3>
                                <p className="om-lead">
                                    Öğrenme biliminin altın kuralı: İnsanlar okuduklarının %10'unu, duyduklarının %20'sini, ancak <strong>bizzat yaparak yaşadıklarının %90'ını</strong> hatırlarlar.
                                </p>
                                <div className="om-pyramid-container">
                                    <div className="om-pyramid-level l1"><span className="level-text">Okuma (%10)</span></div>
                                    <div className="om-pyramid-level l2"><span className="level-text">İşitme / Görsel (%20-30)</span></div>
                                    <div className="om-pyramid-level l3"><span className="level-text">Tartışma / İzleme (%50-70)</span></div>
                                    <div className="om-pyramid-level l4 highlight">
                                        <SparklesIcon className="om-sparkle-icon" />
                                        <span className="level-text">Simülasyon İçinde Gerçekten Yapma (%90)</span>
                                    </div>
                                </div>
                                <p className="om-pyramid-desc">
                                    PUSULA, sizi doğrudan piramidin tabanına, yani en yüksek öğrenme veriminin olduğu yere yerleştirir. Kitap yok, sıkıcı video yok. Sadece gerçek krizler ve çözümler var.
                                </p>
                                <button className="om-next-btn" onClick={() => setActiveTab(2)}>
                                    Sisteme Yakından Bak <ChevronRight size={16} />
                                </button>
                            </div>
                        )}

                        {activeTab === 2 && (
                            <div className="om-pane-content fade-in">
                                <h3>Gerçek Simülasyon, Gerçek Yetenek</h3>
                                <p className="om-lead">
                                    Pusula sıradan bir platform değildir. O, sizin yeteneklerinizi döverek şekillendiren bir <strong>dijital demirci ocağıdır (Forge).</strong>
                                </p>

                                <div className="om-feature-grid">
                                    <div className="om-feature-card">
                                        <div className="om-fc-icon"><Brain size={20} /></div>
                                        <h4>Sokratik AI Mentor</h4>
                                        <p>Cevapları doğrudan vermez. Size doğru soruları sorarak kendi çözümünüzü bulmanızı sağlar.</p>
                                    </div>
                                    <div className="om-feature-card">
                                        <div className="om-fc-icon"><Target size={20} /></div>
                                        <h4>Gerçek Kriz Senaryoları</h4>
                                        <p>Zaman baskısı altında, riskli kararlar almanızı gerektiren dinamik simülasyonlar.</p>
                                    </div>
                                    <div className="om-feature-card">
                                        <div className="om-fc-icon"><Zap size={20} /></div>
                                        <h4>Anında Gelişim</h4>
                                        <p>Hata yaptığınız an anında geri bildirim alır, teoriyi pratiğe dökerken kalıcı yetenek inşa edersiniz.</p>
                                    </div>
                                </div>

                                <div className="om-action-footer">
                                    <button className="om-start-btn" onClick={onClose}>
                                        Denemeye Hazırım
                                    </button>
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
        </div>
    );
};

// SVG Icon Helper
function SparklesIcon(props: React.SVGProps<SVGSVGElement>) {
    return (
        <svg
            {...props}
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
        >
            <path d="m12 3-1.912 5.813a2 2 0 0 1-1.275 1.275L3 12l5.813 1.912a2 2 0 0 1 1.275 1.275L12 21l1.912-5.813a2 2 0 0 1 1.275-1.275L21 12l-5.813-1.912a2 2 0 0 1-1.275-1.275L12 3Z" />
            <path d="M5 3v4" />
            <path d="M19 17v4" />
            <path d="M3 5h4" />
            <path d="M17 19h4" />
        </svg>
    );
}
