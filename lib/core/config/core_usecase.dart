import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/logger/app_logger.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';

abstract class CoreUsecase<Type, Params> {
  CoreUsecase() {
    AppLog.usecase(runtimeType);
  }
  Future<Result<Failure, Type>> call(Params input);
}
