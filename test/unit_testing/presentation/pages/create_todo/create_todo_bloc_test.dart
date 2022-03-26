import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/update_todo_usecase.dart';
import 'package:todo_app/features/presentation/pages/create_todo/bloc/create_todo_bloc.dart';

class FakeInsertTodoUsecase extends Mock implements InsertTodoUsecase {}
class FakeDeleteTodoUsecase extends Mock implements DeleteTodoUsecase {}
class FakeUpdateTodoUsecase extends Mock implements UpdateTodoUsecase {}


void main(){

  late FakeUpdateTodoUsecase updateTodoUsecase;
  late FakeInsertTodoUsecase insertTodoUsecase;
  late FakeDeleteTodoUsecase deleteTodoUsecase;
  late CreateTodoBloc bloc;

  TodoModel model = TodoModel(
      id: 1,
      title: 'Healing',
      description: 'Eveery of us sometimes need healing :)',
      date: '2022-10-22',
      hasDone: true
  );
  
  int todoId = 1;

  setUp((){
    registerFallbackValue(InsertTodoUsecaseParams(model));
    registerFallbackValue(UpdateTodoUsecaseParams(model));
    registerFallbackValue(DeleteTodoUsecaseParams(todoId));
    
    
    updateTodoUsecase = FakeUpdateTodoUsecase();
    insertTodoUsecase = FakeInsertTodoUsecase();
    deleteTodoUsecase = FakeDeleteTodoUsecase();

    bloc = CreateTodoBloc(
        insertTodoUsecase: insertTodoUsecase,
        updateTodoUsecase: updateTodoUsecase,
        deleteTodoUsecase: deleteTodoUsecase
    );

  });

  group('test bloc insert event', (){

    test('should call insert todo usecase', () async {
      // arrange
      int tRowAffected = 1;

      when(()=> insertTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Right(tRowAffected)));

      //act
      await bloc.createNewTodoEvent(model);
      await untilCalled(()=> insertTodoUsecase.call(any()));

      //assert
      verify(()=> insertTodoUsecase.call(any()));
    });

    test('given any model, bloc function will be called, then should return value given', () async {
      // arrange
      int tRowAffected = 1;

      when(()=> insertTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Right(tRowAffected)));

      //act
      var result = await bloc.createNewTodoEvent(model);
      await untilCalled(()=> insertTodoUsecase.call(any()));

      //assert
      expect(result, Right(tRowAffected));
    });

    test('given any model, bloc function will be called, then should return failure', () async {
      // arrange
      String errorMessage = 'some_message';

      when(()=> insertTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await bloc.createNewTodoEvent(model);
      await untilCalled(()=> insertTodoUsecase.call(any()));

      //assert
      expect(result, isA<Left>());
      expect(result, Left(CacheFailure(errorMessage)));
    });

  });



  group('test bloc update event', (){

    test('should call update todo usecase', () async {
      // arrange
      int tRowAffected = 1;

      when(()=> updateTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Right(tRowAffected)));

      //act
      await bloc.updateTodoEvent(model);
      await untilCalled(()=> updateTodoUsecase.call(any()));

      //assert
      verify(()=> updateTodoUsecase.call(any()));
    });

    test('given any model, bloc function will be called, then should return value given', () async {
      // arrange
      int tRowAffected = 1;

      when(()=> updateTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Right(tRowAffected)));

      //act
      var result = await bloc.updateTodoEvent(model);
      await untilCalled(()=> updateTodoUsecase.call(any()));

      //assert
      expect(result, Right(tRowAffected));
    });

    test('given any model, bloc function will be called, then should return failure', () async {
      // arrange
      String errorMessage = 'some_message';

      when(()=> updateTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await bloc.updateTodoEvent(model);
      await untilCalled(()=> updateTodoUsecase.call(any()));

      //assert
      expect(result, isA<Left>());
      expect(result, Left(CacheFailure(errorMessage)));

    });

  });



  group('test bloc delete event', (){

    test('should call delete todo usecase', () async {
      // arrange
      when(()=> deleteTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(const Right({})));

      //act
      await bloc.deleteTodoEvent(todoId);
      await untilCalled(()=> deleteTodoUsecase.call(any()));

      //assert
      verify(()=> deleteTodoUsecase.call(any()));
    });

    test('given any model, bloc function will be called, then should be right instance', () async {
      // arrange
      when(()=> deleteTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(const Right({})));

      //act
      var result = await bloc.deleteTodoEvent(todoId);
      await untilCalled(()=> deleteTodoUsecase.call(any()));

      //assert
      expect(result, isA<Right>());
    });

    test('given any model, bloc function will be called, then should return failure', () async {
      // arrange
      String errorMessage = 'some_message';

      when(()=> deleteTodoUsecase.call(any()))
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await bloc.deleteTodoEvent(todoId);
      await untilCalled(()=> deleteTodoUsecase.call(any()));

      //assert
      expect(result, isA<Left>());
      expect(result, Left(CacheFailure(errorMessage)));

    });

  });

}