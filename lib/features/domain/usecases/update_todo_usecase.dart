import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase implements UseCase<int, UpdateTodoUsecaseParams>{

  final TodoRepository repository;

  UpdateTodoUsecase({required this.repository});

  @override
  Future<Either<Failure, int>> call(UpdateTodoUsecaseParams params) async {
    return await repository.updateTodo(params.model);
  }

}

class UpdateTodoUsecaseParams {
  final TodoModel model;

  UpdateTodoUsecaseParams(this.model);
}