import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AccountListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAccountList extends AccountListEvent {
  GetAccountList({required this.query});

  final String query;
  @override
  List<Object> get props => [query];
}