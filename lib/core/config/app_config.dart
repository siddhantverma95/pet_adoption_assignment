import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adoption_assignment/core/config/app_config_type.dart';
import 'package:pet_adoption_assignment/core/environment/environment.dart';

class AppConfig with AppConfigType {
  factory AppConfig({
    required Environment env,
    required Box<dynamic> hiveBox,
  }) {
    shared.env = env;
    shared._hiveBox = hiveBox;
    return shared;
  }

  AppConfig._instance();
  static final AppConfig shared = AppConfig._instance();
  late Environment env;
  late Box<dynamic> _hiveBox;

  @override
  Box<dynamic> get hiveBox => _hiveBox;
}
