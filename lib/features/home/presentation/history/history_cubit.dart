import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit({required this.getHomePetsUsecase})
      : super(
          const HistoryInitial(),
        );

  final GetHomePetsUsecase getHomePetsUsecase;

  Future<void> getAdoptedPets() async {
    final pets = await getHomePetsUsecase.call(null);
    pets.when(
      success: (value) {
        final adoptedPets = value.where((element) => element.adopted).toList();
        emit(HistorySuccess(pets: adoptedPets));
      },
      error: (error) => emit(HistoryError(message: error.message)),
    );
  }
}

@immutable
sealed class HistoryState {
  const HistoryState();
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial();
}

final class HistorySuccess extends HistoryState {
  const HistorySuccess({required this.pets});
  final List<PetHome> pets;
}

final class HistoryError extends HistoryState {
  const HistoryError({required this.message});
  final String message;
}
