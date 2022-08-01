import 'package:dartz/dartz.dart';
import 'package:rent_ready_task/core/error/failure.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';

abstract class AccountRepository
{
  Future<Either<Failure,List<Account>>> getAccounts();
}