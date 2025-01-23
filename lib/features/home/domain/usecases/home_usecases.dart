import 'package:pet_adoption_assignment/core/config/core_usecase.dart';
import 'package:pet_adoption_assignment/core/config/failure.dart';
import 'package:pet_adoption_assignment/core/utils/result.dart';
import 'package:pet_adoption_assignment/features/home/domain/home_mappers.dart';
import 'package:pet_adoption_assignment/features/home/domain/home_repository_type.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';

class GetHomePetsUsecase extends CoreUsecase<List<PetHome>, void> {
  GetHomePetsUsecase({required this.homeRepository});

  final HomeRepositoryType homeRepository;

  @override
  Future<Result<Failure, List<PetHome>>> call(void input) async {
    final result = await homeRepository.getHomeData();

    return result.when(
      success: (result) => Success(HomeMappers.mapPetToHome(result)),
      error: Error.new,
    );
  }
}

class StoreHomePetsUsecase extends CoreUsecase<void, List<PetHome>> {
  StoreHomePetsUsecase({required this.homeRepository});

  final HomeRepositoryType homeRepository;

  @override
  Future<Result<Failure, void>> call(List<PetHome> input) async {
    final result = await homeRepository.storeHomeData(input);

    return result.when(
      success: (_) => const Success(null),
      error: Error.new,
    );
  }
}
