import 'package:equatable/equatable.dart';

abstract class RemoteDogEvent extends Equatable {
  const RemoteDogEvent();

  @override
  List<Object> get props => [];
}

class RemoteDogFetch extends RemoteDogEvent {}

class RemoteDogSearch extends RemoteDogEvent {
  final String query;

  const RemoteDogSearch(this.query);

  @override
  List<Object> get props => [query];
}
