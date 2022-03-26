import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

class InsertTodoUsecase implements UseCase<int, InsertTodoUsecaseParams>{

  final TodoRepository repository;
  InsertTodoUsecase({required this.repository});

  @override
  Future<Either<Failure, int>> call(InsertTodoUsecaseParams params) async {
    return await repository.insertTodo(params.model);
  }

}

class InsertTodoUsecaseParams {
  final TodoModel model;

  InsertTodoUsecaseParams(this.model);
}