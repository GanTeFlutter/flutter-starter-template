# Data Storage

Detaylı kullanım rehberi: **`lib/product/cache/CACHE_GUIDE.md`**

## A) Basit veri — SharedCache (SharedPreferences)

Ayarlar, flag'ler, basit string/bool/int değerler için `SharedCache` kullan.

```
lib/product/cache/shared_operation/
  shared_cache.dart               # Singleton — high-level getter/setter API
  shared_keys.dart                # Key enum'u
  base_shared_operation.dart      # Abstract base + implementation
  shared_operation_generic_mixin.dart  # Type-safe generic read/write
```

### Yeni key ekleme

1. `shared_keys.dart`'a key ekle:
```dart
enum SharedKeys {
  firstAppOpen,
  theme,
  themeVariant,
  yeniKey,          // <-- ekle
}
```

2. `shared_cache.dart`'a getter/setter ekle:
```dart
bool get isYeniKey =>
    getValue<bool>(SharedKeys.yeniKey) ?? false;

Future<void> setYeniKey({required bool value}) async {
  await setValue<bool>(SharedKeys.yeniKey, value);
}
```

3. Kullanım:
```dart
final deger = locator.sharedCache.isYeniKey;
await locator.sharedCache.setYeniKey(value: true);
```

### Desteklenen tipler
`bool`, `int`, `double`, `String`, `List<String>`

---

## B) Karmaşık veri / Cache — ProductCache (Hive CE)

Model listeleri, koleksiyonlar, offline cache için `ProductCache` kullan.

```
lib/product/cache/
  product_cache.dart                # Ana koordinatör
  cache_manager.dart                # Soyut arayüzler
  hive_v2/
    hive_cache.dart                 # Hive başlatma
    hive_operation_manager.dart     # Generic CRUD
    hive_adapters.dart              # @GenerateAdapters
    model/
      app_cache_model.dart          # Örnek model
```

### Yeni cache modeli ekleme

1. `hive_v2/model/` altında model oluştur (`CacheModel` mixin + `EquatableMixin` + `@JsonSerializable()`)
2. `hive_adapters.dart`'a `AdapterSpec<Model>()` ekle (nested modeller dahil)
3. `product_cache.dart`'a `late final CacheOperation<Model>` ekle + `init()` listesine empty constructor ekle
4. `dart run build_runner build --delete-conflicting-outputs` çalıştır

### Kullanım

```dart
final cache = locator.productCache;

// CRUD
cache.modelCache.add(model);
cache.modelCache.get('id');
cache.modelCache.getAll();
cache.modelCache.update(model);
cache.modelCache.delete(model);
await cache.modelCache.removeAll();
```

---

## Karar tablosu

| Veri tipi | Yöntem | Konum |
|-----------|--------|-------|
| Basit key-value (bool, int, String) | SharedCache | `cache/shared_operation/` |
| Ayarlar, flag'ler | SharedCache | `cache/shared_operation/` |
| Model listeleri, koleksiyonlar | ProductCache (Hive) | `cache/hive_v2/model/` |
| Offline-first cached veri | ProductCache (Hive) | `cache/hive_v2/model/` |
