import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/data/datasources/local_data_source.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository{

  final LocalDataSource localDataSource;


  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try{
      var response = await localDataSource.deleteTodo(id);
      return Right(response);
    }on CacheFailure catch(e){
      return Left(CacheFailure(e.message));
    }catch(e){
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodoList() async {
    try{
      var response = await localDataSource.getTodoList();
      return Right(response);
    }on CacheFailure catch(e){
      return Left(CacheFailure(e.message));
    }catch(e){
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> insertTodo(TodoModel model) async {
    try{
      var response = await localDataSource.insertTodo(model);
      return Right(response);
    }on CacheFailure catch(e){
      return Left(CacheFailure(e.message));
    }catch(e){
      debugPrint(e.toString());
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> updateTodo(TodoModel model) async {
    try{
      var response = await localDataSource.updateTodo(model);
      return Right(response);
    }on CacheFailure catch(e){
      return Left(CacheFailure(e.message));
    }catch(e){
      debugPrint(e.toString());
      return Left(UnexpectedFailure(e.toString()));
    }
  }

}