# Firebase - Yorum Satırına Alınan Kodlar

Firebase henüz kurulmadığı için aşağıdaki dosyalarda ilgili kodlar yorum satırına alındı.
Firebase kurulumu tamamlandıktan sonra tüm dosyalardaki `// TODO: Firebase kurulduktan sonra` ile işaretlenmiş yorum satırlarını kaldır.

---

## 1. `pubspec.yaml`

Yorum satırına alınan paketler:

```yaml
firebase_core: ^güncell sürümleri al
firebase_remote_config: ^güncell sürümleri al
```

---

## 2. `lib/product/service/service_locator.dart`

- `RemoteConfigService` import'u
- `RemoteConfigService` singleton registration'ı
- `RemoteConfigService.init()` çağrısı
- `ServiceLocator` extension'ındaki `remoteConfigService` getter'ı

---

## 3. `lib/feature/login_process/splash/state/splash_cubit.dart`

- `package_info_plus` ve `RemoteConfigService` import'ları
- Constructor'daki `RemoteConfigService` dependency injection
- `checkApp()` içindeki version check logic'i (Firebase Remote Config'den min version okuma)
- `_isVersionLessThan()` metodu
- Geçici olarak `checkApp()` direkt `SplashState.success()` emit ediyor

---

## 4. `lib/product/init/application_init.dart` (zaten yorum satırındaydı)

- `Firebase.initializeApp()` çağrısı

---

## 5. `lib/product/navigation/app_router.dart`

- `SplashCubit` oluşturulurken `locator.remoteConfigService` geçilmeli
- `service_locator.dart` import edilmeli

---

## Firebase Kurulum Adımları (yapılacaklar)

1. Firebase Console'da proje oluştur
2. `flutterfire configure` komutunu çalıştır
3. `GoogleService-Info.plist` (iOS) ve `google-services.json` (Android) dosyalarını ekle
4. `pubspec.yaml`'daki firebase paketlerinin yorum satırlarını kaldır
5. `flutter pub get` çalıştır
6. Yukarıdaki dosyalardaki TODO yorum satırlarını kaldır ve orijinal kodları aktif et
7. `application_init.dart`'ta `Firebase.initializeApp()` çağrısını aktif et
8. `app_router.dart`'ta `SplashCubit`'e `locator.remoteConfigService` geç

firebase aktif edilğindeki yönetim akışı aşşağıdaki gibi olmalıdır 

  Uygulama açılıyor                                                                                     
         │                                                                                              
         ▼                                                                                              
    /splash (initialLocation)                                                                           
    SplashCubit.checkApp() otomatik çalışır                                                             
         │                                                                                              
         ├─ Firebase Remote Config'den min versiyon alır                                                
         │
         ├─ Versiyon eski mi? ──── EVET ──→ _UpdateRequiredView (Store'a yönlendir)
         │
         ├─ Hata var mı? ──────── EVET ──→ _ErrorView (Tekrar dene butonu)
         │
         └─ Başarılı ─────────────────────→ SharedCache kontrolü
                                                │
                                                ├─ isOnboardingCompleted == true
                                                │     └─→ HomeRoute().go()  →  /
                                                │
                                                └─ isOnboardingCompleted == false
                                                      └─→ OnboardingRoute().go()  →  /onboarding
                                                                │
                                                           5 adım PageView
                                                                │
                                                           Step5 "Başlayalım"
                                                                │
                                                      completeOnboarding()
                                                      ├─ SharedCache'e true yaz
                                                      └─ context.go('/')  →  Home

