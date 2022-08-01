import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_task/core/error/exceptions.dart';
import 'package:rent_ready_task/core/error/failure.dart';
import 'package:rent_ready_task/core/network/network_info.dart';
import 'package:rent_ready_task/feature/data/datasources/account_local_datsource.dart';
import 'package:rent_ready_task/feature/data/datasources/account_remote_datasource.dart';
import 'package:rent_ready_task/feature/data/models/account_model.dart';
import 'package:rent_ready_task/feature/data/repositories/account_repositories_impl.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';

class MockRemoteDataSource extends Mock
    implements AccountRemoteDataSource {}

class MockLocalDataSource extends Mock implements AccountLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late AccountRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = AccountRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(()  async {
        assert(await mockNetworkInfo.isConnected);
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getAccounts', () {
    final tAccountList =
    [AccountModel(name: "saad",accountnumber: "11567",statecode: 1,address1_stateorprovince: "Cairo")];
    final List<Account> tAccount = tAccountList;
    

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAccounts())
              .thenAnswer((_) async => tAccountList);
          // act
          final result = await repository.getAccounts();
          // assert
          verify(mockRemoteDataSource.getAccounts());
          expect(result, equals(Right(tAccount)));
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAccounts())
              .thenAnswer((_) async => tAccountList);
          // act
          await repository.getAccounts();
          // assert
          verify(mockRemoteDataSource.getAccounts());
          verify(mockLocalDataSource.cacheAccounts(tAccountList));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getAccounts())
              .thenThrow(ServerException());
          // act
          final result = await repository.getAccounts();
          // assert
          verify(mockRemoteDataSource.getAccounts());
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
            () async {
          // arrange
          when(mockLocalDataSource.getCacheAccounts())
              .thenAnswer((_) async => tAccountList);
          // act
          final result = await repository.getAccounts();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCacheAccounts());
          expect(result, equals(Right(tAccount)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
            () async {
          // arrange
          when(mockLocalDataSource.getCacheAccounts())
              .thenThrow(CacheException());
          // act
          final result = await repository.getAccounts();
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getCacheAccounts());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
