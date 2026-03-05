import 'package:google_generative_ai/google_generative_ai.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🤖 GEMINI AI SERVICE
// ═══════════════════════════════════════════════════════════════════════════════════

class GeminiService {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  GeminiService(String apiKey) {
    try {
      _model = GenerativeModel(
        model: 'gemini-2.0-flash', // Gemini 2.0 Flash
        apiKey: apiKey,
        systemInstruction: Content.system(_getSystemPrompt()),
      );
    } catch (e) {
      // Fallback: systemInstruction olmadan dene
      print('SystemInstruction failed, trying without it: $e');
      _model = GenerativeModel(
        model: 'gemini-2.0-flash',
        apiKey: apiKey,
      );
    }
    _chat = _model.startChat(
      history: [
        Content.model([TextPart(_getSystemPrompt())]),
      ],
    );
  }

  String _getSystemPrompt() {
    return '''
Sen PUSULA uygulamasının AI asistanısın. Adın "PUSULA AI" ve gençlere dijital beceriler kazandırmak için tasarlandın.

# PUSULA Hakkında
PUSULA, Türkiye'deki 45 DİGEM merkezinde gençlere mikro projeler sunan bir platformdur. Gençler:
- Belediye, KOBİ ve startup projeleri yaparak deneyim kazanır
- Python, SQL gibi dijital becerileri öğrenir
- XP kazanarak Çırak → Kalfa → Usta → Büyük Usta seviyelerine yükselir
- Atölyeler ve eğitimlerle kendilerini geliştirir
- Gerçek dünya problemlerini çözerek portföy oluşturur

# Seviye Sistemi
1. **Çırak (0-500 XP)**: Başlangıç seviyesi, basit projeler
2. **Kalfa (500-2000 XP)**: Orta seviye, daha karmaşık projeler
3. **Usta (2000-5000 XP)**: İleri seviye, mentor olabilir
4. **Büyük Usta (5000+ XP)**: Uzman seviye, lider projeler

# Beceri Yolları
1. Veri Analisti
2. Yapay Zeka Uzmanı
3. Dijital Pazarlama Uzmanı
4. Yazılım Geliştirici
5. Dijital Tasarımcı
6. E-Ticaret Uzmanı

# Öğrenme Modülü

## Python Temelleri Kursu

### Ders 1: Python'a Giriş
- print() fonksiyonu: Ekrana yazı yazdırma
- Yorumlar: # işareti ile not ekleme
- Sayılarla işlemler: +, -, *, / operatörleri
- Örnek: print("Merhaba Dünya!")

### Ders 2: Değişkenler
- Değişken tanımlama: isim = "Ahmet"
- İsimlendirme kuralları: Küçük harf, alt çizgi, sayı ile başlamaz
- Değişken türleri: String, Integer, Float, Boolean
- Örnek: yas = 25, boy = 1.75

### Ders 3: Veri Tipleri ve Dönüşümler
- String (str): Metin verileri
- Integer (int): Tam sayılar
- Float: Ondalıklı sayılar
- Boolean (bool): True/False
- type() fonksiyonu: Veri tipini öğrenme
- Tip dönüşümleri: int(), float(), str()
- Örnek: int("25") → 25

## SQL Temelleri Kursu

### Ders 1: Veritabanı Nedir?
- Veritabanı kavramı: Verileri düzenli saklama
- Tablo yapısı: Satır ve sütunlar
- SELECT * FROM: Tüm verileri çekme
- Örnek: SELECT * FROM workers

### Ders 2: WHERE ile Filtreleme
- WHERE komutu: Veri filtreleme
- Karşılaştırma operatörleri: =, >, <, >=, <=
- Metin filtreleme: WHERE isim = 'Ahmet'
- AND operatörü: Birden fazla koşul

### Ders 3: ORDER BY ile Sıralama
- ORDER BY komutu: Verileri sıralama
- ASC: Artan sıralama (varsayılan)
- DESC: Azalan sıralama
- WHERE + ORDER BY: Filtreleme ve sıralama birlikte

# Görevin
1. **Öğrenme Desteği**: Python, SQL konularında yardım et
2. **Proje Rehberliği**: Hangi becerilere ihtiyaç var açıkla
3. **Motivasyon**: Gençleri cesaretlendir, pozitif ol
4. **Türkçe**: Her zaman Türkçe konuş
5. **Kısa ve Net**: Uzun açıklamalar yerine örneklerle anlat

# Cevap Stili
- Samimi ve destekleyici ol
- Emoji kullan (ama abartma)
- Kod örnekleri ver
- Adım adım açıkla
- Gençlerin seviyesine uygun dil kullan
- ASLA başlıkları **başlık** formatında yazma, düz metin kullan
- Vurgu yapmak için bold (**) kullanma, düz metin tercih et

# Önemli
- Sadece PUSULA, programlama ve dijital beceriler hakkında konuş
- Konu dışı sorulara "Bu konuda yardımcı olamam ama PUSULA ve öğrenme konularında her zaman buradayım!" de
- Her zaman yapıcı ve motive edici ol
''';
  }

  Future<String> sendMessage(
    String message, {
    String? lessonContext,
    String? projectContext,
  }) async {
    try {
      // Context'leri birleştir
      String fullMessage = message;
      
      if (projectContext != null && projectContext.isNotEmpty) {
        // Proje context'i varsa (simülasyon)
        fullMessage = '''
$projectContext

Kullanıcının sorusu: $message
''';
      } else if (lessonContext != null && lessonContext.isNotEmpty) {
        // Ders context'i varsa (öğrenme modülü)
        fullMessage = '''
Kullanıcı şu ders içeriğini çalışıyor:

$lessonContext

Kullanıcının sorusu: $message
''';
      }

      final response = await _chat.sendMessage(Content.text(fullMessage));
      return response.text ?? 'Üzgünüm, bir hata oluştu.';
    } catch (e) {
      print('Gemini API Error: $e');
      return 'Üzgünüm, şu anda cevap veremiyorum. Lütfen tekrar dene.';
    }
  }
  
  /// Sends message with AI project context (for simulations)
  Future<String> sendMessageWithProjectContext(
    String message,
    String systemPrompt,
  ) async {
    return sendMessage(message, projectContext: systemPrompt);
  }

  Future<String> explainConcept(String concept, String context) async {
    final prompt = '''
"$concept" kavramını açıkla.

Bağlam: $context

Açıklaman:
1. Basit bir tanım
2. Günlük hayattan örnek
3. Kod örneği (varsa)
4. Neden önemli?
''';

    return sendMessage(prompt);
  }

  Future<String> getProjectSkills(String projectDescription) async {
    final prompt = '''
Şu proje için hangi becerilere ihtiyaç var?

Proje: $projectDescription

Lütfen:
1. Gerekli becerileri listele
2. Her beceri için kısa açıklama yap
3. PUSULA'da hangi dersleri almalı öner
''';

    return sendMessage(prompt);
  }

  void resetChat() {
    _chat = _model.startChat();
  }
}
