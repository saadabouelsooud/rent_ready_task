import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:rent_ready_task/core/error/failure.dart';
import 'package:rent_ready_task/core/usecases/usecase.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';
import 'package:rent_ready_task/feature/domain/usecases/get_accounts.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_event.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_state.dart';


const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class AccountListBloc extends Bloc<AccountListEvent, AccountListState> {
  final GetAccounts? getAccounts;
  late Future<Either<Failure, List<Account>>> accountList;

  AccountListBloc({
    this.getAccounts,
  })  : assert(getAccounts != null),
        super(Empty()) {
    on<GetAccountList>(
      (event, emit) async {
        await _onAccountListEvent(event, emit);
      },
    );
  }

  Future<void> _onAccountListEvent(
      GetAccountList event,
    Emitter<AccountListState> emit,
  ) async {
    emit(
      Loading(),
    );


    final accountList = await getAccounts!(NoParams());


    accountList.fold(
          (error) {
        Logger().e(
          "error: $error, ${error.toString()} |  | ${(error.toString() is Error) ? (error.toString() as Error) : ''}",
        );
        emit(
          Error(error.toString()),
        );
      },
          (accounts) {
            Logger().i("search query: ${event.query}");
            List<Account>? results;
            if(event.query.isNotEmpty) {
              switch(event.query)
              {
                case 'No Filter':
                  results = accounts;
                  break;

                case 'StateCode = 0':
                  results = accounts.where((element) => element.statecode == 0 ).toList();
                  break;

                case 'StateCode = else':
                  results = accounts.where((element) => element.statecode != 0 ).toList();
                  break;

                case 'StateOrProvince is empty':
                  results = accounts.where((element) => (element.address1_stateorprovince?.isEmpty)! ).toList();
                  break;

                case 'StateOrProvince is not empty':
                  results = accounts.where((element) => (element.address1_stateorprovince?.isNotEmpty)! ).toList();
                  break;

                default: // search by name and account number
                  results = accounts.where((element) => ( (element.accountnumber?.toLowerCase().contains(event.query))!  || (element.name?.toLowerCase().contains(event.query))! ) ).toList();

              }
            }
            emit(
              Loaded(event.query.isEmpty ? accounts : results!),
        );
      },
    );
  }

  @override
  AccountListState get initialState => Loading();


  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

}
