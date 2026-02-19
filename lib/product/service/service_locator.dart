import 'package:akillisletme/product/cache/hive_v2/hive_cache.dart';
import 'package:akillisletme/product/cache/product_cache.dart';
import 'package:akillisletme/product/cache/shared_operation/shared_cache.dart';
import 'package:get_it/get_it.dart';

//  Firebase kurulduktan sonra yorum satırlarını kaldır
// import 'package:qrcode_akillisletme/product/service/services/remote_config_service.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  _registerSingletons();
  await _initializeServices();
}

Future<void> _initializeServices() async {
  await locator<SharedCache>().init();
  await locator<ProductCache>().init();
  // await locator<RemoteConfigService>().init();
}

void _registerSingletons() {
  locator
    ..registerSingleton<SharedCache>(SharedCache.instance)
    ..registerSingleton<ProductCache>(
      ProductCache(cacheManager: HiveCacheManager()),
    );
  // ..registerSingleton<RemoteConfigService>(
  //   RemoteConfigService.instance,
  // );
}

extension ServiceLocator on GetIt {
  SharedCache get sharedCache => locator<SharedCache>();
  ProductCache get productCache => locator<ProductCache>();
  // RemoteConfigService get remoteConfigService => locator<RemoteConfigService>();
}
