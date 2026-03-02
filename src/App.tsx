import { PusulaProvider } from './state/PusulaContext';
import Navbar from './components/Navbar';
import Hero from './components/Hero';
import OnboardingVignette from './components/OnboardingVignette';
import KivilcimGate from './components/KivilcimGate';
import WarmupLab from './components/WarmupLab';
import BotArena from './components/BotArena';
import Meridyen from './components/Meridyen';
import CodelabMain from './components/CodelabMain';
import GateChain from './components/GateChain';
import TransferCases from './components/TransferCases';
import RubricRadar from './components/RubricRadar';
import SocialProof from './components/SocialProof';
import Certificate from './components/Certificate';
import SnapshotCTA from './components/SnapshotCTA';
import DataNote from './components/DataNote';
import PusulaMentor from './components/PusulaMentor';

export default function App() {
    return (
        <PusulaProvider>
            <Navbar />
            <PusulaMentor />
            <main>
                <Hero />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,60 C360,100 720,20 1080,60 C1260,80 1380,40 1440,50 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <OnboardingVignette />
                <KivilcimGate />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,40 C480,80 960,0 1440,40 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <WarmupLab />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,50 C360,10 960,70 1440,30 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <BotArena />
                <Meridyen />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,60 C360,20 720,80 1080,30 C1260,10 1380,50 1440,40 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <CodelabMain />
                <GateChain />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,50 C480,10 960,70 1440,30 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <TransferCases />
                <RubricRadar />
                <SocialProof />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,30 C360,70 720,10 1080,50 C1260,70 1380,30 1440,40 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <Certificate />
                {/* Wave divider */}
                <div className="wave-divider">
                    <svg viewBox="0 0 1440 80" preserveAspectRatio="none">
                        <path d="M0,60 C480,30 960,60 1440,30 L1440,80 L0,80 Z" fill="var(--bg-cosmos)" />
                    </svg>
                </div>
                <SnapshotCTA />
                <DataNote />
            </main>
        </PusulaProvider>
    );
}
