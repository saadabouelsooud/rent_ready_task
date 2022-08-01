import 'dart:convert';

import 'package:rent_ready_task/core/error/exceptions.dart';
import 'package:rent_ready_task/feature/data/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AccountLocalDataSource
{
  Future<void> cacheAccounts(List<AccountModel> accounts);
  Future<List<AccountModel>> getCacheAccounts();

}

const CACHED_ACCOUNTS = 'Accounts';


class AccountLocalDataSourceImpl implements AccountLocalDataSource
{
  final SharedPreferences? sharedPreferences;

  AccountLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<void> cacheAccounts(List<AccountModel> accounts) {
    return putObjectList(CACHED_ACCOUNTS, accounts);
  }

  @override
  Future<List<AccountModel>> getCacheAccounts() {
    var accounts = getObjList<AccountModel>(
        CACHED_ACCOUNTS, (v) => AccountModel.fromJsonObject(v as Map<String, dynamic>));
    if(accounts != null)
    {
      return Future.value(accounts);
    }
    else
    {
      throw CacheException();
    }
  }

  List<T>? getObjList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    })?.toList();
    return list ?? defValue;
  }

  List<Map>? getObjectList(String key) {
    List<String>? dataList = sharedPreferences?.getStringList(key);
    return dataList?.map((value) {
      Map _dataMap = json.decode(value);
      return _dataMap;
    })?.toList();
  }

  Future<bool?> putObjectList(String key, List<Object> list) async {
    List<String>? _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return sharedPreferences!.setStringList(key, _dataList);
  }

}