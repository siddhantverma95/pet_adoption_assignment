import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adoption_assignment/core/logger/app_logger.dart';

abstract class ICacheClient {
  ICacheClient({required this.hiveBox});

  final Box<dynamic> hiveBox;
  void storeList(String key, List<dynamic> list);
  List<dynamic>? getStoredList(String key);
  void storeString(String key, String value);
  String? getStoredString(String key);
}

class CacheClientType extends ICacheClient {
  CacheClientType({required super.hiveBox});

  @override
  void storeList(String key, List<dynamic> list) {
    AppLog.storage('STORE LIST, KEY: $key, DATA: $list');
    hiveBox.put(key, json.encode(list));
  }

  @override
  List<dynamic>? getStoredList(String key) {
    AppLog.storage('GET STORED LIST, KEY: $key');
    final result = hiveBox.get(key);
    if (result != null) {
      return json.decode(result as String) as List<dynamic>;
    }
    return null;
  }

  @override
  String? getStoredString(String key) {
    AppLog.storage('GET STORED STRING, KEY: $key');
    return hiveBox.get(key) as String?;
  }

  @override
  void storeString(String key, String value) {
    AppLog.storage('STORE STRING, KEY: $key, DATA: $value');
    hiveBox.put(key, value);
  }
}
