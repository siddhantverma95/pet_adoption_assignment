import 'package:pet_adoption_assignment/core/cache/cache_client_type.dart';
import 'package:pet_adoption_assignment/core/di/config_module.dart';

mixin CacheModule on ConfigModule {
  CacheClientType get cache {
    return CacheClientType(hiveBox: appConfig.hiveBox);
  }
}
