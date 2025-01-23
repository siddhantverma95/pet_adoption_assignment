import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/core/config/core_usecase.dart';
import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/settings/domain/models/theme_model.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_repository_type.dart';

class GetThemeModeUsecase extends CoreUsecase<ThemeMode, void> {
  GetThemeModeUsecase({required this.repository});
  final SettingsRepositoryType repository;
  @override
  Future<Result<Failure, ThemeMode>> call(void input) async {
    final result = await repository.getThemeMode();
    return result.when(
      success: (value) => Success(appThemeModes.map[value] ?? ThemeMode.light),
      error: Error.new,
    );
  }
}

class StoreThemeModeUsecase extends CoreUsecase<void, ThemeMode> {
  StoreThemeModeUsecase({required this.repository});
  final SettingsRepositoryType repository;
  @override
  Future<Result<Failure, void>> call(ThemeMode input) async {
    final result = await repository.storeThemeMode(
      appThemeModes.reverse[input]!,
    );
    return result.when(
      success: (_) => const Success(null),
      error: Error.new,
    );
  }
}
