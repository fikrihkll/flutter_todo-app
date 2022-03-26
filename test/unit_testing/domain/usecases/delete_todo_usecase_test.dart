import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';
import '../../mock_data.dart';

class FakeTodoRepository extends Mock implements TodoRepository {}

void main(){

  late FakeTodoRepository repository;
  late DeleteTodoUsecase usecase;
  
  int todoId = 1;

  setUp((){
    registerFallbackValue(DeleteTodoUsecaseParams(todoId));

    repository = FakeTodoRepository();
    usecase = DeleteTodoUsecase(repository: repository);
  });

  group('test get todo list usecase', (){

    test('should call repository get todo list', ()async{
      // arrange
      when(()=> repository.deleteTodo(any()))
          .thenAnswer((invocation) async => Future.value(const Right({})));

      //act
      await usecase.call(DeleteTodoUsecaseParams(todoId));
      await untilCalled(()=> repository.deleteTodo(todoId));

      //assert
      verify(()=> repository.deleteTodo(any()));
    });

    test('should return right value', ()async{
      // arrange
      when(()=> repository.deleteTodo(any()))
          .thenAnswer((invocation) async => Future.value(const Right({})));

      //act
      var result = await usecase.call(DeleteTodoUsecaseParams(todoId));

      //assert
      expect(result, const Right({}));
    });

    test('should return left value', ()async{
      // arrange
      String errorMessage = 'any_message';
      when(()=> repository.deleteTodo(any()))
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await usecase.call(DeleteTodoUsecaseParams(todoId));

      //assert
      expect(result, isA<Left>());
    });

  });

}