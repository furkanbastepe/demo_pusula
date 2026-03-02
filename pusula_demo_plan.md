# PUSULA Codex V6 — KIVILCIM-First, Guided-Scroll, Partner-Grade

## Kısa Özet
Bu sürüm, hem V4’teki kritik boşlukları hem örnek HTML’deki bağlam uyumsuzluklarını kapatır.
Hedef: 30+ karar alıcı, ilk 90 saniyede "vay be", 180 saniyede "bu pilotlanır" sonucuna gelsin.

Karar kilitleri:
1. Autoplay yok, guided scroll storytelling var.
2. Tema tam koyu, ancak kurumsal tonu koruyan tipografi/mikrocopy disiplini var.
3. Sosyal katman canlı fake panel yerine mimari kanıt kartı olarak sunulur.
4. Trafik lambası ana demo değil; 45 sn warm-up sonrası ana belediye kuyruk vakasına geçilir.
5. KIVILCIM kalite gate’i sert değildir; minimum 2 cümle yeterlidir.

## V6 Ürün İlkeleri
1. İlk etkileşim tıklama değil düşünme.
2. Her panel önceki panelin kanıtını taşır.
3. Teknik olmayan kullanıcı kod yazmadan değer önerisini tamamlar.
4. Kod modu ileri katmandır.
5. Her iddia Source Claim seviyesi ile snapshot’a iner.
6. Sosyal öğrenme sahte canlı veriyle değil sistem tasarımı kanıtı ile gösterilir.

## Nihai Deneyim Akışı (3 Katman)
### Katman 1 (0-90 sn)
1. Hero + 20 sn Deniz mikro-vinyet.
2. KIVILCIM kartı: araçsız Türkçe çözüm.
3. 45 sn trafik lambası warm-up.
4. Asıl vaka geçişi: belediye kuyruğu.

### Katman 2 (90-180 sn)
1. Meridyen Anı: metin -> şablon eşleştirme -> model değişkenleri.
2. Tahmin vs gerçek farkı.
3. Why/Feynman Gate zorunluluğu.
4. Ana KPI delta + kuyruk görselleştirmesi.

### Katman 3 (180+ sn)
1. Hızlı transfer vakaları (katılım + esnaf).
2. Rubric + mentor radar.
3. Sosyal öğrenme mimari kanıtı.
4. Operasyon kokpiti + snapshot export.

## KIVILCIM ve Meridyen Tasarımı
### KIVILCIM Gate
1. En az 2 cümle zorunlu.
2. Sert kalite gate yok.
3. Minimum içerik geçişi.
4. Başarısız giriş de öğretici kabul edilir.

### Meridyen Anı
1. Serbest metin alınır.
2. Ön tanımlı niyet şablon havuzu skorlanır.
3. Düşük güven skorunda 3 fallback düşünce kartı sunulur.
4. Seçim sonrası değişken eşleşmesi gösterilir:
   - kapasiteyi artır -> acik_gise +
   - işlem hızlandır -> islem_suresi_dk -
   - yoğun saat yönetimi -> gelen_musteri_saat / oncelikli_oran
5. Çıktı metni: Az önce yazdığın düşünce model kararına dönüştü.

## Bilgi Mimarisi (Kesin ID)
1. #hero
2. #onboarding-vignette
3. #kivilcim-gate
4. #warmup-lab
5. #meridyen
6. #codelab-main
7. #gate-chain
8. #transfer-cases
9. #rubric-radar
10. #social-proof-architecture
11. #ops-cockpit
12. #snapshot-cta
13. #data-note

## Teknik Mimari
1. Worker + Pyodide + AST doğrulama korunur.
2. Monaco unlockAdvancedLab sonrası görünür.
3. No-code müdahale paneli varsayılan.
4. State machine:
   - intro
   - kivilcim_answered
   - meridyen_mapped
   - main_intervention
   - why_pending | feynman_pending
   - transfer_done
   - decision_ready

## Public API
Korunacak:
1. init
2. runLabCode
3. resetLab
4. setCase
5. getSnapshot
6. setStage
7. runQuickCase
8. exportInvestorSnapshot
9. setGateState

Eklenecek:
1. setMode(mode)
2. submitKivilcim(text)
3. mapMeridyen(payload)
4. unlockAdvancedLab()
5. recordWarmupCompletion()
6. setSourceClaim(claimId, level)

## Kaynak ve Güven Stratejisi
1. KPI kartlarından Demo Verisi chip kaldırılır.
2. Her KPI için info panelde Kaynak Seviyesi gösterilir.
3. Snapshot JSON içinde claims[] zorunludur:
   - id
   - text
   - level
   - sourceUrl
   - checkedAt
4. Sayfa altı Veri Notu sabit kalır.

## Sosyal Öğrenme Sunumu
1. Lonca/Ateşleme nasıl işler mimari paneli.
2. Haftalık ritim görselleştirmesi:
   - Pazartesi: KIVILCIM
   - Çarşamba: Ateşleme
   - Cuma: Öğretme kanıtı
3. Pilot metrikleri:
   - öğretme puanı
   - ateşleme katılımı
   - kalfa-aday eşleşme oranı

## Oyunlaştırma
1. Öğrenci HUD:
   - streak
   - öğretme puanı
   - Öğrettim rozeti
2. Kutlama:
   - konfeti yok
   - achievement glow + radar animasyonu
3. Leaderboard ana vitrinde yok.

## Erişilebilirlik
1. Kullanıcı kontrolü korunur.
2. Klavye ile kritik aksiyonlar erişilebilir.
3. prefers-reduced-motion desteklenir.
4. Otomatik ses yok.

## Test Senaryoları
1. KIVILCIM olmadan ana müdahale açılamaz.
2. KIVILCIM en az 2 cümle ile geçer.
3. Meridyen düşük güvende 3 kart fallback verir.
4. Warm-up sonrası ana vaka geçişi net görünür.
5. No-code KPI delta doğru hesaplanır.
6. Kod yolu AST yasakları doğru çalışır.
7. Why gate kilidi doğru çalışır.
8. Feynman olmadan karar aşaması açılmaz.
9. Transfer vakaları rubric skorunu etkiler.
10. Sosyal panel fake canlı veri içermez.
11. Snapshot claims[] doludur.
12. KPI kartları demo chip’sizdir.
13. 375/768/1024/1440 taşma yoktur.
14. Konsolda kritik hata yoktur.
15. İlk etki <= 90 sn.

## Varsayımlar
1. Tek HTML + CDN mimarisi korunur.
2. Backend yok; sosyal akış sistem tasarımı kanıtı olarak sunulur.
3. Tam koyu tema kullanılır.
4. Autoplay yok.
5. Ses yok.
6. Konfeti yok.
7. Trafik lambası warm-up olarak kalır.
