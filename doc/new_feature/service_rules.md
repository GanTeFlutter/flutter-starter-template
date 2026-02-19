# Service Rules

## Karar ağacı

1. **Locator'da var mı?** -> `service_locator.dart`'ı kontrol et. Varsa `locator<Service>()` ile al.
2. **Genel/paylaşılan servis mi?** -> `lib/product/service/` altına ekle + locator'a kaydet.
3. **Sadece bir modüle özel mi?** -> Feature klasöründe `service/` altına ekle, locator'a **ekleme**.

## Paylaşılan servis ekleme

Tek dosya -> `lib/product/service/services/<service_name>.dart`
Çok dosya -> `lib/product/service/<service_name>/` klasörü oluştur

Locator'a kaydet (`service_locator.dart`):
```dart
// _registerSingletons içinde:
..registerSingleton<NewService>(NewService.instance)

// Extension içinde:
NewService get newService => locator<NewService>();
```

## Modüle özel servis

Feature klasöründe `service/` altına eklenir. Locator'a **kaydedilmez**.
Sadece o modülün Cubit'i tarafından kullanılır.

```
lib/feature/<feature_name>/
  service/
    <feature>_service.dart
```

## Cache servisleri

Cache ihtiyaçları için locator'daki mevcut servisleri kullan:

| İhtiyaç | Servis | Erişim |
|---------|--------|--------|
| Basit key-value | SharedCache | `locator.sharedCache` |
| Model/liste cache | ProductCache | `locator.productCache` |

Detaylar: [data_storage.md](data_storage.md)
