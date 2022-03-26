import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';
import '../../mock_data.dart';

class FakeTodoRepository extends Mock implements TodoRepository {}

void main(){

  late FakeTodoRepository repository;
  late GetTodoListUsecase usecase;

  setUp((){
    registerFallbackValue(NoParams());

    repository = FakeTodoRepository();
    usecase = GetTodoListUsecase(repository: repository);
  });

  group('test get todo list usecase', (){

    test('should call repository get todo list', ()async{
      // arrange
      when(()=> repository.getTodoList())
          .thenAnswer((invocation) async => Future.value(Right(MockData.listTodo)));

      //act
      await usecase.call(NoParams());
      await untilCalled(()=> repository.getTodoList());

      //assert
      verify(()=> repository.getTodoList());
    });

    test('should return right value', ()async{
      // arrange
      when(()=> repository.getTodoList())
          .thenAnswer((invocation) async => Future.value(Right(MockData.listTodo)));

      //act
      var result = await usecase.call(NoParams());

      //assert
      expect(result, Right(MockData.listTodo));
    });

    test('should return left value', ()async{
      // arrange
      String errorMessage = 'any_message';
      when(()=> repository.getTodoList())
          .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

      //act
      var result = await usecase.call(NoParams());

      //assert
      expect(result, isA<Left>());
    });

  });

}