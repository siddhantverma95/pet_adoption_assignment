import 'dart:async';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:pet_adoption_assignment/bootstrap.dart';
import 'package:pet_adoption_assignment/core/app/view/app.dart';
import 'package:pet_adoption_assignment/core/config/app_config.dart';
import 'package:pet_adoption_assignment/core/environment/environment.dart';

Future<void> main() async {
  await Hive.initFlutter();
  final hiveBox =
      await Hive.openBox<String>(Environment.development().hiveBoxName);
  AppConfig(env: Environment.development(), hiveBox: hiveBox);
  unawaited(
    bootstrap(
      () => const App(),
      hiveBox,
    ),
  );
}
