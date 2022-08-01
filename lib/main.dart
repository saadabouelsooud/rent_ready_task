import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:rent_ready_task/feature/domain/repositories/account_repository.dart';
import 'package:rent_ready_task/feature/domain/usecases/get_accounts.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_bloc.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_event.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_state.dart';
import 'package:rent_ready_task/feature/presentation/view/accounts_list.dart';
import 'package:rent_ready_task/injection_container.dart';
import 'injection_container.dart' as di;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  return BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      runApp(const MyApp());
    },
  );
  }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<AccountListBloc>(),
      child: MaterialApp(
        title: 'Rent Ready Task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  // Initial Selected Value
  String dropdownvalue = 'No Filter';

  // List of items in our dropdown menu
  var items = [
    'No Filter',
    'StateCode = 0',
    'StateCode = else',
    'StateOrProvince is empty',
    'StateOrProvince is not empty',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Rent Ready Task"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    textAlignVertical: TextAlignVertical.top,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(6.0),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffd4d4d5)),
                          borderRadius: BorderRadius.circular(8.0)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffd4d4d5)),
                          borderRadius: BorderRadius.circular(8.0)),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueGrey,width: 2),
                        borderRadius: BorderRadius.circular(8.0),),
                      hintText: "Search",
                    ),
                    onChanged: (value){
                      context.read<AccountListBloc>().add(
                        GetAccountList(query: value),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10,),
                BlocBuilder<AccountListBloc,AccountListState>(builder: (context, state){
                  return DropdownButton(
                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.filter_alt),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      Logger().i("dropdown selected is : $newValue");
                      dropdownvalue = newValue! ;
                      context.read<AccountListBloc>().add(
                        GetAccountList(query: newValue),
                      );
                    },
                  );
                } )
              ],
            ),
          ),
          const Expanded(child: Padding(
            padding: EdgeInsets.all(8.0),
            child: AccountList(),
          )),
        ],
      ),
    );
  }

}
