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
      success: (result) {
        final pets = HomeMappers.mapPetToHome(result)
          ..sort(
            (a, b) => a.name.compareTo(b.name),
          );
        return Success(pets);
      },
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

class SearchPetsUsecase extends CoreUsecase<List<PetHome>, String> {
  SearchPetsUsecase({required this.homeRepository});

  final HomeRepositoryType homeRepository;
  @override
  Future<Result<Failure, List<PetHome>>> call(String input) async {
    final pets = await homeRepository.getHomeData();
    return pets.when(
      success: (value) {
        value.sort((a, b) => a.name.compareTo(b.name));
        final searchedPets = HomeMappers.mapPetToHome(value)
            .where(
              (element) =>
                  element.name.toLowerCase().contains(input.toLowerCase()),
            )
            .toList();
        return Success(searchedPets);
      },
      error: Error.new,
    );
  }
}

class AdoptPetUsecase extends CoreUsecase<PetHome, PetHome> {
  AdoptPetUsecase({required this.homeRepository});

  final HomeRepositoryType homeRepository;

  @override
  Future<Result<Failure, PetHome>> call(PetHome input) async {
    final pets = await homeRepository.getHomeData();
    return pets.when(
      success: (value) async {
        final homePets = HomeMappers.mapPetToHome(value);
        final adoptedPet = input.copyWith(adopted: true);
        final list = List<PetHome>.from(homePets)
          ..removeWhere((element) => element.id == input.id)
          ..add(adoptedPet);
        final result = await homeRepository.storeHomeData(list);
        return result.when(
          success: (_) => Success(adoptedPet),
          error: Error.new,
        );
      },
      error: Error.new,
    );
  }
}
