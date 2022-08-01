import 'package:equatable/equatable.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';

abstract class AccountListState extends Equatable
{
  @override
  List<Object> get props => [];
}

class Empty extends AccountListState {
  Empty copyWith()
  {return Empty();}
}

class Loading extends AccountListState{

  Loading copyWith()
  {return Loading();}
}

class Loaded extends AccountListState
{
  final List<Account> accounts;

  Loaded(this.accounts);

  Loaded copyWith(List<Account> accounts)
  {
    return Loaded(accounts);
  }

  @override
  List<Object> get props => [accounts];
}

class Error extends AccountListState {
  final String message;

  Error(this.message);

  Error copyWith(String message)
  {
    return Error(message);
  }

  @override
  List<Object> get props => [message];
}