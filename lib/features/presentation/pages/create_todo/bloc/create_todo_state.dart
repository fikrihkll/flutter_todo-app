part of 'create_todo_bloc.dart';

@immutable
abstract class CreateTodoState extends Equatable {}

class CreateTodoInitial extends CreateTodoState {
  @override
  List<Object?> get props => [];
}

class CreateTodoLoading extends CreateTodoState {
  @override
  List<Object?> get props => [];
}

class CreateTodoSuccess extends CreateTodoState {
  final int result;

  CreateTodoSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class CreateTodoError extends CreateTodoState {
  final String message;

  CreateTodoError(this.message);

  @override
  List<Object?> get props => [message];
}