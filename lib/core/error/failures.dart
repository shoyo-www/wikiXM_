import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);

}

class ServerFailure extends Failure {
  final String? message;
  final Map<String, dynamic>? errors;

  const ServerFailure(this.message, {this.errors});

  @override
  List<Object?> get props => [message, errors];
}

class NoDataFailure extends Failure {
  @override
  List<Object?> get props => [""];
}