
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_task/core/usecases/usecase.dart';
import 'package:rent_ready_task/feature/data/repositories/account_repositories_impl.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';
import 'package:rent_ready_task/feature/domain/usecases/get_accounts.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_bloc.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_event.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_state.dart';


class MockGetAccounts extends Mock implements GetAccounts {}




void main() {
  late AccountListBloc bloc;
  late MockGetAccounts mockGetAccounts;
  AccountRepositoryImpl repository;


  setUp(() {
    mockGetAccounts = MockGetAccounts();
    bloc = AccountListBloc(
      getAccounts: mockGetAccounts,
    );
  });

  test('initialState should be Empty', () {
    // assert
    expect(bloc.initialState, equals(Empty()));
  });


  group('Get Account List', () {
    final tAccountList = [Account(name: "saad",accountnumber: "11567",statecode: 1,address1_stateorprovince: "Cairo")];

    test(
      'should get data from the use case',
          () async {
        // arrange
        when(mockGetAccounts(NoParams()))
            .thenAnswer((_) async => Right(tAccountList));
        // act
        bloc.add(GetAccountList(query: ''));
        await untilCalled(mockGetAccounts(NoParams()));
        // assert
        verify(mockGetAccounts(NoParams()));
      },
    );
  });
}
