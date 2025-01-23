import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({
    required this.storeHomePetsUsecase,
    required this.getHomePetsUsecase,
    required this.pet,
  }) : super(DetailInitial(pet));

  final StoreHomePetsUsecase storeHomePetsUsecase;
  final GetHomePetsUsecase getHomePetsUsecase;
  final PetHome pet;

  Future<void> storeHomePets(PetHome pet) async {
    emit(DetailLoading(pet));
    final pets = await getHomePetsUsecase.call(null);
    await pets.when(
      success: (value) async {
        final adoptedPet = pet.copyWith(adopted: true);
        final list = List<PetHome>.from(value)
          ..removeWhere((element) => element.id == pet.id)
          ..add(adoptedPet);
        final result = await storeHomePetsUsecase.call(list);
        result.when(
          success: (_) {
            emit(DetailSuccess(adoptedPet));
          },
          error: (error) => emit(DetailError(pet, message: error.message)),
        );
      },
      error: (error) {
        emit(DetailError(pet, message: error.message));
      },
    );
  }
}

@immutable
sealed class DetailState {
  const DetailState(this.pet);
  final PetHome pet;
}

final class DetailInitial extends DetailState {
  const DetailInitial(super.pet);
}

final class DetailLoading extends DetailState {
  const DetailLoading(super.pet);
}

final class DetailSuccess extends DetailState {
  const DetailSuccess(super.pet);
}

final class DetailError extends DetailState {
  const DetailError(super.pet, {required this.message});
  final String message;
}
