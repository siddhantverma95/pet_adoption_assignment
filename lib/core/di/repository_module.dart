import 'package:pet_adoption_assignment/core/di/cache_module.dart';
import 'package:pet_adoption_assignment/features/home/data/home_repository.dart';
import 'package:pet_adoption_assignment/features/home/domain/home_repository_type.dart';
import 'package:pet_adoption_assignment/features/settings/data/settings_repository.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_repository_type.dart';

mixin RepositoryModule on CacheModule {
  HomeRepositoryType get homeRepository {
    return HomeRepository(cache: cache);
  }

  SettingsRepositoryType get settingsRepository {
    return SettingsRepository(cache: cache);
  }
}
