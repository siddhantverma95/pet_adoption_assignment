import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/home/data/response/pet_response.dart';

abstract class HomeRepositoryType {
  Future<Result<Failure, List<PetResponse>>> getHomeData();
  Future<Result<Failure, void>> storeHomeData(List<dynamic> petList);
}
