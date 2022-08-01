import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_bloc.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_event.dart';
import 'package:rent_ready_task/feature/presentation/bloc/account_list_state.dart';
import 'package:rent_ready_task/feature/presentation/view/account_item.dart';

class AccountList extends StatefulWidget
{
  const AccountList({Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    context.read<AccountListBloc>().add(
      GetAccountList(query: ""),
    );
    return buildBody(context);
  }

  BlocBuilder buildBody(BuildContext context) {
    return BlocBuilder<AccountListBloc, AccountListState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is Error) {
          _buildErrorWidget();
        }
        if(state is Empty)
          {
              return const Center(child: Text('No Account'));
          }

        if(state is Loaded)
          {
            if (state.accounts.isEmpty)
              {
                return const Center(child: Text('No Account'));
              }
            else
              {
                return SafeArea(
                    child: ListView.builder(
                        itemCount: state.accounts.length,
                        itemBuilder: (BuildContext context, int index) {
                          var currentAccount = state.accounts.elementAt(index);
                          return AccountItem(currentAccount);
                        }
                    ));
              }
          }

        return const Center(child: Text('No Account'));

      },
    );
  }

  Widget _buildErrorWidget() {
    return const Center(child: Text('An error has occurred!'));
  }
}