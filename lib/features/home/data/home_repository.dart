import 'package:pet_adoption_assignment/core/cache/cache_client_type.dart';
import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/home/data/response/pet_response.dart';
import 'package:pet_adoption_assignment/features/home/domain/home_repository_type.dart';

class HomeRepository extends HomeRepositoryType {
  HomeRepository({required this.cache});

  final CacheClientType cache;
  static const String homeDataKey = 'petDataKey';

  @override
  Future<Result<Failure, List<PetResponse>>> getHomeData() async {
    final petData = cache.getStoredList(homeDataKey);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (petData != null) {
      final pets = petData
          .map((e) => PetResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      return Success(pets);
    } else {
      return const Error(Failure(message: 'No data found'));
    }
  }

  @override
  Future<Result<Failure, void>> storeHomeData(List<dynamic> petList) async {
    try {
      cache.storeList(homeDataKey, petList);
      return const Success(null);
    } catch (e) {
      return Error(Failure(message: e.toString()));
    }
  }
}
