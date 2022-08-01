

import 'package:rent_ready_task/core/error/failure.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class UnknownException implements Exception {}

Exception mapFailureToException(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return ServerException();
    case CacheFailure:
      return CacheException();
    default:
      return UnknownException();
  }
}