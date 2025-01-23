import 'package:pet_adoption_assignment/core/environment/development_env.dart';
import 'package:pet_adoption_assignment/core/environment/production_env.dart';

enum EnvironmentType { dev, prod }

class Environment {
  Environment({
    required this.envType,
    required this.hiveBoxName,
  });

  factory Environment.development() {
    return DevelopmentEnvironment.development();
  }

  factory Environment.production() {
    return ProductionEnvironment.production();
  }

  final EnvironmentType envType;
  final String hiveBoxName;
}
