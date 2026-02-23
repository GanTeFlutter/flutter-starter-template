# Flutter Projelerine EasyLocalization ile Çoklu Dil Desteği Ekleme Raporu

Bu rapor, mevcut bir Flutter projesine `easy_localization` paketi ile TR + EN dil desteği eklenmesi için adım adım rehberdir. Çalışan bir referans projeden birebir çıkarılmıştır.

---

## 1. Bağımlılık

`pubspec.yaml` dosyasına ekle:

```yaml
dependencies:
  easy_localization: ^3.0.1
```

Ardından:

```bash
flutter pub get
```

---

## 2. Çeviri Dosyaları

`assets/translations/` klasörü oluştur ve içine iki JSON dosyası ekle.

### `assets/translations/tr.json`

```json
{
  "general": {
    "appName": "Uygulama Adı",
    "loading": "Yükleniyor...",
    "retry": "Tekrar Dene"
  },
  "error": {
    "title": "Bir Hata Oluştu"
  },
  "home": {
    "title": "Ana Sayfa"
  },
  "settings": {
    "title": "Ayarlar",
    "language": "Dil"
  }
}
```

### `assets/translations/en.json`

```json
{
  "general": {
    "appName": "App Name",
    "loading": "Loading...",
    "retry": "Retry"
  },
  "error": {
    "title": "An Error Occurred"
  },
  "home": {
    "title": "Home"
  },
  "settings": {
    "title": "Settings",
    "language": "Language"
  }
}
```

**Kurallar:**
- Her iki JSON'un key yapısı birebir aynı olmalı
- Key'ler nested yapıda: `"feature": { "key": "value" }`
- Yeni bir ekran/özellik eklerken o ekranın string'lerini yeni bir üst key altına grupla

### Asset kaydı

`pubspec.yaml` → `flutter:` → `assets:` altına ekle:

```yaml
flutter:
  assets:
    - assets/translations/
```

---

## 3. Locale Yapılandırma Dosyası

Projenin uygun bir yerine (önerilen: `lib/product/init/language/`) bir `core_localize.dart` dosyası oluştur:

```dart
import 'package:flutter/material.dart';

enum AppLocale {
  tr(Locale('tr', 'TR')),
  en(Locale('en', 'US'));

  const AppLocale(this.locale);
  final Locale locale;
}

@immutable
class CoreLocalize {
  const CoreLocalize();

  /// JSON dosyalarının bulunduğu klasör
  static const initialPath = 'assets/translations';

  /// Uygulama ilk açıldığında kullanılacak dil
  static final startLocale = AppLocale.tr.locale;

  /// Desteklenen diller listesi
  static final List<Locale> supportedItems =
      AppLocale.values.map((e) => e.locale).toList();
}
```

**Not:** Yeni bir dil eklemek istersen sadece `AppLocale` enum'una yeni bir değer eklemen yeterli.

---

## 4. Type-Safe Key Dosyası Üretme

JSON key'lerine compile-time güvenli erişim sağlamak için `locale_keys.g.dart` dosyası üretilir.

**Komutu çalıştır:**

```bash
flutter pub run easy_localization:generate \
  -O lib/product/init/language \
  -f keys \
  -o locale_keys.g.dart \
  --source-dir assets/translations
```

**Parametreler:**
- `-O` → Çıktı klasörü (generated dosya nereye yazılsın)
- `-f keys` → Format: sadece key sabitleri üret
- `-o` → Çıktı dosya adı
- `--source-dir` → JSON dosyalarının bulunduğu klasör

Bu komut şuna benzer bir dosya üretir:

```dart
// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: constant_identifier_names

abstract class LocaleKeys {
  static const general_appName = 'general.appName';
  static const general_loading = 'general.loading';
  static const general_retry = 'general.retry';
  static const error_title = 'error.title';
  static const home_title = 'home.title';
  static const settings_title = 'settings.title';
  static const settings_language = 'settings.language';
}
```

**Not:** JSON'daki nested key'ler alt çizgi ile birleştirilir: `general.appName` → `LocaleKeys.general_appName`

**JSON'a her yeni key ekledikten sonra bu komutu tekrar çalıştır.**

---

## 5. Uygulama Başlatma (Initialization)

Uygulamanın `main()` fonksiyonunda veya init sınıfında EasyLocalization'ı başlat:

```dart
await EasyLocalization.ensureInitialized();
```

Bu satır `WidgetsFlutterBinding.ensureInitialized()` satırından **sonra**, `runApp()` satırından **önce** çağrılmalı.

Tam `main.dart` örneği:

```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Proje import'ları
import 'product/init/language/core_localize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // ... diğer init işlemleri (DI, cache vb.)

  runApp(
    EasyLocalization(
      supportedLocales: CoreLocalize.supportedItems,
      path: CoreLocalize.initialPath,
      startLocale: CoreLocalize.startLocale,
      useOnlyLangCode: true,
      child: const MyApp(), // <-- Senin ana uygulama widget'ın
    ),
  );
}
```

**Dikkat:** `EasyLocalization` widget'ı `runApp()` içinde en dıştaki widget olmalı. Tüm uygulamayı sarmalıyor.

`useOnlyLangCode: true` → JSON dosya isimleri `tr.json`, `en.json` şeklinde (ülke kodu olmadan) eşleşir.

---

## 6. MaterialApp Entegrasyonu

`MaterialApp` (veya `MaterialApp.router`) widget'ına şu 3 property eklenmeli:

```dart
MaterialApp(
  // ... diğer property'ler

  localizationsDelegates: context.localizationDelegates,
  supportedLocales: context.supportedLocales,
  locale: context.locale,
);
```

veya `MaterialApp.router` kullanıyorsan:

```dart
MaterialApp.router(
  // ... diğer property'ler

  localizationsDelegates: context.localizationDelegates,
  supportedLocales: context.supportedLocales,
  locale: context.locale,
  routerConfig: yourRouter,
);
```

Bu 3 satır olmadan dil desteği çalışmaz. `context.localizationDelegates`, `context.supportedLocales` ve `context.locale` EasyLocalization'ın context extension'larıdır.

---

## 7. Widget'larda Kullanım

### String gösterme

```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:<paket_adi>/product/init/language/locale_keys.g.dart';

// Widget içinde:
Text(LocaleKeys.home_title.tr())
Text(LocaleKeys.settings_language.tr())
```

**Pattern:** `LocaleKeys.<key>.tr()` — bu kadar.

### Dil değiştirme

```dart
// Türkçe'ye geç
context.setLocale(const Locale('tr', 'TR'));

// İngilizce'ye geç
context.setLocale(const Locale('en', 'US'));
```

### Mevcut dili kontrol etme

```dart
final isTurkish = context.locale.languageCode == 'tr';
```

### Dil değişiminde rebuild tetikleme

Eğer bir Stateless widget dil değiştiğinde yeniden çizilmiyorsa, `build` metodunun başına şunu ekle:

```dart
@override
Widget build(BuildContext context) {
  context.locale; // Bu satır rebuild'i tetikler
  // ...
}
```

---

## 8. Dil Değiştirme UI Örneği (Settings sayfası için)

### Basit ListTile yaklaşımı

```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isTurkish = context.locale.languageCode == 'tr';

    return ListTile(
      leading: Icon(Icons.language, color: cs.onSurfaceVariant),
      title: Text(LocaleKeys.settings_language.tr()),
      trailing: Text(
        isTurkish ? 'Türkçe' : 'English',
        style: TextStyle(color: cs.onSurfaceVariant),
      ),
      onTap: () {
        if (isTurkish) {
          context.setLocale(const Locale('en', 'US'));
        } else {
          context.setLocale(const Locale('tr', 'TR'));
        }
      },
    );
  }
}
```

### Switch yaklaşımı (Onboarding vb. için)

```dart
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final isTurkish = context.locale.languageCode == 'tr';
    final cs = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'TR',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: isTurkish ? cs.primary : cs.onSurfaceVariant,
                fontWeight: isTurkish ? FontWeight.bold : FontWeight.normal,
              ),
        ),
        const SizedBox(width: 8),
        Switch.adaptive(
          value: !isTurkish,
          onChanged: (_) {
            if (isTurkish) {
              context.setLocale(const Locale('en', 'US'));
            } else {
              context.setLocale(const Locale('tr', 'TR'));
            }
          },
        ),
        const SizedBox(width: 8),
        Text(
          'EN',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: !isTurkish ? cs.primary : cs.onSurfaceVariant,
                fontWeight: !isTurkish ? FontWeight.bold : FontWeight.normal,
              ),
        ),
      ],
    );
  }
}
```

---

## 9. Lint Kuralları

Generated dosyayı lint'ten hariç tutmak için `analysis_options.yaml`'a ekle:

```yaml
analyzer:
  exclude:
    - lib/product/init/language/   # locale_keys.g.dart burada
```

---

## 10. Dosya Yapısı Özeti

```
proje/
├── assets/
│   └── translations/
│       ├── tr.json                    # Türkçe çeviriler
│       └── en.json                    # İngilizce çeviriler
├── lib/
│   └── product/
│       └── init/
│           └── language/
│               ├── core_localize.dart     # Locale config (desteklenen diller, başlangıç dili)
│               └── locale_keys.g.dart     # Generated — type-safe key sabitleri
├── pubspec.yaml                       # easy_localization dependency + asset kaydı
└── analysis_options.yaml              # Generated dosya exclude
```

---

## 11. Yeni String Ekleme Checklist

1. `assets/translations/tr.json`'a key + Türkçe değer ekle
2. `assets/translations/en.json`'a aynı key + İngilizce değer ekle
3. Generate komutunu çalıştır:
   ```bash
   flutter pub run easy_localization:generate \
     -O lib/product/init/language \
     -f keys \
     -o locale_keys.g.dart \
     --source-dir assets/translations
   ```
4. Widget'ta kullan: `LocaleKeys.yeni_key.tr()`

---

## 12. Mevcut Projeye Entegrasyon Adımları (Sıralı)

Eğer mevcut bir projede hiç dil desteği yoksa, sırasıyla şunları yap:

1. **`pubspec.yaml`** → `easy_localization: ^3.0.1` ekle, `flutter pub get`
2. **`pubspec.yaml`** → `flutter: assets:` altına `- assets/translations/` ekle
3. **`assets/translations/`** → `tr.json` ve `en.json` oluştur, projedeki tüm hardcoded string'leri key-value olarak ekle
4. **`lib/.../language/core_localize.dart`** → Locale config dosyasını oluştur
5. **Generate** → `locale_keys.g.dart` üret (yukarıdaki komut)
6. **`main.dart`** → `EasyLocalization.ensureInitialized()` + `EasyLocalization()` wrapper ekle
7. **`MaterialApp`** → `localizationsDelegates`, `supportedLocales`, `locale` ekle
8. **Widget'lar** → Hardcoded string'leri `LocaleKeys.xxx.tr()` ile değiştir
9. **Dil değiştirme UI** → Settings sayfasına `LanguageTile` veya benzeri widget ekle
10. **`analysis_options.yaml`** → Generated dosyayı exclude et

---

## 13. Önemli Notlar

- **EasyLocalization kullanıcının dil tercihini otomatik olarak SharedPreferences'a kaydeder.** Ekstra bir cache/persistence işlemi yapmana gerek yok. Uygulama kapanıp açılınca son seçilen dil korunur.
- **`useOnlyLangCode: true`** parametresi sayesinde JSON dosya isimleri `tr.json` / `en.json` şeklinde. Bu parametre olmadan `tr-TR.json` bekler.
- **`context.locale`** erişimi rebuild tetikler — dil değiştiğinde tüm widget ağacı güncellenir.
- **Yeni dil eklemek için:** `AppLocale` enum'una yeni değer ekle + yeni JSON dosyası oluştur + generate komutunu çalıştır.
