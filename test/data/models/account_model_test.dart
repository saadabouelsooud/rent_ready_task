import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rent_ready_task/feature/data/models/account_model.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';


void main() {
  final tAccountModel = AccountModel(name: "saad",accountnumber: "11567",statecode: 1,address1_stateorprovince: "Cairo");

  test(
    'should be a subclass of Account entity',
        () async {
      // assert
      expect(tAccountModel, isA<Account>());
    },
  );
  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
          () async {
        // act
        final result = tAccountModel.toJson();
        // assert
        final expectedMap = {
          "name": "saad",
          "accountnumber": "11567",
          "statecode": 1,
          "address1_stateorprovince":"Cairo"
        };
        expect(result, expectedMap);
      },
    );
  });
}
