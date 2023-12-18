import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class DataState<T> extends Equatable {
  final T? data;
  final DioException? error;
  final Error? connectionError;
  const DataState({this.data, this.error, this.connectionError});

  @override
  List<Object?> get props => [data, error, connectionError];
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(DioException error) : super(error: error);
}

class ConnectionFailure<T> extends DataState<T> {
  const ConnectionFailure(Error error) : super(connectionError: error);
}
