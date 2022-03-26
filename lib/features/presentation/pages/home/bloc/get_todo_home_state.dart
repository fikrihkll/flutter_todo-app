part of 'get_todo_home_bloc.dart';

@immutable
abstract class GetTodoHomeState {}

class GetTodoHomeInitial extends GetTodoHomeState {}

class GetTodoHomeLoading extends GetTodoHomeState {}

class GetTodoHomeLoaded extends GetTodoHomeState {
  final List<Todo> listData;

  GetTodoHomeLoaded(this.listData);
}

class GetTodoHomeError extends GetTodoHomeState {
  final String message;

  GetTodoHomeError(this.message);
}
