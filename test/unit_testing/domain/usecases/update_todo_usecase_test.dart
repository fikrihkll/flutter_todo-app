import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/update_todo_usecase.dart';

class FakeTodoRepository extends Mock implements TodoRepository {}

void main(){

  late FakeTodoRepository repository;
  late UpdateTodoUsecase usecase;

  TodoModel model = TodoModel(
      id: 1,
      title: 'Healing',
      description: 'Eveery of us sometimes need healing :)',
      date: '2022-10-22',
      hasDone: true
  );

  setUp((){
    registerFallbackValue(model);
    registerFallbackValue(UpdateTodoUsecaseParams(model));

    repository = FakeTodoRepository();
    usecase = UpdateTodoUsecase(repository: repository);
  });

  group('test get todo list usecase', (){

    test('should call repository get todo list', ()async{
      // arrange
      int rowAffected = 1;
      when(()=> repository.updateTodo(any()))
          .thenAnswer((invocation) async => Future.value(Right(rowAffected)));

      //act
      await usecase.call(UpdateTodoUsecaseParams(model));
      await untilCalled(()=> repository.updateTodo(model));

      //assert
      verify(()=> repository.updateTodo(model));
    });

    test('should return right value', ()async{
      // arrange
      int rowAffected = 1;
      when(()=> repository.updateTodo(any()))
          .thenAnswer((invocation) async => Future.value(Right(rowAffected)));

      //act
      var result = await usecase.call(UpdateTodoUsecaseParams(model));

      //assert
      expect(result, Right(rowAffected));
    });

    test('should return left value', ()async{
      // arrange
      String errorMessage = 'any_message';
      when(()=> repository.updateTodo(any()))
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await usecase.call(UpdateTodoUsecaseParams(model));

      //assert
      expect(result, isA<Left>());
    });

  });

}