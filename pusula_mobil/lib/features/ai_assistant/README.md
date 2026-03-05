# AI Assistant Feature

PUSULA uygulamasına entegre edilmiş Gemini AI tabanlı öğrenme asistanı.

## Özellikler

- 🤖 **Context-Aware AI**: Ders içeriğini anlayarak yardım eder
- 💬 **Chat Interface**: Sohbet tarzı etkileşim
- 📚 **Öğrenme Desteği**: Python, SQL konularında yardım
- 🎯 **Proje Rehberliği**: Hangi becerilere ihtiyaç var açıklar
- 🇹🇷 **Türkçe**: Tamamen Türkçe konuşur

## Kurulum

### 1. Gemini API Key Alma

1. [Google AI Studio](https://makersuite.google.com/app/apikey)'ya git
2. "Get API Key" butonuna tıkla
3. API key'ini kopyala

### 2. API Key'i Ekleme

`lib/features/ai_assistant/providers/ai_assistant_provider.dart` dosyasını aç ve API key'ini ekle:

```dart
// TODO: API key'i environment variable'dan al
const String _geminiApiKey = 'YOUR_GEMINI_API_KEY_HERE'; // Buraya API key'ini yapıştır
```

**ÖNEMLİ:** Production'da API key'i environment variable olarak kullan!

### 3. Test Et

```bash
flutter run
```

## Kullanım

### Ana Ekrandan

Sağ alttaki yeşil bot ikonuna tıkla → AI chat açılır

### Ders Ekranından

Ders başlığının yanındaki bot ikonuna tıkla → Ders içeriği context olarak eklenir

## Örnek Sorular

### Öğrenme Soruları
- "Python'da print() fonksiyonu nasıl kullanılır?"
- "SQL'de WHERE komutu ne işe yarar?"
- "Değişken nedir?"
- "Bu kod challenge'ı çözemiyorum, yardım eder misin?"

### Proje Soruları
- "Veri analizi projesi için hangi becerilere ihtiyacım var?"
- "Python öğrenmek için nereden başlamalıyım?"
- "SQL ne işe yarar?"

### PUSULA Soruları
- "PUSULA nedir?"
- "Seviye sistemi nasıl çalışır?"
- "XP nasıl kazanılır?"
- "Çırak seviyesinden Kalfa'ya nasıl geçerim?"

## Mimari

```
ai_assistant/
├── models/
│   └── chat_message.dart          # Chat mesaj modeli (Freezed)
├── providers/
│   └── ai_assistant_provider.dart # Riverpod state management
├── screens/
│   └── ai_chat_screen.dart        # Chat UI
├── services/
│   └── gemini_service.dart        # Gemini API integration
└── README.md                      # Bu dosya
```

## System Prompt

AI asistanı şu bilgilere sahip:

- PUSULA'nın ne olduğu
- 45 DİGEM merkezi
- Seviye sistemi (Çırak → Kalfa → Usta → Büyük Usta)
- 6 beceri yolu
- Python ve SQL ders içerikleri
- Proje tipleri (Belediye, KOBİ, Startup, Gönüllü)

## Context System

Ders ekranından AI'ya sorulduğunda:
- Ders başlığı
- Mevcut bölüm içeriği (markdown/quiz/challenge)
- Kod örnekleri

Otomatik olarak AI'ya gönderilir.

## Gelecek Geliştirmeler

- [ ] Ses tanıma (speech-to-text)
- [ ] Kod çalıştırma önerileri
- [ ] Kişiselleştirilmiş öğrenme yolu
- [ ] Chat geçmişi kaydetme
- [ ] Favori cevaplar
- [ ] Çoklu dil desteği

## Güvenlik

⚠️ **ÖNEMLİ**: API key'i asla Git'e commit etme!

Production için:
1. `.env` dosyası kullan
2. `flutter_dotenv` paketi ekle
3. API key'i environment variable'dan oku

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiKey = dotenv.env['GEMINI_API_KEY']!;
```

## Lisans

Bu feature PUSULA projesinin bir parçasıdır.
