import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';

abstract class SettingsRepositoryType {
  Future<Result<Failure, String>> getThemeMode();
  Future<Result<Failure, void>> storeThemeMode(String mode);
}
