# New Feature / Screen Addition Guide

This directory contains modular documentation for adding new features to the project.
Read only the file(s) relevant to your task.

Reference implementation: `lib/feature/<any_existing_feature>/`

---

## Quick Navigation: What are you doing?

| Task | Read this |
|---|---|
| Creating a new feature folder | [folder_structure.md](folder_structure.md) |
| Adding a service | [service_rules.md](service_rules.md) |
| Creating a model | [model_rules.md](model_rules.md) |
| Adding an enum or constant | [enums_and_constants.md](enums_and_constants.md) |
| Setting up state (Cubit + Freezed) | [state_management.md](state_management.md) |
| Storing data (SharedCache / Hive) | [data_storage.md](data_storage.md) |
| Caching a model (Hive) | [data_storage.md](data_storage.md) + `lib/product/cache/CACHE_GUIDE.md` |
| Registering a service in locator | [service_initialization.md](service_initialization.md) |
| Building a view (Stateless / Stateful) | [view_rules.md](view_rules.md) |
| Adding a widget or using theme | [widget_and_theme.md](widget_and_theme.md) |
| Using paddings/spacing | [widget_and_theme.md](widget_and_theme.md) (`AppPaddings`) |
| Showing SnackBar, Dialog, BottomSheet | [widget_and_theme.md](widget_and_theme.md) (`AppMessenger`) |
| Adding a route or UI string | [route_and_strings.md](route_and_strings.md) |
| Adding an asset (image, SVG, Lottie) | [assets_and_flutter_gen.md](assets_and_flutter_gen.md) |

---

## Checklist

When adding a new feature:

- [ ] Create `lib/feature/<feature>/` folder structure ([folder_structure.md](folder_structure.md))
- [ ] Write `<feature>.md` module documentation ([folder_structure.md](folder_structure.md))
- [ ] If models are needed, write them with Freezed + toMap/fromMap ([model_rules.md](model_rules.md))
- [ ] Freezed state + Cubit: write and place correctly ([state_management.md](state_management.md))
- [ ] App-wide state? -> Place in `product/state/`, otherwise `feature/state/`
- [ ] BlocProvider: decide global (state_initialize) or local (BlocProvider in view)
- [ ] Run `dart run build_runner build --delete-conflicting-outputs`
- [ ] Determine view type: StatelessWidget / StatefulWidget + ViewModel ([view_rules.md](view_rules.md))
- [ ] If StatefulWidget, separate into `_view.dart` + `_view_model.dart`
- [ ] Widget needs: check `product/widget/` first, use if available ([widget_and_theme.md](widget_and_theme.md))
- [ ] If no shared widget exists and it's general -> `product/widget/`; if specific -> `feature/widget/`
- [ ] Theme: check `product/theme/parts/`, do not override if global style is sufficient
- [ ] Enums -> `product/enum/`, check if one already exists ([enums_and_constants.md](enums_and_constants.md))
- [ ] Constants -> `product/const/`
- [ ] Service needs: check locator, add if necessary ([service_rules.md](service_rules.md) + [service_initialization.md](service_initialization.md))
- [ ] If new service requires init -> add to `_initializeServices()` in locator
- [ ] Basit veri cache? -> `SharedCache` + `SharedKeys` ([data_storage.md](data_storage.md))
- [ ] Model/liste cache? -> `ProductCache` + Hive model ([data_storage.md](data_storage.md) + `CACHE_GUIDE.md`)
- [ ] Add strings to `AppString` ([route_and_strings.md](route_and_strings.md))
- [ ] Add route to `app_router.dart` as TypedGoRoute + run build_runner ([route_and_strings.md](route_and_strings.md))
- [ ] Padding/spacing: use `AppPaddings` constants, no hardcoded values ([widget_and_theme.md](widget_and_theme.md))
- [ ] User feedback needed? Use `AppMessenger` — `context.showSuccessSnack()`, `showConfirmDialog()`, `showAppBottomSheet()` ([widget_and_theme.md](widget_and_theme.md))
- [ ] Assets: use `Assets.xxx` generated accessors, no hardcoded paths ([assets_and_flutter_gen.md](assets_and_flutter_gen.md))
- [ ] New asset added? Run `dart run build_runner build --delete-conflicting-outputs`
- [ ] Add responsive check (`isWide`)
- [ ] Use theme colors (no hardcoded colors)
