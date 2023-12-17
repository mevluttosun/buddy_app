import 'package:equatable/equatable.dart';

abstract class RemoteDogEvent extends Equatable {
  const RemoteDogEvent();

  @override
  List<Object> get props => [];
}

class RemoteDogFetch extends RemoteDogEvent {}
