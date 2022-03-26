import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/update_todo_usecase.dart';

part 'create_todo_event.dart';
part 'create_todo_state.dart';

class CreateTodoBloc extends Bloc<CreateTodoEvent, CreateTodoState> {

  final InsertTodoUsecase insertTodoUsecase;
  final UpdateTodoUsecase updateTodoUsecase;
  final DeleteTodoUsecase deleteTodoUsecase;

  CreateTodoBloc({
    required this.insertTodoUsecase,
    required this.updateTodoUsecase,
    required this.deleteTodoUsecase
  }) : super(CreateTodoInitial());

  Future<Either<Failure, int>> createNewTodoEvent(TodoModel model)async{
    return await insertTodoUsecase.call(InsertTodoUsecaseParams(model));
  }

  Future<Either<Failure, int>> updateTodoEvent(TodoModel model)async{
    return await updateTodoUsecase.call(UpdateTodoUsecaseParams(model));
  }

  Future<Either<Failure, void>> deleteTodoEvent(int id)async{
    return await deleteTodoUsecase.call(DeleteTodoUsecaseParams(id));
  }

}
