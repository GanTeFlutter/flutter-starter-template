# Route Addition & Strings

## Route Addition (TypedGoRoute)

The project uses type-safe `TypedGoRoute` + `GoRouteData` + code generation.
Routes are defined in `lib/product/navigation/app_router.dart`.

### Adding a new route (2 steps):

**1. Create a GoRouteData class** (`app_router.dart`):
```dart
class FeatureRoute extends GoRouteData with $FeatureRoute {
  const FeatureRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return slideRightTransition(
      key: state.pageKey,
      child: const FeatureView(),
    );
  }
}
```

**2. Add to TypedGoRoute annotation** (nested under HomeRoute):
```dart
@TypedGoRoute<HomeRoute>(
  path: '/home',
  routes: [
    // ...existing routes
    TypedGoRoute<FeatureRoute>(path: 'feature_name'),
  ],
)
```

**3. Run codegen:**
```
dart run build_runner build --delete-conflicting-outputs
```

### Passing data ($extra)

Use the `$extra` parameter to pass data to routes:
```dart
class FeatureRoute extends GoRouteData with $FeatureRoute {
  const FeatureRoute({required this.$extra});
  final FeatureConfig $extra;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return slideRightTransition(
      key: state.pageKey,
      child: FeatureView(config: $extra),
    );
  }
}
```

### Navigation usage

```dart
// Navigate to page
const FeatureRoute().go(context);

// Push onto stack
const FeatureRoute().push(context);

// Navigate with data
FeatureRoute($extra: config).go(context);
```

### Key rules

- Sub-routes are added nested under `HomeRoute`
- Every route class must include `with $RouteName` mixin
- Use `buildPage` override for custom transitions (slide/fade)
- `route_transitions.dart` provides `slideRightTransition` and `fadeTransition`

---

## String Addition

Projede iki string yontemi vardir:

### A) Coklu Dil Destegi — EasyLocalization (oncelikli)

Kullaniciya gorunen tum metinler `assets/translations/` altindaki JSON dosyalarinda tanimlanir.

**Yeni string ekleme (4 adim):**

1. `assets/translations/tr.json` ve `assets/translations/en.json` dosyalarina key ekle:
   ```json
   {
     "feature": {
       "title": "Baslik",
       "description": "Aciklama metni"
     }
   }
   ```

2. Type-safe key'leri yeniden olustur:
   ```bash
   flutter pub run easy_localization:generate \
     -O lib/product/init/language \
     -f keys \
     -o locale_keys.g.dart \
     --source-dir assets/translations
   ```

3. Widget'ta kullan:
   ```dart
   import 'package:easy_localization/easy_localization.dart';
   import 'package:akillisletme/product/init/language/locale_keys.g.dart';

   Text(LocaleKeys.feature_title.tr())
   ```

4. Dil degistirme:
   ```dart
   context.setLocale(const Locale('en', 'US'));
   ```

**JSON yapilandirmasi:**

| Dosya | Konum |
|-------|-------|
| `tr.json` | `assets/translations/tr.json` |
| `en.json` | `assets/translations/en.json` |
| Locale ayari | `lib/product/init/language/core_localize.dart` |
| Generated key'ler | `lib/product/init/language/locale_keys.g.dart` |

**Kurallar:**
- Key'ler nested JSON yapisi kullanir: `"feature": { "title": "..." }`
- Generated dosyada key'ler alt cizgi ile birlenir: `LocaleKeys.feature_title`
- Her iki dile de (TR + EN) eklemeyi unutma
- Key ekledikten sonra generate komutunu calistir

### B) Sabit Stringler — AppString

Cevirisi gerekmeyen sabit degerler (URL, store link, teknik string) icin.

```
lib/product/const/app_string.dart
```

```dart
static const String storeUrl = 'https://...';
```
