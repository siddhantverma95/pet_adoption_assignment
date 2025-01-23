import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/app/app_provider.dart';
import 'package:pet_adoption_assignment/core/app/app_router.dart';
import 'package:pet_adoption_assignment/core/config/theme/app_theme.dart';
import 'package:pet_adoption_assignment/features/settings/presentation/settings_cubit.dart';
import 'package:pet_adoption_assignment/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: (context) {
        final themeMode = context.select(
          (SettingsCubit value) => value.state.themeMode,
        );
        return MaterialApp(
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeMode,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: splashRoute,
        );
      },
    );
  }
}
