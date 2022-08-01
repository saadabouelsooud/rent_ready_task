import 'package:dartz/dartz.dart';
import 'package:rent_ready_task/core/error/exceptions.dart';
import 'package:rent_ready_task/core/error/failure.dart';
import 'package:rent_ready_task/core/network/network_info.dart';
import 'package:rent_ready_task/feature/data/datasources/account_local_datsource.dart';
import 'package:rent_ready_task/feature/data/datasources/account_remote_datasource.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';
import 'package:rent_ready_task/feature/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository
{

  final AccountRemoteDataSource? remoteDataSource;
  final AccountLocalDataSource? localDataSource;
  final NetworkInfo? networkInfo;

  AccountRepositoryImpl({this.remoteDataSource,this.localDataSource,this.networkInfo});

  @override
  Future<Either<Failure, List<Account>>> getAccounts() async {
    if (await networkInfo!.isConnected)
    {
      try {
        final accounts = await remoteDataSource!.getAccounts();
        localDataSource!.cacheAccounts(accounts);
        return Right(accounts);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else
    {
      try{
        final accounts = await localDataSource!.getCacheAccounts();
        return Right(accounts);
      } on CacheException{return Left(CacheFailure());}
    }

  }

}