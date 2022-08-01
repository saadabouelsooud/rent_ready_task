
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_task/core/usecases/usecase.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';
import 'package:rent_ready_task/feature/domain/repositories/account_repository.dart';
import 'package:rent_ready_task/feature/domain/usecases/get_accounts.dart';

class MockAccountRepository extends Mock
    implements AccountRepository {}

void main() {
  late GetAccounts usecase;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    usecase = GetAccounts(mockAccountRepository);
  });

  final tAccountList = [Account(name: "saad",accountnumber: "11567",statecode: 1,address1_stateorprovince: "Cairo")];

  test(
    'should get account list from the repository',
        () async {
      // arrange
      when(mockAccountRepository.getAccounts())
          .thenAnswer((_) async => Right(tAccountList));
      // act
      final result = await usecase(NoParams());
      // assert
      expect(result, Right(tAccountList));
      verify(mockAccountRepository.getAccounts());
      verifyNoMoreInteractions(mockAccountRepository);
    },
  );
}
