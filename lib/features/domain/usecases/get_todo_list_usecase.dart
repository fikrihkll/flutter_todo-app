import 'package:dartz/dartz.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

class GetTodoListUsecase implements UseCase<List<Todo>, NoParams>{

  final TodoRepository repository;


  GetTodoListUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    return await repository.getTodoList();
  }

}