
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/features/data/datasources/local_data_source.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';

import '../../mock_data.dart';

class FakeLocalDataSource extends Mock implements LocalDataSource {}

void main(){

  late FakeLocalDataSource localDataSource;
  late TodoRepository todoRepository;

  int todoId = 1;

  TodoModel model = TodoModel(
      id: 1,
      title: 'Healing',
      description: 'Eveery of us sometimes need healing :)',
      date: '2022-10-22',
      hasDone: true
  );

  setUp((){
    registerFallbackValue(MockData.listTodoModel);
    registerFallbackValue(model);

    localDataSource = FakeLocalDataSource();
    todoRepository = TodoRepositoryImpl(localDataSource: localDataSource);
  });

  group('test insert todo repository', (){

    test('should call local data source function', ()async{
      int rowAffected = 1;

      //arrange
      when(()=> localDataSource.insertTodo(any())).thenAnswer((invocation) async => Future.value(rowAffected));

      //act
      await todoRepository.insertTodo(model);
      await untilCalled(()=> localDataSource.insertTodo(model));

      //assert
      verify(()=> localDataSource.insertTodo(model));
    });

    test('should return integer value given', ()async{
      int rowAffected = 1;

      //arrange
      when(()=> localDataSource.insertTodo(any())).thenAnswer((invocation) async => Future.value(rowAffected));

      //act
      var result = await todoRepository.insertTodo(model);

      //assert
      expect(result, Right(rowAffected));
    });

  });


  group('test update todo repository', (){

    test('should call local data source function', ()async{
      int rowAffected = 1;

      //arrange
      when(()=> localDataSource.updateTodo(any())).thenAnswer((invocation) async => Future.value(rowAffected));

      //act
      await todoRepository.updateTodo(model);
      await untilCalled(()=> localDataSource.updateTodo(model));

      //assert
      verify(()=> localDataSource.updateTodo(model));
    });

    test('should return integer value given', ()async{
      int rowAffected = 1;

      //arrange
      when(()=> localDataSource.updateTodo(any())).thenAnswer((invocation) async => Future.value(rowAffected));

      //act
      var result = await todoRepository.updateTodo(model);

      //assert
      expect(result, Right(rowAffected));
    });

  });


  group('test get todo repository', (){

    test('should call local data source function', ()async{
      //arrange
      when(()=> localDataSource.getTodoList()).thenAnswer((invocation) async => Future.value(MockData.listTodoModel));

      //act
      await todoRepository.getTodoList();
      await untilCalled(()=> localDataSource.getTodoList());

      //assert
      verify(()=> localDataSource.getTodoList());
    });

    test('should return list todo value given', ()async{
      //arrange
      when(()=> localDataSource.getTodoList()).thenAnswer((invocation) async => Future.value(MockData.listTodoModel));

      //act
      var result = await todoRepository.getTodoList();

      //assert
      expect(result, Right(MockData.listTodoModel));
    });

  });


  group('test delete todo repository', (){

    test('should call local data source function', ()async{
      //arrange
      when(()=> localDataSource.deleteTodo(any())).thenAnswer((invocation) async => Future.value());

      //act
      await todoRepository.deleteTodo(todoId);
      await untilCalled(()=> localDataSource.deleteTodo(todoId));

      //assert
      verify(()=> localDataSource.deleteTodo(todoId));
    });

    test('should return void value', ()async{
      //arrange
      when(()=> localDataSource.deleteTodo(any())).thenAnswer((invocation) async => Future.value());

      //act
      var result = await todoRepository.deleteTodo(todoId);

      //assert
      expect(result, isA<void>());
    });

  });

}