# QR Kod Akıllı İşletme Theme System

## Architecture

Theme system uses `AppThemeVariant` enum with `ColorScheme.fromSeed()` for consistent Material 3 colors.

- **Brightness:** `ThemeMode.system` — follows device setting automatically
- **Variant:** Stored in SharedPreferences (`app_theme_variant` key)
- **State:** Managed by `ThemeCubit` (emits `AppThemeVariant`)

## File Structure

```
lib/product/theme/
├── app_theme_variant.dart    # Enum with 5 color palettes
├── theme.dart                # AppTheme entry point (part files)
├── base/
│   ├── color_schemes.dart    # Variant → ColorScheme helpers
│   ├── dark_theme.dart       # Dark ThemeData builder
│   └── light_theme.dart      # Light ThemeData builder
├── parts/
│   ├── button_theme.dart     # Parametric button themes
│   ├── card_theme.dart       # Card themes
│   ├── input_theme.dart      # Input decoration themes
│   ├── appbar_theme.dart     # AppBar theme
│   └── text_theme.dart       # Text theme
└── widget/
    ├── theme_selection_dialog.dart  # AlertDialog for picking variant
    └── theme_setting_tile.dart     # Settings tile (matches Sound/Vibration pattern)
```

## Available Variants

| Variant  | Seed Color | Preview   |
|----------|-----------|-----------|
| Purple   | `#7C4DFF` | Default   |
| Blue     | `#2196F3` |           |
| Green    | `#4CAF50` |           |
| Orange   | `#FF9800` |           |
| Red      | `#E91E63` |           |

## Adding a New Variant

1. Add entry to `AppThemeVariant` enum in `app_theme_variant.dart`:
   ```dart
   newColor(
     key: 'new_color',
     label: 'New Color',
     seedColor: Color(0xFFXXXXXX),
     previewColor: Color(0xFFXXXXXX),
   ),
   ```
2. That's it — `ColorScheme.fromSeed()` generates all dark/light colors automatically.
