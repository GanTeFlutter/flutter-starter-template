# Theme System

## Mimari

Theme sistemi 3 ana bileşenden oluşur:

1. **Renk Varyantı** (`AppThemeVariant`) — 8 farklı renk paleti, `ColorScheme.fromSeed()` ile Material 3 uyumlu
2. **Tema Modu** (`ThemeMode`) — System / Light / Dark seçimi
3. **Semantik Renkler** (`AppThemeColors`) — Variant'tan bağımsız, dark/light'a duyarlı sabit renkler

Her iki kullanıcı tercihi (variant + mode) `SharedCache` ile string key olarak persist edilir. Enum sırası değişse bile eski kullanıcıların tercihleri korunur.

## State Yönetimi

**`ThemeCubit`** → `ThemeState` emit eder.

`ThemeState` iki alan içerir:
- `variant` → `AppThemeVariant` (hangi renk paleti)
- `themeMode` → `ThemeMode` (system/light/dark)

```dart
// Variant değiştir
context.read<ThemeCubit>().setVariant(AppThemeVariant.blue);

// Tema modu değiştir
context.read<ThemeCubit>().setThemeMode(ThemeMode.dark);

// State oku
final state = context.watch<ThemeCubit>().state;
state.variant;   // AppThemeVariant
state.themeMode; // ThemeMode
```

## Persistence

| Veri | SharedKeys | Tip | Örnek |
|------|-----------|-----|-------|
| Renk varyantı | `SharedKeys.themeVariant` | `String` (variant key) | `"purple"`, `"black"` |
| Tema modu | `SharedKeys.theme` | `String` (ThemeMode.name) | `"system"`, `"light"`, `"dark"` |

Varsayılan değerler:
- Variant: `AppThemeVariant.purple`
- ThemeMode: `ThemeMode.system`

## MaterialApp Entegrasyonu

`main.dart`'ta ThemeCubit watch edilerek 3 property set edilir:

```dart
final themeState = context.watch<ThemeCubit>().state;
MaterialApp.router(
  themeMode: themeState.themeMode,
  darkTheme: AppTheme.darkTheme(themeState.variant),
  theme: AppTheme.lightTheme(themeState.variant),
);
```

## Dosya Yapısı

```
lib/product/theme/
├── THEME.md                          # Bu dosya
├── app_theme_variant.dart            # Enum — 8 renk paleti
├── app_theme_colors.dart             # ThemeExtension — dark/light duyarlı semantik renkler + context.appColors extension
├── theme.dart                        # AppTheme giriş noktası (part files)
├── base/
│   ├── color_schemes.dart            # Variant → ColorScheme helper'ları
│   ├── dark_theme.dart               # Dark ThemeData builder (AppThemeColors.dark)
│   └── light_theme.dart              # Light ThemeData builder (AppThemeColors.light)
├── parts/
│   ├── appbar_theme.dart             # AppBar teması (transparent, centered)
│   ├── button_theme.dart             # Elevated, Filled, Outlined buton temaları
│   ├── card_theme.dart               # Card teması (light + dark)
│   ├── chip_theme.dart               # Chip teması
│   ├── input_theme.dart              # Input decoration teması
│   ├── slider_theme.dart             # Slider teması
│   └── text_theme.dart               # Text teması (Poppins display + Inter body)
├── state/
│   ├── theme_cubit.dart              # ThemeCubit — variant + themeMode yönetimi
│   └── theme_state.dart              # ThemeState — immutable state sınıfı
└── widget/
    ├── theme_selection_dialog.dart    # Tema seçim dialog'u (variant grid + mode seçici)
    └── theme_setting_tile.dart       # Ayarlarda tema tile'ı
```

## Mevcut Varyantlar

| Variant | Renk | Hex |
|---------|------|-----|
| Purple | Mor | `#7C4DFF` |
| Blue | Mavi | `#2196F3` |
| Green | Yeşil | `#4CAF50` |
| Orange | Turuncu | `#FF9800` |
| Red | Kırmızı | `#E91E63` |
| Black | Siyah | `#212121` |
| Teal | Turkuaz | `#009688` |
| Indigo | İndigo | `#3F51B5` |

## Tema Modu Seçenekleri

| Mod | Açıklama |
|-----|----------|
| System | Cihazın dark/light ayarını takip eder |
| Light | Her zaman açık tema |
| Dark | Her zaman koyu tema |

## Typography (TextTheme)

Projede inline `TextStyle(fontSize: ...)` kullanılmaz. Tüm metin stilleri `text_theme.dart`'tan gelir ve `Theme.of(context).textTheme.*` ile erişilir.

| Stil | Font | Boyut | Ağırlık | Kullanım |
|------|------|-------|---------|----------|
| `displayLarge` | Poppins | 57 | w400 | Hero başlıklar |
| `displayMedium` | Poppins | 45 | w400 | Büyük başlıklar |
| `displaySmall` | Poppins | 36 | w400 | Orta başlıklar |
| `headlineLarge` | Poppins | 32 | w400 | Sayfa başlıkları |
| `headlineMedium` | Poppins | 28 | w400 | Bölüm başlıkları |
| `headlineSmall` | Poppins | 24 | w400 | Alt başlıklar |
| `titleLarge` | Inter | 22 | w500 | Kart/tile başlıkları |
| `titleMedium` | Inter | 16 | w500 | Buton label'ları, dialog başlıkları |
| `titleSmall` | Inter | 14 | w500 | Küçük başlıklar |
| `labelLarge` | Inter | 14 | w500 | Tab/segment label'ları |
| `labelMedium` | Inter | 12 | w500 | Section başlıkları, küçük label'lar |
| `labelSmall` | Inter | 11 | w500 | Chip/badge metinleri |
| `bodyLarge` | Inter | 16 | w400 | Ana içerik metni |
| `bodyMedium` | Inter | 14 | w400 | Genel metin, açıklama |
| `bodySmall` | Inter | 12 | w400 | Yardımcı metin, alt bilgi |

### Kullanım

```dart
// Doğru — TextTheme'den al
Text('Başlık', style: Theme.of(context).textTheme.headlineSmall)

// Özelleştirme gerekiyorsa copyWith kullan
Text(
  'Başlık',
  style: Theme.of(context).textTheme.titleLarge?.copyWith(
    fontWeight: FontWeight.bold,
    color: cs.onSurface,
  ),
)

// Yanlış — inline fontSize kullanma
Text('Başlık', style: TextStyle(fontSize: 24))
```

## Semantik Renkler (AppThemeColors)

`ThemeExtension` ile variant'tan bağımsız, dark/light moda duyarlı semantik renkler.
Dark modda pastel/yumuşak, light modda canlı/doygun tonlar. Geçişlerde `lerp()` ile smooth interpolasyon.

| Renk | Kullanım | Light | Dark |
|------|----------|-------|------|
| `scoreGold` | Altın skor rengi | `#FFD700` | `#FFE066` |
| `scoreRed` | Kırmızı skor rengi | `#FF4757` | `#FF6B81` |
| `scoreGreen` | Yeşil skor rengi | `#2ED573` | `#7BED9F` |
| `scoreBlue` | Mavi skor rengi | `#1E90FF` | `#70A1FF` |
| `scorePink` | Pembe skor rengi | `#FF6B81` | `#FF8FA3` |
| `toggleActive` | Aktif toggle rengi | `#2ED573` | `#7BED9F` |
| `toggleInactive` | Pasif toggle rengi | `#EF5350` | `#FF8A80` |

### Erişim

```dart
import 'package:akillisletme/product/theme/app_theme_colors.dart';

// Kısa erişim (önerilen)
context.appColors.scoreGold
context.appColors.toggleActive

// Uzun erişim (aynı sonuç)
Theme.of(context).extension<AppThemeColors>()!.scoreGold
```

## UI Bileşenleri

### ThemeSelectionDialog

`ThemeSelectionDialog.show(context)` ile açılır. İçerir:
- **Variant grid** — `Wrap` layout, renkli daire + label, seçili olana check icon + border
- **ThemeMode seçici** — `SegmentedButton` ile System / Light / Dark (sadece text, icon yok)
- Seçim yapıldığında dialog açık kalır, OK butonu ile kapanır

### ThemeSettingTile

Ayarlar sayfasında kullanılan büyük tile widget'ı. Gradient arka plan ile variant rengi ve label gösterir. Tıklanınca `ThemeSelectionDialog` açılır.

### ThemeTile

Settings sayfasındaki compact ListTile versiyonu. `LocaleKeys.settings_theme` kullanır. Sağ tarafında variant renk dairesi gösterir.

## Yeni Variant Ekleme

1. `app_theme_variant.dart`'taki enum'a yeni değer ekle:
   ```dart
   cyan(
     key: 'cyan',
     label: 'Cyan',
     seedColor: Color(0xFF00BCD4),
     previewColor: Color(0xFF00BCD4),
   ),
   ```
2. Bu kadar — `ColorScheme.fromSeed()` tüm dark/light renkleri otomatik üretir, dialog `Wrap` kullandığı için yeni variant otomatik görünür.

## Localization

Tema ile ilgili tüm string'ler `assets/translations/` altındaki JSON dosyalarında tanımlıdır:

| Key | TR | EN |
|-----|----|----|
| `settings.theme` | Tema | Theme |
| `settings.chooseTheme` | Tema Seçin | Choose Theme |
| `settings.themeMode` | Tema Modu | Theme Mode |
| `settings.themeModeSystem` | Sistem | System |
| `settings.themeModeLight` | Açık | Light |
| `settings.themeModeDark` | Koyu | Dark |
| `settings.appTheme` | Uygulama Teması | App Theme |

## Kurallar

- **Inline `TextStyle(fontSize: ...)` kullanma** — her zaman `Theme.of(context).textTheme.*` kullan
- **Inline renk kullanma** — semantik renkler için `context.appColors.*`, tema renkleri için `Theme.of(context).colorScheme.*`
- **Yeni semantik renk** eklenecekse `AppThemeColors`'a hem `light` hem `dark` sete ekle
- **Persistence** her zaman string key ile yapılır (int index kullanma)
