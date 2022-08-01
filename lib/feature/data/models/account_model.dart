
import 'package:rent_ready_task/feature/domain/entities/account.dart';

class AccountModel extends Account
{
  AccountModel({String? name,String? accountnumber, int? statecode,String? address1_stateorprovince}) : super(name: name,accountnumber: accountnumber,statecode: statecode,address1_stateorprovince: address1_stateorprovince);

  factory AccountModel.fromJsonObject(Map<String,dynamic> json)
  {
    return AccountModel(name: json['name'] ?? "name", accountnumber: json['accountnumber'] ?? "number",statecode: json['statecode'] ,address1_stateorprovince: json['address1_stateorprovince'] ?? "");
  }

  static List<AccountModel> fromJsonList(List<dynamic> jsonList)
  {
    List<AccountModel> list = [];
    for (var element in jsonList) {
      list.add(AccountModel.fromJsonObject(element));
    }
    return list;
  }

  Map<String,dynamic> toJson() {
    return {
      "name": name,
      "accountnumber": accountnumber,
      "statecode": statecode,
      "address1_stateorprovince": address1_stateorprovince
    };
  }
}