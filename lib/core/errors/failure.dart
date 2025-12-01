import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {}

class NetworkFailure extends Failure {}

class CacheFailure extends Failure {}

String mapFailureToMessage(Failure failure) {
  if (failure is ServerFailure) {
    return "Server error occurred. Please try again later.";
  } else if (failure is NetworkFailure) {
    return "No internet connection. Check your network.";
  } else if (failure is CacheFailure) {
    return "Cache error. Please restart the app.";
  }
  return "Unexpected error occurred.";
}
