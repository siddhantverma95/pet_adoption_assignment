import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption_assignment/features/home/domain/models/pet_home.dart';
import 'package:pet_adoption_assignment/features/home/domain/usecases/home_usecases.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.getHomePetsUsecase,
    required this.searchPetsUsecase,
  }) : super(const HomeInitial(0));

  final GetHomePetsUsecase getHomePetsUsecase;
  final SearchPetsUsecase searchPetsUsecase;

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  Future<void> getHomePets() async {
    final result = await getHomePetsUsecase.call(null);

    result.when(
      success: (data) {
        emit(HomeSuccess(state.index, data));
      },
      error: (error) => emit(HomeError(state.index, error.message)),
    );
  }

  Future<void> searchPets(String query) async {
    final currentState = state;
    if (currentState is HomeSuccess) {
      final searchResult = await searchPetsUsecase.call(query);
      searchResult.when(
        success: (value) => emit(HomeSuccess(state.index, value)),
        error: (error) => emit(HomeError(state.index, error.message)),
      );
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
  const HomeSuccess(
    super.index,
    this.pets,
  );
  final List<PetHome> pets;

  @override
  HomeSuccess copyWith({
    int? index,
    List<PetHome>? pets,
  }) {
    return HomeSuccess(
      index ?? this.index,
      pets ?? this.pets,
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
