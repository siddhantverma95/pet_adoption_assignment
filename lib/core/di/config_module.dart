import 'package:pet_adoption_assignment/core/config/app_config.dart';
import 'package:pet_adoption_assignment/core/config/app_config_type.dart';

mixin ConfigModule {
  AppConfigType get appConfig {
    return AppConfig.shared;
  }
}
