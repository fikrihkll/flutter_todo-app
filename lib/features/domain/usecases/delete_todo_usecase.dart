import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase implements UseCase<void, DeleteTodoUsecaseParams>{

  final TodoRepository repository;

  DeleteTodoUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(DeleteTodoUsecaseParams params) async {
    return await repository.deleteTodo(params.id);
  }

}

class DeleteTodoUsecaseParams {
  final int id;

  DeleteTodoUsecaseParams(this.id);
}