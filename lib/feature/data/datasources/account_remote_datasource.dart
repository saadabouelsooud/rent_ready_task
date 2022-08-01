import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rent_ready_task/core/error/exceptions.dart';
import 'package:rent_ready_task/core/network/api/api.dart';
import 'package:rent_ready_task/core/network/api/http_api.dart';
import 'package:rent_ready_task/feature/data/models/account_model.dart';

abstract class AccountsApi{
  Future<Response?> callAPI(String token);
  Future<Response?> getToken();
}

abstract class AccountRemoteDataSource
{
  Future<List<AccountModel>> getAccounts();
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource, AccountsApi
{

  @override
  Future<List<AccountModel>> getAccounts() async {
    try {
      var tokenResponse = await getToken();
      String token = tokenResponse!.data["access_token"];
      var response = await callAPI(token);
      var data = response!.data;
      return AccountModel.fromJsonList(data["value"]);
    } on IOException
    {
      throw ServerException();
    }
  }

  @override
  Future<Response?> callAPI(String token) {
    return HttpApi.request(EndPoint.accounts,false,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {Header.authorization: "Bearer $token"});
  }

  @override
  Future<Response?> getToken() {
    var formData = FormData.fromMap({
    "grant_type":Constants.grantType,
    "client_secret":Constants.clientSecret,
    "client_id":Constants.clientId,
    "scope": Constants.scope
    });
    return HttpApi.request(EndPoint.getToken,true,body: formData,
        type: RequestType.Post, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }

}