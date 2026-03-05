import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════════
// 🎯 PUSULA CORE - TÜRKİYE'NİN DİJİTAL DNA'SI
// ═══════════════════════════════════════════════════════════════════════════════════

class PusulaCore {
  static const String tagline = "Türkiye'nin Dijital Köprüsü";
  
  // 45 DİGEM Gerçek Listesi - UNDP Resmi
  static const Map<String, String> digemCities = {
    'istanbul': 'İstanbul',
    'ankara': 'Ankara', 
    'izmir': 'İzmir',
    'bursa': 'Bursa',
    'antalya': 'Antalya',
    'adana': 'Adana',
    'gaziantep': 'Gaziantep',
    'konya': 'Konya',
    'sanliurfa': 'Şanlıurfa',
    'mersin': 'Mersin',
    'kayseri': 'Kayseri',
    'eskisehir': 'Eskişehir',
    'diyarbakir': 'Diyarbakır',
    'samsun': 'Samsun',
    'denizli': 'Denizli',
    'adapazari': 'Adapazarı',
    'malatya': 'Malatya',
    'kahramanmaras': 'K.Maraş',
    'erzurum': 'Erzurum',
    'van': 'Van',
    'batman': 'Batman',
    'elazig': 'Elazığ',
    'erzincan': 'Erzincan',
    'tokat': 'Tokat',
    'trabzon': 'Trabzon',
    'manisa': 'Manisa',
    'aydin': 'Aydın',
    'balikesir': 'Balıkesir',
    'tekirdag': 'Tekirdağ',
    'hatay': 'Hatay',
    'ordu': 'Ordu',
    'kocaeli': 'Kocaeli',
    'usak': 'Uşak',
    'afyon': 'Afyon',
    'isparta': 'Isparta',
    'giresun': 'Giresun',
    'zonguldak': 'Zonguldak',
    'corum': 'Çorum',
    'kastamonu': 'Kastamonu',
    'sinop': 'Sinop',
    'amasya': 'Amasya',
    'kirikkale': 'Kırıkkale',
    'nevsehir': 'Nevşehir',
    'kirsehir': 'Kırşehir',
    'yozgat': 'Yozgat',
    'karaman': 'Karaman',
  };
  
  // 6 Ana Beceri Yolu - LUCIDE ICONS İLE YENİLENMİŞ! 🎯
  static const Map<String, IconData> skillPaths = {
    'Veri Analisti': LucideIcons.chartBar,
    'Yapay Zeka Uzmanı': LucideIcons.brain,
    'Dijital Pazarlama': LucideIcons.megaphone,
    'Yazılım Uzmanı': LucideIcons.code,
    'Dijital Tasarımcı': LucideIcons.palette,
    'E-Ticaret Uzmanı': LucideIcons.shoppingCart,
  };

  // SELAMLAMA SISTEMI 🕒
  static String getTimeBasedGreeting() {
    return 'Merhaba';
  }
}
