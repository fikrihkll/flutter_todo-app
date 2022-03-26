part of 'create_todo_bloc.dart';

@immutable
abstract class CreateTodoEvent {}

class CreateNewTodoEvent extends CreateTodoEvent {
  TodoModel model;

  CreateNewTodoEvent(this.model);
}