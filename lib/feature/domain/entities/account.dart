
import 'package:equatable/equatable.dart';
class Account extends Equatable
{
  final String? name;
  final String? accountnumber;
  final int? statecode;
  final String? address1_stateorprovince;



  const Account({this.name,this.accountnumber,this.statecode,this.address1_stateorprovince});

  @override
  // TODO: implement props
  List<Object?> get props => [name,accountnumber,statecode,address1_stateorprovince];

}