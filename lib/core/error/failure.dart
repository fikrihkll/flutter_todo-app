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

const unexpectedDefaultMessage = 'There is something wrong, please report this issue, thank you :)';

String getErrorMessage(Failure failure){
  if(failure is ServerFailure){
    return failure.message;
  }else if(failure is CacheFailure){
    return failure.message;
  }else if(failure is UnexpectedFailure){
    return unexpectedDefaultMessage;
  }else{
    return unexpectedDefaultMessage;
  }
}