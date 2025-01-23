import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_repository_type.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_usecases.dart';
import 'package:pet_adoption_assignment/features/settings/presentation/settings_cubit.dart';

class MockSettingsRepository extends Mock implements SettingsRepositoryType {}

class MockGetThemeModeUsecase extends Mock implements GetThemeModeUsecase {}

class MockStoreThemeModeUsecase extends Mock implements StoreThemeModeUsecase {}

void main() {
  late MockGetThemeModeUsecase mockGetThemeModeUsecase;
  late MockStoreThemeModeUsecase mockStoreThemeModeUsecase;
  late SettingsCubit settingsCubit;

  setUpAll(() {
    registerFallbackValue(ThemeMode.system);
  });

  setUp(() {
    mockGetThemeModeUsecase = MockGetThemeModeUsecase();
    mockStoreThemeModeUsecase = MockStoreThemeModeUsecase();

    when(() => mockGetThemeModeUsecase.call(null)).thenAnswer(
      (_) async => const Success(ThemeMode.system),
    );

    when(() => mockStoreThemeModeUsecase.call(any())).thenAnswer(
      (_) async => const Success(null),
    );

    settingsCubit = SettingsCubit(
      getThemeModeUsecase: mockGetThemeModeUsecase,
      storeThemeModeUsecase: mockStoreThemeModeUsecase,
    );
  });

  tearDown(() {
    settingsCubit.close();
  });
}
