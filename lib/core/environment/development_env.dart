import 'package:pet_adoption_assignment/core/environment/environment.dart';

extension DevelopmentEnvironment on Environment {
  static Environment development() {
    return Environment(
      hiveBoxName: 'pet_adoption_dev',
      envType: EnvironmentType.dev,
    );
  }
}
