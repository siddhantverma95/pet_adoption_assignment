import 'package:logger/logger.dart';
import 'package:pet_adoption_assignment/core/config/app_config.dart';
import 'package:pet_adoption_assignment/core/environment/environment.dart';

class CustomLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return AppConfig.shared.env.envType == EnvironmentType.dev;
  }
}
