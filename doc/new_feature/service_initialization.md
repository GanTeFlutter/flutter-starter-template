# Service Initialization & Locator

Tüm servisler şu akışla başlatılır:

```
ApplicationInit.start()
  -> WidgetsFlutterBinding.ensureInitialized()
  -> Firebase.initializeApp(...)          // Firebase gerektiğinde
  -> setupLocator()
      -> _registerSingletons()            // Servisleri kaydet
      -> _initializeServices()            // Async init çağır
```

## ApplicationInit (`lib/product/init/application_init.dart`)

```dart
@immutable
final class ApplicationInit {
  const ApplicationInit();

  Future<void> start() async {
    WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    await setupLocator();
  }
}
```

## Service Locator (`lib/product/service/service_locator.dart`)

```dart
final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  _registerSingletons();
  await _initializeServices();
}

Future<void> _initializeServices() async {
  await locator<SharedCache>().init();
  await locator<ProductCache>().init();
  await locator<RemoteConfigService>().init();
}

void _registerSingletons() {
  locator
    ..registerSingleton<SharedCache>(SharedCache.instance)
    ..registerSingleton<ProductCache>(
      ProductCache(cacheManager: HiveCacheManager()),
    )
    ..registerSingleton<RemoteConfigService>(
      RemoteConfigService.instance,
    );
}

extension ServiceLocator on GetIt {
  SharedCache get sharedCache => locator<SharedCache>();
  ProductCache get productCache => locator<ProductCache>();
  RemoteConfigService get remoteConfigService => locator<RemoteConfigService>();
}
```

## Locator'a yeni servis ekleme

1. `_registerSingletons()`'a ekle:
   ```dart
   ..registerSingleton<NewService>(NewService.instance)
   ```
2. Async init gerekiyorsa `_initializeServices()`'a ekle:
   ```dart
   await locator<NewService>().init();
   ```
3. `ServiceLocator` extension'a getter ekle:
   ```dart
   NewService get newService => locator<NewService>();
   ```

## Init pattern

Async setup gerektiren servisler şu pattern'i takip eder:

```dart
class SomeService {
  SomeService._();
  static final SomeService instance = SomeService._();

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    // setup logic...
    _initialized = true;
  }
}
```

## Mevcut servisler

| Servis | Tip | Erişim |
|--------|-----|--------|
| SharedCache | Basit key-value cache | `locator.sharedCache` |
| ProductCache | Hive model cache | `locator.productCache` |
| RemoteConfigService | Firebase Remote Config | `locator.remoteConfigService` |
| UrlLauncherService | URL açma / mail gönderme | `locator.urlLauncher` |
| PermissionService | İzin yönetimi (permission_handler) | `locator.permission` |
