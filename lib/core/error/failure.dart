
import 'package:equatable/equatable.dart';

class Failure extends Equatable
{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

// general failure
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';