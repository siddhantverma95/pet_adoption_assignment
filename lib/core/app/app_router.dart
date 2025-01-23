import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/image_interaction.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/presentation/detail/detail_page.dart';
import 'package:pet_adoption_assignment/features/home/presentation/detail/image_interaction_widget.dart';
import 'package:pet_adoption_assignment/features/home/presentation/home/home_cubit.dart';
import 'package:pet_adoption_assignment/features/home/presentation/home/home_page.dart';
import 'package:pet_adoption_assignment/features/home/presentation/splash/splash.dart';

const splashRoute = '/';
const homeRoute = '/home';
const detailRoute = '/detail';
const historyRoute = '/history';
const imageInteractionRoute = '/imageInteraction';

class AppRouter {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const SplashScreen();
          },
        );
      case homeRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const HomePage();
          },
        );
      case detailRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return DetailProvider(
              pet: settings.arguments! as PetHome,
              homeCubit: context.read<HomeCubit>(),
            );
          },
        );
      case imageInteractionRoute:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return ImageInteractionWidget(
              meta: settings.arguments! as ImageInteraction,
            );
          },
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const HomePage();
          },
        );
    }
  }
}
