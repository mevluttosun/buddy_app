import 'package:buddy/features/dog/domain/entities/dog_breeds_entity.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteDogState extends Equatable {
  const RemoteDogState();

  @override
  List<Object> get props => [];
}

class RemoteDogInitial extends RemoteDogState {}

class RemoteDogLoading extends RemoteDogState {}

class RemoteDogLoaded extends RemoteDogState {
  final List<DogBreedEntity> data;

  const RemoteDogLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class RemoteDogError extends RemoteDogState {
  final DioException message;

  const RemoteDogError(this.message);

  @override
  List<Object> get props => [message];
}
