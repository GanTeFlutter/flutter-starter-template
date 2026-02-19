# Widget and Theme Rules

## Decision tree

1. **Check `product/widget/`.** Is there an existing shared widget used across the app?
2. **If it exists, use it.** Do not create a new widget.
3. **If it doesn't exist and will be used across the app** -> Add it under `lib/product/widget/`.
4. **If it's a widget specific only to this feature** -> Add it under `lib/feature/<feature>/widget/`.

## Theme / Style

1. **Check `product/theme/parts/`.** Button theme, card theme, etc. are already defined app-wide.
   (Example: `button_theme.dart` -> Global styles for ElevatedButton, FilledButton)
2. **If the global theme is sufficient** -> Do not add extra styles, the theme is applied automatically.
3. **If a specific/different design is needed** -> Override the style in the feature's `widget/` folder.

## Existing shared widgets

| Widget | Location | Usage |
|---|---|---|
| `AppPrimaryButton` | `product/widget/` | Birincil aksiyon butonu (FilledButton, haptic feedback) |
| `AppSecondaryButton` | `product/widget/` | Ikincil aksiyon butonu (OutlinedButton, haptic feedback) |
| `AppTextButton` | `product/widget/` | Hafif metin butonu (TextButton, haptic feedback) |
| `ThemeSettingTile` | `product/theme/widget/` | Tema secim tile'i (kart gorunumlu) |
| `ThemeSelectionDialog` | `product/theme/widget/` | Tema secim dialog'u (grid) |
| `SettingsSection` | `feature/settings/widget/` | Ayarlar grubu karti |

## Existing shared utilities

| Utility | Location | Usage |
|---|---|---|
| `AppPaddings` | `product/const/app_paddings.dart` | Padding/spacing sabitleri — hardcoded deger kullanma |
| `AppMessenger` | `product/utils/app_messenger.dart` | SnackBar, Dialog, BottomSheet — context extension |

### AppPaddings kullanimi

Hardcoded `EdgeInsets.all(24)` yerine `AppPaddings` kullan:

```dart
// Hazir EdgeInsets
padding: AppPaddings.allXxl            // EdgeInsets.all(24)
padding: AppPaddings.page              // horizontal: 16, vertical: 8
padding: AppPaddings.horizontalL       // horizontal: 16

// Responsive padding
padding: EdgeInsets.all(context.r(AppPaddings.l))  // scaled 16

// Double deger olarak
SizedBox(height: context.r(AppPaddings.m))         // scaled 12
```

### AppMessenger kullanimi

Kullaniciya geri bildirim gosterirken `AppMessenger` extension'i kullan:

```dart
// SnackBar
context.showSuccessSnack('Kaydedildi!');
context.showErrorSnack('Bir hata olustu');
context.showInfoSnack('Bilgilendirme');

// Onay dialog'u (true/false doner)
final confirmed = await context.showConfirmDialog(
  title: 'Silmek istediginize emin misiniz?',
  message: 'Bu islem geri alinamaz.',
  isDestructive: true,  // kirmizi buton
);

// Bottom sheet
context.showAppBottomSheet<void>(child: MyContentWidget());
```

## General widget rules

- Every repeated or complex UI piece is extracted into a separate file under `widget/`
- Widgets use `final` parameters with `const` constructors
- Callbacks are received via `VoidCallback` or `ValueChanged<T>`
