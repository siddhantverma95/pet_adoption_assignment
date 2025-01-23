import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.getHomePetsUsecase}) : super(const HomeInitial(0));

  final GetHomePetsUsecase getHomePetsUsecase;

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> getHomePets() async {
    final result = await getHomePetsUsecase.call(null);

    result.when(
      success: (data) {
        final sortedData = data..sort((a, b) => a.name.compareTo(b.name));
        emit(HomeSuccess(state.index, sortedData, sortedData));
      },
      error: (error) => emit(HomeError(state.index, error.message)),
    );
  }

  Future<void> searchPets(String query) async {
    final currentState = state;
    if (currentState is HomeSuccess) {
      final searchedPets = currentState.pets
          .where(
            (element) =>
                element.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      emit(HomeSuccess(state.index, currentState.pets, searchedPets));
    }
  }
}

@immutable
sealed class HomeState {
  const HomeState(this.index);
  final int index;

  HomeState copyWith({int? index}) {
    throw UnimplementedError(
      'copyWith() has not been implemented for HomeState',
    );
  }
}

final class HomeInitial extends HomeState {
  const HomeInitial(super.index);

  @override
  HomeInitial copyWith({int? index}) {
    return HomeInitial(index ?? this.index);
  }
}

final class HomeSuccess extends HomeState {
  const HomeSuccess(super.index, this.pets, this.searchedPets);
  final List<PetHome> pets;
  final List<PetHome> searchedPets;

  @override
  HomeSuccess copyWith({
    int? index,
    List<PetHome>? pets,
    List<PetHome>? searchedPets,
  }) {
    return HomeSuccess(
      index ?? this.index,
      pets ?? this.pets,
      searchedPets ?? this.searchedPets,
    );
  }
}

final class HomeError extends HomeState {
  const HomeError(super.index, this.message);
  final String message;

  @override
  HomeError copyWith({int? index, String? message}) {
    return HomeError(
      index ?? this.index,
      message ?? this.message,
    );
  }
}
