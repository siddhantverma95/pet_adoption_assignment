// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/core/di/cache_module.dart';
import 'package:pet_adoption_assignment/core/di/config_module.dart';
import 'package:pet_adoption_assignment/core/di/repository_module.dart';
import 'package:pet_adoption_assignment/core/di/usecase_module.dart';
import 'package:pet_adoption_assignment/features/home/presentation/history/history_cubit.dart';
import 'package:pet_adoption_assignment/features/home/presentation/home/home_cubit.dart';
import 'package:pet_adoption_assignment/features/settings/presentation/settings_cubit.dart';

class AppProvider extends StatefulWidget {
  const AppProvider({
    required this.child,
    super.key,
  });

  final Widget Function(BuildContext context) child;
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider>
    with ConfigModule, CacheModule, RepositoryModule, UsecaseModule {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => storeHomeUsecase),
        RepositoryProvider(create: (context) => homeUsecase),
        RepositoryProvider(create: (context) => themeModeUsecase),
        RepositoryProvider(create: (context) => storeThemeUsecase),
        RepositoryProvider(create: (context) => adoptedPetsUsecase),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SettingsCubit(
              getThemeModeUsecase: themeModeUsecase,
              storeThemeModeUsecase: storeThemeUsecase,
            ),
          ),
          BlocProvider(
            create: (context) => HomeCubit(
              getHomePetsUsecase: homeUsecase,
              searchPetsUsecase: searchPetUsecase,
            )..getHomePets(),
          ),
          BlocProvider(
            create: (context) => HistoryCubit(
              getHomePetsUsecase: homeUsecase,
            )..getAdoptedPets(),
          ),
        ],
        child: Builder(
          builder: (context) {
            return widget.child(context);
          },
        ),
      ),
    );
  }
}
