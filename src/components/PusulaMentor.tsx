import { useState, useEffect, useCallback, useRef, useMemo } from 'react';
import { usePusula } from '../state/PusulaContext';

/* ── Types ── */
interface MentorMessage {
    id: string;
    role: 'mentor' | 'user';
    text: string;
    card?: { title: string; content: string };
    timestamp: number;
}

interface SectionConfig {
    welcome: string;
    proactiveMessages: { trigger: string; message: string; card?: { title: string; content: string } }[];
    responses: { keywords: string[]; socratic: string; followUp: string; card?: { title: string; content: string } }[];
    fallback: string;
}

/* ── Mentor Knowledge Base (Khanmigo-style Socratic) ── */
const MENTOR_DB: Record<string, SectionConfig> = {
    'hero': {
        welcome: 'Merhaba! 👋 Ben PUSULA Mentor. Bu yolculukta sana rehberlik edeceğim. Hazırsan "Deneyimi Başlat" butonuna tıkla!',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['merhaba', 'selam', 'naber', 'nasılsın'],
                socratic: 'Merhaba! Bugün birlikte belediye kuyruğu problemini çözeceğiz. Problem çözmenin en iyi yolu ne sence — hemen cevabı öğrenmek mi, yoksa deneme-yanılma mı?',
                followUp: 'Araştırmalar gösteriyor ki, önce zorlanan öğrenciler %23 daha derin öğreniyor. Buna "Üretken Başarısızlık" deniyor!',
            },
        ],
        fallback: 'Harika bir soru! Ama önce yolculuğa başlayalım — aşağı kaydırarak Deniz\'in hikayesini keşfet. Her bölümde sana yardımcı olacağım. 🚀',
    },
    'onboarding-vignette': {
        welcome: 'Deniz\'in hikayesini okuyorsun. 22 yaşında, dijital becerileri sınırlı. Bu hikaye sana tanıdık geliyor mu?',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['deniz', 'kim', 'hikaye'],
                socratic: 'Deniz, birçok gencin yaşadığı gerçek bir durumu temsil ediyor. Sence Deniz\'in en büyük sorunu bilgi eksikliği mi, yoksa o bilgiyi uygulamak mı?',
                followUp: 'PUSULA tam da bu farkı kapatmak için tasarlandı — teori değil, gerçek problemlerle öğrenme.',
            },
        ],
        fallback: 'Deniz\'in yolculuğunu takip ediyoruz. Her bölümde onunla birlikte ilerleyeceğiz. Devam et, Kıvılcım Kapısı seni bekliyor! ↓',
    },
    'kivilcim-gate': {
        welcome: 'Kıvılcım Kapısı\'na geldin! Burada önce düşüneceksin, sonra çözeceksin. En az 2 cümle yazarak kapıyı aç.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['ne yazayım', 'yardım', 'fikir', 'bilmiyorum'],
                socratic: 'Şöyle düşün: Sen bir belediye başkanı olsan ve vatandaşlar kuyruktan şikayet etse, ilk ne yapardın? 🤔',
                followUp: 'İpucu: Problemi anlamak için "Neden kuyruklar uzun?" ve "Vatandaşlar ne istiyor?" sorularını düşünebilirsin.',
            },
            {
                keywords: ['kuyruk', 'belediye', 'vatandaş'],
                socratic: 'Güzel düşünüyorsun! Peki bu problemi çözmek için hangi verilere ihtiyacın olur? Kuyruk uzunluğu, bekleme süresi, gişe sayısı... Başka ne olabilir?',
                followUp: 'Veri toplamak problem çözmenin ilk adımı. PUSULA\'da bunu "Meridyen Anı" olarak adlandırıyoruz.',
            },
        ],
        fallback: 'Bu kapıda amaç, problemi kendi sözlerinle ifade etmen. Doğru ya da yanlış cevap yok — önemli olan düşünme süreci! ✨',
    },
    'warmup-lab': {
        welcome: 'Kodlama Laboratuvarı\'na hoş geldin! 🧪 Burada Python\'un temellerini gerçek bir trafik lambası simülasyonuyla öğreneceksin.',
        proactiveMessages: [
            {
                trigger: 'first_error',
                message: 'Hata yaptın — ve bu harika! 🎉 Araştırmalar hata yaparak öğrenmenin %40 daha etkili olduğunu gösteriyor. Hatanın sebebini düşün, sonra tekrar dene.',
                card: { title: 'Üretken Başarısızlık', content: 'Prof. Manu Kapur\'un araştırması: Önce zorlanan, sonra doğru yolu keşfeden öğrenciler kavramları %23 daha derin anlıyor.' },
            },
            {
                trigger: 'third_error',
                message: 'Biraz zorlanıyorsun gibi görünüyor, ama pes etme! 💪 Şunu kontrol et: tırnak işaretlerini doğru kullandın mı? Bilgisayar metin ile sayıyı ayırt etmek için tırnak kullanır.',
            },
        ],
        responses: [
            {
                keywords: ['string', 'metin', 'tırnak', 'tirnak'],
                socratic: 'Güzel soru! 🤔 Şunu düşün: trafik_lambasi = kırmızı yazdığında bilgisayar "kırmızı"yı ne sanır? Bir değişken mi, yoksa bir metin mi?',
                followUp: 'Bilgisayar tırnak işaretlerini görünce "bu bir metin" diye anlıyor. Metinlere programlamada String diyoruz.',
                card: { title: 'String (Metin) Veri Tipi', content: 'Tırnak içinde yazılan her şey bir String\'dir:\n• "kırmızı" ✅\n• "Deniz" ✅\n• kırmızı ❌ (tırnak yok = değişken aranır)' },
            },
            {
                keywords: ['int', 'sayı', 'sayi', 'integer', 'numara'],
                socratic: 'Sayılar ilginç! araba_hizi = 100 yazdığında neden tırnak kullanmıyoruz sence?',
                followUp: 'Çünkü bilgisayar sayılarla matematik yapabilir: 100 + 50 = 150. Ama "100" + "50" = "10050" olur! Fark büyük.',
                card: { title: 'Integer (Tam Sayı) Veri Tipi', content: 'Sayılar tırnak olmadan yazılır:\n• araba_hizi = 100 ✅ (Integer)\n• araba_hizi = "100" ❌ (Bu bir String!)' },
            },
            {
                keywords: ['değişken', 'degisken', 'variable', 'atama'],
                socratic: 'Bir değişken, bilgisayarın hafızasındaki bir etiket gibidir. trafik_lambasi = "kırmızı" yazdığında ne oluyor sence?',
                followUp: 'Bilgisayar hafızasında "trafik_lambasi" etiketli bir kutu açıyor ve içine "kırmızı" yazıyor. İstediğin zaman bu kutuyu açıp bakabilirsin!',
                card: { title: 'Değişken Nedir?', content: 'Etiketli kutu metaforu:\n📦 trafik_lambasi → "kırmızı"\n📦 araba_hizi → 100\n\nKurallar: boşluk yok, Türkçe karakter kullanılabilir, sayı ile başlamaz.' },
            },
            {
                keywords: ['hata', 'error', 'yanlış', 'yanlis', 'çalışmıyor', 'calismıyor'],
                socratic: 'Hata mesajını dikkatlice oku — bilgisayar sana ne yanlış gittiğini söylüyor! Hangi satırda hata var? 🔍',
                followUp: 'Programcıların %90\'ı zamanının yarısını hata ayıklamaya harcıyor. Hata bulmak, kod yazmak kadar önemli bir beceri!',
            },
            {
                keywords: ['if', 'koşul', 'kosul', 'elif', 'else', 'şart', 'sart'],
                socratic: 'Koşullu ifadeler bilgisayarın "karar verme" yeteneğidir. Günlük hayattan bir koşul örneği verebilir misin?',
                followUp: '"Eğer yağmur yağıyorsa → şemsiye al, değilse → güneş gözlüğü tak" — bu tam bir if/else yapısı!',
                card: { title: 'Koşullu İfadeler (if/else)', content: 'if yagmur == True:\n    semsiye_al()\nelse:\n    gozluk_tak()\n\nBilgisayar koşulu kontrol eder ve doğruysa ilk bloğu, yanlışsa else bloğunu çalıştırır.' },
            },
        ],
        fallback: 'Denemekten çekinme! Bu laboratuvarda hata yapmak öğrenmenin bir parçası. Bir şey takılırsa bana sor — ama önce bir tahmin yap! 🧪',
    },
    'bot-arena': {
        welcome: 'Şehir Yönetim Botu arenasına geldin! 🏛️ Burada Python ile bir belediye hizmet botu yazacak ve rakibinle yarışacaksın.',
        proactiveMessages: [
            {
                trigger: 'strategy_select',
                message: 'Strateji seçtin! Peki bu stratejiyi neden seçtin? Yoğun saatlerde kuyruk ne kadar uzar düşündün mü? Stratejiyi kendi ihtiyacına göre düzenleyebilirsin.',
            },
        ],
        responses: [
            {
                keywords: ['strateji', 'hangi', 'hangisi', 'en iyi', 'seçeyim', 'seceyim'],
                socratic: 'Her stratejinin güçlü ve zayıf yanları var. Şunu düşün: vatandaş memnuniyeti mi, bütçe tasarrufu mu daha önemli sence?',
                followUp: 'Gerçek hayatta da yöneticiler bu dengeyi kurmaya çalışır. Aslında en iyi strateji "duruma göre karar veren" — yani koşullu düşünen stratejidir!',
            },
            {
                keywords: ['gise', 'gişe', 'kuyruk', 'bekleme'],
                socratic: 'Gişe sayısını artınca ne olur? Kuyruk kısalır, ama maliyet artar. Peki en az maliyetle en çok vatandaşı nasıl mutlu edersin?',
                followUp: 'Bu tam bir optimizasyon problemi! Veri bilimcileri tam da bu tür soruları çözer.',
                card: { title: 'Optimizasyon', content: 'Kısıtlı kaynaklarla en iyi sonucu elde etme.\n\nÖrnek: 5 gişe ile 200 vatandaşa hizmet ver.\nAmaç: Ortalama bekleme ≤ 10 dk\nKısıt: Bütçe ≤ 500 birim' },
            },
            {
                keywords: ['kazanamıyorum', 'kaybediyorum', 'rakip', 'yeniliyorum'],
                socratic: 'Log kayıtlarına bak — rakibin hangi saatlerde seni geçiyor? Yoğun saatlerde (09:00-17:00) gişe açmayı denedin mi?',
                followUp: 'İpucu: if saat > 9 and saat < 17: gise_ac(3) gibi bir koşul eklemek büyük fark yaratabilir!',
            },
        ],
        fallback: 'Şehir yönetimi karmaşık bir problem — ama parçalara bölerek çözebilirsin. Hangi saatlerde kuyruk yoğun? Bu sorudan başla! 🏛️',
    },
    'quick-decision': {
        welcome: 'Hızlı Karar Modülü! ⚡ Gerçek dünya kriz senaryolarında zamana karşı yarışacaksın. Her saniye önemli!',
        proactiveMessages: [
            {
                trigger: 'timeout',
                message: 'Süre doldu! Kriz anlarında hızlı karar vermek çok önemli. Ama acele karar = kötü karar değildir. Asıl mesele şu: hangi bilgiye öncelik verdiğin. 🧠',
            },
        ],
        responses: [
            {
                keywords: ['karar', 'doğru', 'nasıl', 'zor'],
                socratic: 'Kriz anında karar verirken şunu düşün: Bu kararın en kötü sonucu ne olabilir? Geri dönüşü var mı?',
                followUp: 'Karar bilimi (Decision Science) der ki: Belirsizlik altında en iyi strateji \"geri dönülebilir\" kararları hızla vermektir. Geri dönülemez kararlar için daha fazla bilgi topla.',
                card: { title: 'Karar Matrisi', content: 'Hızlı karar framework\'ü:\n1. Etki büyüklüğü? (yüksek/düşük)\n2. Geri dönülebilir mi?\n3. Zaman baskısı var mı?\n\nYüksek etki + geri dönülemez = Daha fazla analiz\nDüşük etki + geri dönülebilir = Hızla karar ver' },
            },
            {
                keywords: ['güvenlik', 'veri', 'sızıntı', 'siber'],
                socratic: 'Siber güvenlikte altın kural nedir sence? Önce koru, sonra araştır — yoksa önce araştır, sonra koru mu?',
                followUp: 'Doğru cevap: \"Containment First\" — önce hasarı sınırla, sonra araştır. Bu IT sektörünün evrensel kuralıdır.',
            },
        ],
        fallback: 'Kriz yönetimi = Soğukkanlılık + Hızlı analiz + Kararlı eylem. Bu modülde tam bunu pratik ediyorsun! ⚡',
    },
    'meridyen': {
        welcome: 'Meridyen Anı — düşüncenin modele dönüştüğü an! Belediye kuyruğunu çözmek için yaklaşımını seç.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['fark', 'arasındaki', 'hangisi'],
                socratic: 'Her yaklaşım farklı bir değişkeni hedefler. Sence kuyruk probleminde en etkili kontrol edebileceğin değişken hangisi?',
                followUp: 'Problem çözümünde ilk adım: "Neyi değiştirebilirim?" sorusunu sormaktır. Bu Meridyen Anı\'nın özü.',
            },
        ],
        fallback: 'Her yaklaşım farklı bir açıdan bakar. Doğru ya da yanlış yok — önemli olan mantığını kurabilmen. 🌐',
    },
    'codelab-main': {
        welcome: 'Ana Kodlama Laboratuvarı! Burada gerçek belediye verisiyle çalışacaksın. Slider\'ları hareket ettir ve sonuçları gözlemle.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['slider', 'değer', 'deger', 'parametre'],
                socratic: 'Gişe sayısını artırınca bekleme süresi ne oldu? Peki bütçe? Bu iki değer arasındaki ilişkiyi fark ettin mi?',
                followUp: 'Bu bir ters orantı! Gişe ↑ → Bekleme ↓ ama Maliyet ↑. Optimum noktayı bulmak veri analizidir.',
            },
        ],
        fallback: 'Parametrelerle oyna ve sonuçları gözlemle. Veri analizi = deney yapmak + sonuç çıkarmak! 📊',
    },
    'data-interpret': {
        welcome: 'Veri Yorumlama zamanı! 📊 Simülasyondan gelen grafikleri okuyup doğru sonuçları çıkar.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['grafik', 'tablo', 'veri', 'oku'],
                socratic: 'Bir grafikte ilk bakman gereken şey ne? Trendi mi, uç değerleri mi, yoksa ortalamayı mı?',
                followUp: 'Veri analisti olmanın ilk kuralı: Önce genel trendi gör, sonra anomalilere odaklan. Detay öncesi büyük resim!',
            },
            {
                keywords: ['azalan', 'getiri', 'diminishing'],
                socratic: 'Neden 6. gişeyi açmak 3. gişeyi açmak kadar etkili değil sence?',
                followUp: 'Bu ekonomideki \"azalan marjinal getiri\" yasasıdır. Her ek birim daha az ek fayda sağlar. Veri bunu kanıtlıyor!',
            },
        ],
        fallback: 'Grafikleri dikkatlice incele — her çubuk bir hikaye anlatıyor. Veri okuryazarlığı 21. yüzyılın temel becerisi! 📈',
    },
    'gate-chain': {
        welcome: 'Kalite Kapıları — öğrendiklerini derinleştirme zamanı! Neden ve Feynman testi seni bekliyor.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['feynman', 'basit', 'anlat', 'açıkla'],
                socratic: '10 yaşındaki bir çocuğa anlatıyormuş gibi düşün. Teknik kelimeler kullanmadan, günlük hayattan örneklerle açıklayabilir misin?',
                followUp: 'Feynman tekniği: Bir şeyi basitçe açıklayamıyorsanız, yeterince anlamıyorsunuz demektir. Bu test öğrenmenin en güçlü kanıtı!',
                card: { title: 'Feynman Tekniği', content: '1. Konuyu seç\n2. Bir çocuğa anlatır gibi yaz\n3. Takıldığın yerleri bul\n4. Sadeleştir ve tekrar anlat\n\nBu teknik bilgi kalıcılığını %35 artırır.' },
            },
        ],
        fallback: 'Çözümünü kendi kelimelerinle ifade et. "Neden?" sorusu düşünceyi derinleştirir, Feynman testi ise anlayışını sınar. ✍️',
    },
    'transfer-cases': {
        welcome: 'Transfer Vakaları — öğrendiklerini yeni problemlere uygulama zamanı! Kan bu farklı senaryolarda da işe yarar mı?',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['transfer', 'farklı', 'benzer', 'uygula'],
                socratic: 'Belediye kuyruğunda öğrendiğin optimizasyon mantığını burada da kullanabilir misin? İki problem arasındaki benzerlik ne?',
                followUp: 'Transfer öğrenmesi: Bir bağlamda öğrenileni farklı bağlamda uygulama. Bu, gerçek öğrenmenin en güçlü kanıtıdır!',
            },
        ],
        fallback: 'Bu vakaları çözerken belediye kuyruğundaki deneyimini kullan. Aynı mantık, farklı alan — işte transfer! 🔄',
    },
    'rubric-radar': {
        welcome: 'Rubrik Radar — becerilerinin haritası! 5 boyutta ne kadar ilerlediğini görebilirsin.',
        proactiveMessages: [],
        responses: [],
        fallback: 'Bu radar 5 temel becerini gösteriyor. Her interaktif bölümü tamamladıkça puanların artar. 📡',
    },
    'social-proof': {
        welcome: 'Lonca Sistemi — PUSULA\'nın öğrenme topluluğu! Aday → Kalfa → Usta → Ateşleyen yolculuğu.',
        proactiveMessages: [],
        responses: [
            {
                keywords: ['lonca', 'kalfa', 'usta', 'ateşleyen'],
                socratic: 'Lonca sistemi, öğrenmenin bireysel değil topluluk merkezli olduğu fikrine dayanır. Sence neden bir "Usta" yeni öğrencilere mentor olabilir?',
                followUp: 'Araştırmalar gösteriyor ki öğretmek, öğrenmenin en etkili yolu! Usta\'lar mentörlük yaparken kendi bilgilerini de pekiştirirler.',
            },
        ],
        fallback: 'Lonca sistemi, her öğrencinin hem öğrenci hem de mentor olabileceği bir topluluk modeli. 🎓',
    },
    'certificate': {
        welcome: 'Tebrikler! 🎉 Bu yolculukta veri analizi, koşullu düşünme, problem çözme ve transfer becerilerini geliştirdin.',
        proactiveMessages: [],
        responses: [],
        fallback: 'Sertifikanı indirebilir veya paylaşabilirsin. Bu sadece bir başlangıç — Dijital Gençlik Merkezi\'nde tam program 8 hafta! 🏆',
    },
    'snapshot-cta': {
        welcome: 'PUSULA deneyimini tamamladın! Bu modeli dijital gençlik merkezlerinde uygulamak için hazırız.',
        proactiveMessages: [],
        responses: [],
        fallback: 'Pilot proje hakkında daha fazla bilgi almak için "Pilot Projeyi Başlatalım" butonuna tıklayabilirsin. 📞',
    },
};

/* ── Component ── */
export default function PusulaMentor() {
    const { state } = usePusula();
    const [isOpen, setIsOpen] = useState(false);
    const [messages, setMessages] = useState<MentorMessage[]>([]);
    const [input, setInput] = useState('');
    const [hasUnread, setHasUnread] = useState(false);
    const [lastSection, setLastSection] = useState('hero');
    const [proactiveSent, setProactiveSent] = useState<Set<string>>(new Set());
    const messagesEndRef = useRef<HTMLDivElement>(null);
    const inputRef = useRef<HTMLInputElement>(null);

    // Determine current section from state
    const currentSection = useMemo(() => {
        const sections = [
            'hero', 'onboarding-vignette', 'kivilcim-gate', 'warmup-lab', 'bot-arena', 'quick-decision', 'meridyen',
            'codelab-main', 'data-interpret', 'gate-chain', 'transfer-cases', 'rubric-radar',
            'social-proof', 'certificate', 'snapshot-cta',
        ];
        return sections[state.currentSection] || 'hero';
    }, [state.currentSection]);

    // Send welcome message when section changes
    useEffect(() => {
        if (currentSection !== lastSection) {
            setLastSection(currentSection);
            const config = MENTOR_DB[currentSection];
            if (config) {
                addMentorMessage(config.welcome);
            }
        }
    }, [currentSection, lastSection]);

    // Auto-scroll to bottom
    useEffect(() => {
        messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
    }, [messages]);

    // Focus input when panel opens
    useEffect(() => {
        if (isOpen) {
            setHasUnread(false);
            setTimeout(() => inputRef.current?.focus(), 300);
        }
    }, [isOpen]);

    const addMentorMessage = useCallback((text: string, card?: { title: string; content: string }) => {
        const msg: MentorMessage = {
            id: `m-${Date.now()}-${Math.random().toString(36).slice(2, 6)}`,
            role: 'mentor',
            text,
            card,
            timestamp: Date.now(),
        };
        setMessages(prev => [...prev, msg]);
        if (!isOpen) setHasUnread(true);
    }, [isOpen]);

    // Trigger proactive messages based on state changes
    useEffect(() => {
        const config = MENTOR_DB[currentSection];
        if (!config) return;

        // WarmupLab error triggers
        if (currentSection === 'warmup-lab' && state.warmupCompleted === false) {
            // Check for welcome (first visit)
        }
    }, [state, currentSection, proactiveSent]);

    // Public method to trigger proactive messages from other components
    useEffect(() => {
        const handler = (e: CustomEvent) => {
            const { section, trigger } = e.detail;
            const key = `${section}-${trigger}`;
            if (proactiveSent.has(key)) return;

            const config = MENTOR_DB[section];
            if (!config) return;

            const proactive = config.proactiveMessages.find(p => p.trigger === trigger);
            if (proactive) {
                setProactiveSent(prev => new Set(prev).add(key));
                addMentorMessage(proactive.message, proactive.card);
            }
        };

        window.addEventListener('pusula-mentor-trigger' as any, handler as any);
        return () => window.removeEventListener('pusula-mentor-trigger' as any, handler as any);
    }, [proactiveSent, addMentorMessage]);

    const handleSend = useCallback(() => {
        const trimmed = input.trim();
        if (!trimmed) return;

        // Add user message
        const userMsg: MentorMessage = {
            id: `u-${Date.now()}`,
            role: 'user',
            text: trimmed,
            timestamp: Date.now(),
        };
        setMessages(prev => [...prev, userMsg]);
        setInput('');

        // Find response
        const config = MENTOR_DB[currentSection];
        if (!config) return;

        const lower = trimmed.toLowerCase();
        const match = config.responses.find(r =>
            r.keywords.some(kw => lower.includes(kw))
        );

        // Simulate typing delay
        setTimeout(() => {
            if (match) {
                addMentorMessage(match.socratic, match.card);
                // Send follow-up after another delay
                setTimeout(() => {
                    addMentorMessage(match.followUp);
                }, 2500);
            } else {
                addMentorMessage(config.fallback);
            }
        }, 800);
    }, [input, currentSection, addMentorMessage]);

    const handleKeyDown = useCallback((e: React.KeyboardEvent) => {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault();
            handleSend();
        }
    }, [handleSend]);

    return (
        <>
            {/* Floating Action Button */}
            <button
                className={`mentor-fab ${hasUnread ? 'mentor-fab--unread' : ''}`}
                onClick={() => setIsOpen(!isOpen)}
                aria-label="PUSULA Mentor'ü aç"
                title="PUSULA Mentor"
            >
                {isOpen ? (
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                        <line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" />
                    </svg>
                ) : (
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round">
                        <path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .963 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.963 0z" fill="currentColor" opacity="0.9" />
                        <path d="M20 3v4" /><path d="M22 5h-4" />
                    </svg>
                )}
                {hasUnread && <span className="mentor-fab__badge" />}
            </button>

            {/* Chat Panel */}
            <div className={`mentor-panel ${isOpen ? 'mentor-panel--open' : ''}`}>
                {/* Header */}
                <div className="mentor-panel__header">
                    <div className="mentor-panel__header-left">
                        <div className="mentor-panel__avatar">
                            <svg viewBox="0 0 32 32" fill="none">
                                <circle cx="16" cy="16" r="14" fill="var(--accent-cyan-dim)" stroke="var(--accent-cyan)" strokeWidth="1.5" />
                                <circle cx="16" cy="16" r="8" stroke="var(--accent-cyan)" strokeWidth="1" opacity="0.5" />
                                <polygon points="16,6 17.5,14.5 16,16 14.5,14.5" fill="var(--accent-cyan)" />
                                <polygon points="16,26 17.5,17.5 16,16 14.5,17.5" fill="var(--accent-rose)" opacity="0.6" />
                                <circle cx="16" cy="16" r="2" fill="var(--accent-cyan)" />
                            </svg>
                        </div>
                        <div>
                            <div className="mentor-panel__title">PUSULA Mentor</div>
                            <div className="mentor-panel__status">
                                <span className="mentor-panel__status-dot" />
                                Sokratik AI Rehber
                            </div>
                        </div>
                    </div>
                    <button className="mentor-panel__close" onClick={() => setIsOpen(false)} aria-label="Kapat">
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                            <polyline points="6 9 12 15 18 9" />
                        </svg>
                    </button>
                </div>

                {/* Messages */}
                <div className="mentor-panel__messages">
                    {messages.length === 0 && (
                        <div className="mentor-panel__empty">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="var(--accent-cyan)" strokeWidth="1" strokeLinecap="round" strokeLinejoin="round" opacity="0.3">
                                <path d="M12 2C6.48 2 2 6.03 2 11c0 2.58 1.2 4.89 3.09 6.49L4 22l4.71-2.35C9.77 19.88 10.86 20 12 20c5.52 0 10-4.03 10-9S17.52 2 12 2z" />
                            </svg>
                            <p>Merhaba! 👋 Bir soru sor veya yardım iste.</p>
                        </div>
                    )}

                    {messages.map(msg => (
                        <div key={msg.id} className={`mentor-msg mentor-msg--${msg.role}`}>
                            {msg.role === 'mentor' && (
                                <div className="mentor-msg__avatar">
                                    <svg viewBox="0 0 24 24" fill="none">
                                        <circle cx="12" cy="12" r="10" fill="var(--accent-cyan-dim)" stroke="var(--accent-cyan)" strokeWidth="1" />
                                        <polygon points="12,5 13,11 12,12 11,11" fill="var(--accent-cyan)" />
                                        <circle cx="12" cy="12" r="1.5" fill="var(--accent-cyan)" />
                                    </svg>
                                </div>
                            )}
                            <div className="mentor-msg__bubble">
                                <p>{msg.text}</p>
                                {msg.card && (
                                    <div className="mentor-msg__card">
                                        <div className="mentor-msg__card-title">
                                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--accent-amber)" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
                                                <circle cx="12" cy="12" r="10" /><line x1="12" y1="16" x2="12" y2="12" /><line x1="12" y1="8" x2="12.01" y2="8" />
                                            </svg>
                                            {msg.card.title}
                                        </div>
                                        <p className="mentor-msg__card-content">{msg.card.content}</p>
                                    </div>
                                )}
                            </div>
                        </div>
                    ))}
                    <div ref={messagesEndRef} />
                </div>

                {/* Input */}
                <div className="mentor-panel__input">
                    <input
                        ref={inputRef}
                        type="text"
                        placeholder="Soru sor..."
                        value={input}
                        onChange={e => setInput(e.target.value)}
                        onKeyDown={handleKeyDown}
                    />
                    <button
                        className="mentor-panel__send"
                        onClick={handleSend}
                        disabled={!input.trim()}
                        aria-label="Gönder"
                    >
                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                            <line x1="22" y1="2" x2="11" y2="13" /><polygon points="22 2 15 22 11 13 2 9 22 2" />
                        </svg>
                    </button>
                </div>
            </div>
        </>
    );
}
