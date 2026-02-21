# Settings & URL Güncelleme Rehberi

Settings sayfası ve About sayfasındaki URL/iletişim bilgilerini güncellemek için bu rehberi kullan.

## Güncellenmesi gereken bilgiler

Tüm değerler tek dosyada: `lib/product/const/app_string.dart`

### Store URL'leri
Uygulamanın mağaza linkleri. "Uygulamayı Puanla" butonu bu URL'leri kullanır.

| Alan | Açıklama | Örnek |
|------|----------|-------|
| `appStoreUrl` | iOS App Store linki | `https://apps.apple.com/app/<app-name>/id<APP_ID>` |
| `playStoreUrl` | Google Play Store linki | `https://play.google.com/store/apps/details?id=<PACKAGE_NAME>` |

### İletişim
"Bize Ulaşın" butonu bu adresi kullanır.

| Alan | Açıklama | Örnek |
|------|----------|-------|
| `contactEmail` | Destek e-posta adresi | `destek@example.com` |

### Yasal Belge URL'leri
About sayfasındaki yasal belge linkleri. Her biri in-app browser'da açılır.

| Alan | Açıklama |
|------|----------|
| `privacyPolicyUrl` | Gizlilik Politikası |
| `termsOfServiceUrl` | Kullanım Koşulları |
| `kvkkClarificationUrl` | KVKK Aydınlatma Metni |
| `consentDeclarationUrl` | Açık Rıza Beyanı |
| `acceptableUsePolicyUrl` | Kabul Edilebilir Kullanım Politikası |
| `refundPolicyUrl` | İade Politikası |
| `copyrightNoticeUrl` | Telif Hakkı Bildirimi |

## Kullanıcı ne söylemeli?

Güncellemek istediğin alanı ve yeni değeri söyle. Örnekler:

- "Contact email'i `info@firma.com` yap"
- "Play Store linkini `https://play.google.com/store/apps/details?id=com.firma.app` olarak güncelle"
- "Privacy policy URL'ini `https://firma.com/privacy` yap"
- "Tüm yasal belge URL'lerini güncelle: privacy → ..., terms → ..."

## Dosya haritası

```
lib/product/const/app_string.dart    # Tüm URL ve string sabitleri
lib/feature/settings/settings_view.dart  # Settings ana sayfası
lib/feature/about/about_view.dart        # Yasal belgeler sayfası
```
