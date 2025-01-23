import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adoption_assignment/core/cache/cache_client_type.dart';

class CacheClient {
  static CacheClientType cacheClient({
    required Box<dynamic> hiveBox,
    bool? encrypt,
  }) {
    return CacheClientType(
      hiveBox: hiveBox,
    );
  }
}
