import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_assignment/features/settings/domain/settings_usecases.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required this.getThemeModeUsecase,
    required this.storeThemeModeUsecase,
  }) : super(const SettingsInitial(ThemeMode.system)) {
    _getThemeMode();
  }

  final GetThemeModeUsecase getThemeModeUsecase;
  final StoreThemeModeUsecase storeThemeModeUsecase;

  Future<void> _getThemeMode() async {
    final result = await getThemeModeUsecase.call(null);
    result.when(
      success: (value) {
        emit(state.copyWith(themeMode: value));
      },
      error: (error) => emit(
        SettingsError(state.themeMode, message: 'Error getting theme'),
      ),
    );
  }

  Future<void> changeTheme(ThemeMode themeMode) async {
    final result = await storeThemeModeUsecase.call(themeMode);
    result.when(
      success: (_) {
        emit(state.copyWith(themeMode: themeMode));
      },
      error: (error) => emit(
        SettingsError(state.themeMode, message: 'Error changing theme'),
      ),
    );
  }
}

@immutable
sealed class SettingsState {
  const SettingsState(this.themeMode);
  final ThemeMode themeMode;

  SettingsState copyWith({ThemeMode? themeMode}) {
    throw UnimplementedError(
      'copyWith() has not been implemented for SettingsState',
    );
  }
}

final class SettingsInitial extends SettingsState {
  const SettingsInitial(super.themeMode);

  @override
  SettingsInitial copyWith({ThemeMode? themeMode}) {
    return SettingsInitial(themeMode ?? this.themeMode);
  }
}

final class SettingsError extends SettingsState {
  const SettingsError(super.themeMode, {required this.message});
  final String message;

  @override
  SettingsError copyWith({ThemeMode? themeMode}) {
    return SettingsError(themeMode ?? this.themeMode, message: message);
  }
}
