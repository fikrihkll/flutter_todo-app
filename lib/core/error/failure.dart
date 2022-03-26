import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{

  Failure([List properties = const<dynamic>[]]);

}

class ServerFailure extends Failure{

  final String message;

  ServerFailure(this.message);

  List<Object?> get props => [message];
}
class CacheFailure extends Failure{

  final String message;

  CacheFailure(this.message);

  List<Object?> get props => [message];
}
class UnexpectedFailure extends Failure{

  final String message;

  UnexpectedFailure(this.message);

  List<Object?> get props => [message];
}