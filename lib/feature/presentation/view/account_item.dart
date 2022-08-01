import 'package:flutter/material.dart';
import 'package:rent_ready_task/feature/domain/entities/account.dart';

class AccountItem extends StatelessWidget
{
  final Account accountModel;
  AccountItem(this.accountModel);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
              ),
            ),
            Container (
              // width: 100,
              child: Column (
                children: <Widget>[
                  Text (accountModel.name!, style: TextStyle(fontWeight: FontWeight.bold),),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0,top: 2),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text("Account Number"),
                            const SizedBox(width: 20,),
                            Text(accountModel.accountnumber ?? "null"),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Status Code"),
                            const SizedBox(width: 20,),
                            Text(accountModel.statecode!.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("State Or province"),
                            const SizedBox(width: 20,),
                            Text(accountModel.address1_stateorprovince ?? "null"),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}