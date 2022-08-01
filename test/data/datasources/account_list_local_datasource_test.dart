import 'dart:convert';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_task/core/utils/prefrences_util.dart';
import 'package:rent_ready_task/feature/data/datasources/account_local_datsource.dart';
import 'package:rent_ready_task/feature/data/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:matcher/matcher.dart';


class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  AccountLocalDataSourceImpl dataSource = AccountLocalDataSourceImpl(
    sharedPreferences: mockSharedPreferences,
  );
  setUp(() {
    // mockSharedPreferences = MockSharedPreferences();
    // dataSource = AccountLocalDataSourceImpl(
    //   sharedPreferences: mockSharedPreferences,
    // );
  });

  group('getLastAccountList', () {
    var tAccountList = dataSource.getObjectList(CACHED_ACCOUNTS);
    // final tAccountList =
    // AccountModel.fromJsonList(jsonList);

    test(
      'should return AccountList from SharedPreferences when there cached list',
          () async {
        // arrange
        when(mockSharedPreferences.containsKey(CACHED_ACCOUNTS))
            .thenReturn(true);
        // act
        final result = await dataSource.getCacheAccounts();
        // assert
        verify(mockSharedPreferences.getString(CACHED_ACCOUNTS));
        expect(result, equals(tAccountList));
      },
    );
  });

  group('cacheAccountList', () {
    var tAccountList = dataSource.getObjList<AccountModel>(
        CACHED_ACCOUNTS, (v) => AccountModel.fromJsonObject(v as Map<String, dynamic>));

    test(
      'should call SharedPreferences to cache the data',
          () async {
        // act
        dataSource.cacheAccounts(tAccountList!);
        // assert
        final expectedJsonString = json.encode(tAccountList.toList());
        verify(mockSharedPreferences.setString(CACHED_ACCOUNTS, expectedJsonString,));
      },
    );
  });
}
