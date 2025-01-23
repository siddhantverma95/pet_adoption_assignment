import 'package:pet_adoption_assignment/core/config/failure.dart';

sealed class Result<E extends Failure, S> {
  const Result();

  R when<R>({
    required R Function(S value) success,
    required R Function(Failure error) error,
  }) {
    if (this is Success<E, S>) {
      return success((this as Success<E, S>).value);
    } else if (this is Error<E, S>) {
      return error((this as Error<E, S>).error);
    } else {
      return error(const Failure(message: 'Unknown Result'));
    }
  }
}

final class Success<E extends Failure, S> extends Result<E, S> {
  const Success(this.value);
  final S value;
}

final class Error<E extends Failure, S> extends Result<E, S> {
  const Error(this.error);
  final E error;
}
