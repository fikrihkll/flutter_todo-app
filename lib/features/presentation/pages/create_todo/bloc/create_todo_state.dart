part of 'create_todo_bloc.dart';

@immutable
abstract class CreateTodoState {}

class CreateTodoInitial extends CreateTodoState {}

class CreateTodoLoading extends CreateTodoState {}

class CreateTodoSuccess extends CreateTodoState {
  final int result;

  CreateTodoSuccess(this.result);
}

class CreateTodoError extends CreateTodoState {
  final String message;

  CreateTodoError(this.message);
}