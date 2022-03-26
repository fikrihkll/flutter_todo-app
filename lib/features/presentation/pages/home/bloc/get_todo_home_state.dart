part of 'get_todo_home_bloc.dart';

@immutable
abstract class GetTodoHomeState extends Equatable {}

class GetTodoHomeInitial extends GetTodoHomeState {
  @override
  List<Object?> get props => [];

}

class GetTodoHomeLoading extends GetTodoHomeState {
  @override
  List<Object?> get props => [];
}

class GetTodoHomeLoaded extends GetTodoHomeState {
  final List<Todo> listData;

  GetTodoHomeLoaded(this.listData);

  @override
  List<Object?> get props => [...listData];
}

class GetTodoHomeError extends GetTodoHomeState {
  final String message;

  GetTodoHomeError(this.message);

  @override
  List<Object?> get props => [message];
}
