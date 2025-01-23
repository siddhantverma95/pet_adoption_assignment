import 'package:pet_adoption_assignment/core/environment/environment.dart';

extension ProductionEnvironment on Environment {
  static Environment production() {
    return Environment(
      envType: EnvironmentType.prod,
      hiveBoxName: 'pet_adoption_prod',
    );
  }
}
