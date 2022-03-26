import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/entities/todo.dart';

abstract class TodoRepository{
  Future<Either<Failure, int>> insertTodo(TodoModel model);
  Future<Either<Failure, int>> updateTodo(TodoModel model);
  Future<Either<Failure, List<Todo>>> getTodoList();
  Future<Either<Failure, void>> deleteTodo(int id);
}