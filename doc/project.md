# Flutter Starter Template

Yeni bir Flutter projesine hizli baslamak icin hazirlanmis boilerplate/template projesidir. Icerisinde tema, cache, navigasyon, dil destegi, state yonetimi, servis altyapisi, onboarding ve ayarlar sayfasi hazir olarak gelir.

## Kurulum

```bash
# Bagimlikari yukle
flutter pub get

# Code-gen dosyalarini olustur
dart run build_runner build --delete-conflicting-outputs

# Locale key'lerini olustur
flutter pub run easy_localization:generate -O lib/product/init/language -f keys -o locale_keys.g.dart --source-dir assets/translations
```

## Proje Yapisi

```
lib/
├── main.dart                              # Uygulama giris noktasi
├── feature/                               # Ekranlar / ozellikler
│   ├── home/
│   │   ├── home_view.dart                 # Ana sayfa (StatefulWidget + ViewModel)
│   │   ├── home_view_mode.dart            # ViewModel (abstract State)
│   │   └── widget/
│   │       └── home_background.dart       # Global animasyonlu arka plan
│   ├── login_process/
│   │   ├── onboarding/
│   │   │   ├── onboarding_view.dart       # 5 adimlik PageView onboarding
│   │   │   ├── onboarding_view_model.dart # ViewModel (abstract State)
│   │   │   ├── cubit/
│   │   │   │   └── onboarding_cubit.dart  # Sayfa navigasyonu + tamamlama
│   │   │   └── steps/
│   │   │       ├── step1/step_1.dart
│   │   │       ├── step2/step_2.dart
│   │   │       ├── step3/step_3.dart
│   │   │       ├── step4/step_4.dart
│   │   │       └── step5/step_5.dart      # Son adim
│   │   └── splash/
│   │       ├── splash_view.dart           # Splash ekrani
│   │       ├── state/                     # SplashCubit + Freezed state
│   │       └── widgets/                   # error, loading, update_required
│   └── settings/
│       ├── settings_view.dart             # Ayarlar sayfasi
│       └── widget/
│           ├── settings_section.dart      # Gruplu kart widget
│           ├── theme_tile.dart            # Tema secim tile'i
│           └── language_tile.dart         # Dil degistirme tile'i
└── product/                               # Paylasilan altyapi katmani
    ├── cache/                             # Cache sistemi (SharedCache + Hive)
    ├── const/                             # Sabitler (AppString, AppPaddings, RegexTypes)
    ├── init/                              # Uygulama baslatma
    │   ├── app_builder.dart               # Global background + overlay builder
    │   ├── application_init.dart          # Binding + locator init
    │   ├── state_initialize.dart          # MultiBlocProvider (global cubits)
    │   └── language/                      # EasyLocalization ayarlari
    ├── navigation/                        # GoRouter yapilandirmasi + gecis animasyonlari
    ├── service/                           # Servisler + GetIt DI
    ├── state/                             # App-wide state (ThemeCubit vb.)
    ├── theme/                             # Tema sistemi (5 variant, dark/light)
    ├── generated/                         # FlutterGen output (assets.gen.dart, fonts.gen.dart)
    ├── utils/                             # AppMessenger, responsive, haptic feedback, decorations
    └── widget/                            # Paylasilan butonlar
```

## Uygulama Akisi

```
Ilk acilis:  Onboarding (5 step) → Home
Sonraki:     Home (direkt)
```

- Onboarding tamamlaninca `SharedCache.isOnboardingCompleted` kaydedilir
- Router `initialLocation` bu flag'e gore karar verir
- Home'dan Settings sayfasina gecilir (tema + dil ayarlari)
- Global arka plan animasyonu `AppBuilder` ile tum sayfalarda gorunur

## Hazir Gelen Altyapilar

### 1. Tema Sistemi

5 renk varianti (Purple, Blue, Green, Orange, Red) ile Material 3 tema sistemi. Dark/light otomatik.

- **Yapilandirma:** `lib/product/theme/`
- **State:** `ThemeCubit` — variant secimini SharedCache'e kaydeder
- **Kullanim:** `context.watch<ThemeCubit>().state` ile variant al
- **Secim dialog'u:** `ThemeSelectionDialog.show(context)`
- **Detay:** `lib/product/theme/THEME.md`

### 2. Cache Sistemi

Iki katmanli cache: basit key-value icin SharedCache, karmasik modeller icin Hive.

| Veri Tipi | Sistem | Erisim |
|-----------|--------|--------|
| bool, int, String | SharedCache | `locator.sharedCache` |
| Model listeleri | ProductCache (Hive) | `locator.productCache` |

- **Yapilandirma:** `lib/product/cache/`
- **Detay:** `lib/product/cache/CACHE_GUIDE.md`

### 3. Navigasyon

Type-safe GoRouter ile routing. `go_router_builder` code-gen kullanir.

- **Yapilandirma:** `lib/product/navigation/app_router.dart`
- **Gecis animasyonlari:** `route_transitions.dart` (slide + fade, staggered fade)
- **Yeni rota:** `TypedGoRoute` + `GoRouteData` ekle, `build_runner` calistir

**Mevcut rotalar:**

| Rota | Path | Gecis |
|------|------|-------|
| HomeRoute | `/` | fade |
| SettingsRoute | `/settings` | slide right + fade |
| OnboardingRoute | `/onboarding` | fade |

### 4. Coklu Dil Destegi (i18n)

`easy_localization` ile TR + EN destegi. JSON tabanli ceviri dosyalari.

- **Ceviri dosyalari:** `assets/translations/tr.json`, `en.json`
- **Locale ayari:** `lib/product/init/language/core_localize.dart`
- **Type-safe key'ler:** `lib/product/init/language/locale_keys.g.dart` (generated)
- **Kullanim:** `LocaleKeys.home_title.tr()`
- **Dil degistirme:** `context.setLocale(Locale('en', 'US'))`
- **Yeni key ekleyince:** locale_keys'i yeniden olustur (yukaridaki komutu calistir)

### 5. State Yonetimi

flutter_bloc + Freezed ile state yonetimi.

- **App-wide state:** `lib/product/state/` (ThemeCubit gibi)
- **Feature state:** `lib/feature/<feature>/state/` veya `cubit/` (SplashCubit, OnboardingCubit gibi)
- **Provider kaydi:** `lib/product/init/state_initialize.dart`

### 6. Dependency Injection

GetIt ile singleton servis yonetimi.

- **Yapilandirma:** `lib/product/service/service_locator.dart`
- **Erisim:** `locator.sharedCache`, `locator.productCache`
- **Yeni servis:** `_registerSingletons()`'a ekle + extension'a getter ekle

### 7. Onboarding

5 adimlik PageView tabanli onboarding akisi.

- **Yapilandirma:** `lib/feature/login_process/onboarding/`
- **Navigasyon:** Sol ok + sayfa gostergesi + sag ok (alt bar)
- **Tamamlama:** Son adimda sag ok `completeOnboarding()` cagirarak Home'a yonlendirir
- **Kalicilik:** `SharedCache.isOnboardingCompleted` ile ikinci acilista atlanir

### 8. Ayarlar Sayfasi

Tema secimi ve dil degistirme iceren ayarlar sayfasi.

- **Yapilandirma:** `lib/feature/settings/`
- **Erisim:** Home AppBar'daki settings ikonu
- **Icerik:** Gorunum bolumu (tema + dil)

### 9. Global Arka Plan Animasyonu

Tum sayfalarda gorunen animasyonlu "Flutter Starter Template" yazilari.

- **Yapilandirma:** `lib/feature/home/widget/home_background.dart`
- **Entegrasyon:** `AppBuilder` (`lib/product/init/app_builder.dart`) ile `MaterialApp.builder` uzerinden
- **Acma/kapama:** `HomeBackground.enabledNotifier` ile kontrol edilir

### 10. FlutterGen (Type-Safe Asset Erisimi)

Asset dosyalarina hardcoded path yerine type-safe erisim saglar. Compile-time hata kontrolu + IDE autocomplete.

- **Yapilandirma:** `pubspec.yaml` altinda `flutter_gen:` blogu
- **Output:** `lib/product/generated/assets.gen.dart`, `fonts.gen.dart`
- **Desteklenen tipler:** Image (PNG/JPG), SVG (`flutter_svg`), Lottie, Font
- **Kullanim:**
  ```dart
  Assets.image.booom.image(width: 100)    // PNG/JPG
  Assets.svg.bomb.svg(width: 24)          // SVG
  Assets.lottie.backroundAnimation.lottie() // Lottie
  FontFamily.poppins                       // Font ailesi
  ```
- **Yeni asset ekleyince:** dosyayi `assets/<tip>/` klasorune koy, `build_runner` calistir
- **Detay:** `doc/new_feature/assets_and_flutter_gen.md`

### 11. AppPaddings (Padding Sabitleri)

Tum uygulamada tutarli bosluk degerleri. Hardcoded `EdgeInsets.all(24)` yerine `AppPaddings` kullanilir.

- **Dosya:** `lib/product/const/app_paddings.dart`
- **Degerler:** xs=4, s=8, m=12, l=16, xl=20, xxl=24, xxxl=32
- **Hazir EdgeInsets:** `AppPaddings.allXxl`, `AppPaddings.page`, `AppPaddings.horizontalL`
- **Responsive:** `EdgeInsets.all(context.r(AppPaddings.l))`

### 12. AppMessenger (Kullanici Geri Bildirimi)

SnackBar, Dialog ve BottomSheet gostermek icin BuildContext extension'lari.

- **Dosya:** `lib/product/utils/app_messenger.dart`
- **Kullanim:**
  ```dart
  context.showSuccessSnack('Kaydedildi!');
  context.showErrorSnack('Hata olustu');
  context.showInfoSnack('Bilgi');
  final confirmed = await context.showConfirmDialog(title: '...', message: '...');
  context.showAppBottomSheet<void>(child: MyWidget());
  ```

### 13. RegexTypes (Validation Pattern'leri)

Form dogrulama ve input formatlama icin regex desenleri. Turkce karakter destekli.

- **Dosya:** `lib/product/const/regex_types.dart`
- **Pattern'ler:** fullName, email, studentEmail, digitsOnly, phoneNumber, password
- **Kullanim:** `RegexTypes.email.hasMatch(value)`

### 14. Firebase (Opsiyonel)

Firebase Remote Config entegrasyonu hazir (version check icin). Firebase aktif edilince:

1. `application_init.dart`'taki Firebase satirini uncomment et
2. `firebase_options.dart` dosyasini olustur (`flutterfire configure`)
3. `service_locator.dart`'ta RemoteConfigService kaydini uncomment et

## Paylasilan Widget'lar

| Widget | Dosya | Aciklama |
|--------|-------|----------|
| AppPrimaryButton | `product/widget/` | Birincil aksiyon butonu (FilledButton) |
| AppSecondaryButton | `product/widget/` | Ikincil aksiyon butonu (OutlinedButton) |
| AppTextButton | `product/widget/` | Hafif metin butonu (TextButton) |
| ThemeSettingTile | `product/theme/widget/` | Tema secim tile'i (kart gorunumlu) |
| ThemeSelectionDialog | `product/theme/widget/` | Tema secim dialog'u (grid) |
| SettingsSection | `feature/settings/widget/` | Ayarlar grubu karti |
| ThemeTile | `feature/settings/widget/` | Ayarlar icin tema ListTile |
| LanguageTile | `feature/settings/widget/` | Ayarlar icin dil ListTile |

## Utility'ler

| Utility | Dosya | Aciklama |
|---------|-------|----------|
| AppMessenger | `product/utils/` | SnackBar, Dialog, BottomSheet — context extension |
| AppPaddings | `product/const/` | Padding/spacing sabitleri — hardcoded deger kullanma |
| RegexTypes | `product/const/` | Turkce karakter destekli validation regex'leri |
| ResponsiveExtension | `product/utils/` | `context.r(20)`, `context.rf(16)` — responsive boyutlandirma |
| ButtonFeedback | `product/utils/` | Haptic + ses geri bildirimi |
| ThemeDecorations | `product/utils/` | Tema bazli container decoration |

## Font'lar

| Font | Kullanim |
|------|----------|
| Poppins | Display + Headline (buyuk basliklar) |
| Inter | Title + Label + Body (govde metni) |

## Dokumantasyon Sistemi

Proje icerisinde iki dokumantasyon katmani vardir:

### `doc/new_feature/`

Yeni bir ozellik eklerken adim adim rehber. Her konu icin ayri `.md` dosyasi:

| Dosya | Konu |
|-------|------|
| `README.md` | Genel checklist + yonlendirme tablosu |
| `folder_structure.md` | Klasor yapisi kurallari |
| `data_storage.md` | Cache/storage karar agaci |
| `model_rules.md` | Model olusturma kurallari |
| `state_management.md` | Cubit + Freezed kurallari |
| `view_rules.md` | View yapisi kurallari |
| `widget_and_theme.md` | Widget + tema kurallari |
| `service_rules.md` | Servis yerlestirme kurallari |
| `service_initialization.md` | Locator + init akisi |
| `route_and_strings.md` | Rota + string ekleme |
| `enums_and_constants.md` | Enum + sabit kurallari |
| `assets_and_flutter_gen.md` | FlutterGen ile asset ekleme |

### Inline rehberler

| Dosya | Konum | Konu |
|-------|-------|------|
| `CACHE_GUIDE.md` | `lib/product/cache/` | Cache sistemi kullanim rehberi |
| `THEME.md` | `lib/product/theme/` | Tema sistemi dokumantasyonu |
| `ONBOARDING.md` | `lib/feature/login_process/onboarding/` | Onboarding modulu dokumantasyonu |

## Yeni Projeye Baslarken

1. Bu repoyu klonla / kopyala
2. `pubspec.yaml`'da `name` alanini degistir
3. Proje genelinde package adini guncelle (`akillisletme` -> yeni isim)
4. `assets/translations/` icindeki stringleri guncelle
5. `AppString`'deki store URL'lerini doldur
6. `home_background.dart`'taki animasyon metnini degistir veya animasyonu ozellestir
7. `app_theme_variant.dart`'tan ihtiyac disinda olan renkleri kaldir veya yenilerini ekle
8. Onboarding step'lerinin iceriklerini guncelle (simdilik placeholder)
9. `flutter pub get && dart run build_runner build --delete-conflicting-outputs`
10. `doc/new_feature/README.md`'deki checklist'i takip ederek ozellik eklemeye basla

## Lint

`very_good_analysis` kullanilir. Generated dosyalar (`*.g.dart`, `*.freezed.dart`) analiz disinda tutulur.

```bash
flutter analyze
```
