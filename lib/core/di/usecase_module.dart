import 'package:pet_adoption_assignment/core/di/repository_module.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_usecases.dart';

mixin UsecaseModule on RepositoryModule {
  GetHomePetsUsecase get homeUsecase {
    return GetHomePetsUsecase(homeRepository: homeRepository);
  }

  StoreHomePetsUsecase get storeHomeUsecase {
    return StoreHomePetsUsecase(homeRepository: homeRepository);
  }

  GetThemeModeUsecase get themeModeUsecase {
    return GetThemeModeUsecase(repository: settingsRepository);
  }

  StoreThemeModeUsecase get storeThemeUsecase {
    return StoreThemeModeUsecase(repository: settingsRepository);
  }
}
