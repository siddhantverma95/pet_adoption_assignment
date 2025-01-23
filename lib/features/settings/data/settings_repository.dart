import 'package:pet_adoption_assignment/core/cache/cache_client_type.dart';
import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_repository_type.dart';

class SettingsRepository extends SettingsRepositoryType {
  SettingsRepository({required this.cache});

  final CacheClientType cache;
  static const String themeModeKey = 'themeModeKey';
  @override
  Future<Result<Failure, String>> getThemeMode() async {
    final themeMode = cache.getStoredString(themeModeKey);
    if (themeMode != null) {
      return Success(themeMode);
    } else {
      return const Error(Failure(message: 'No theme found'));
    }
  }

  @override
  Future<Result<Failure, void>> storeThemeMode(String mode) async {
    try {
      cache.storeString(themeModeKey, mode);
      return const Success(null);
    } catch (e) {
      return Error(Failure(message: e.toString()));
    }
  }
}
