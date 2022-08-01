import 'package:dartz/dartz.dart';
import 'package:rent_ready_task/core/error/failure.dart';
import 'package:rent_ready_task/core/usecases/usecase.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';
import 'package:rent_ready_task/feature/domain/repositories/account_repository.dart';


class GetAccounts implements UseCase<List<Account>,NoParams>
{
  final AccountRepository repository;

  GetAccounts(this.repository);

  // callable classes
  @override
  Future<Either<Failure, List<Account>>> call(NoParams noParams) async {
    return await repository.getAccounts();
  }
}