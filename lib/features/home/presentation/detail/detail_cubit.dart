import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pet_adoption_assignment/core/logger/app_logger.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit({
    required this.adoptPetUsecase,
    required this.pet,
  }) : super(DetailInitial(pet));

  final AdoptPetUsecase adoptPetUsecase;
  final PetHome pet;

  Future<void> adoptPet(PetHome pet) async {
    emit(DetailLoading(pet));
    final result = await adoptPetUsecase.call(pet);

    result.when(
      success: (_) {
        AppLog.debug('Pet adopted: ${pet.adopted}');
        emit(DetailSuccess(pet));
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
