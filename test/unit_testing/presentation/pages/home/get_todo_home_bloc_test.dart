
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';
import 'package:todo_app/features/presentation/pages/home/bloc/get_todo_home_bloc.dart';

import '../../../mock_data.dart';

class FakeGetTodoListUsecase extends Mock implements GetTodoListUsecase {}

void main(){

  late FakeGetTodoListUsecase getTodoListUsecase;
  late GetTodoHomeBloc bloc;
  
  setUp((){
    registerFallbackValue(NoParams());
    getTodoListUsecase = FakeGetTodoListUsecase();
    bloc = GetTodoHomeBloc(getTodoListUsecase: getTodoListUsecase);
  });
  
  tearDown((){
    bloc.close();
  });
  
  group('test get todo home bloc', (){
    
    test('should give initial state', (){
      expect(bloc.state, isA<GetTodoHomeInitial>());
    });

    test('should call usecase', () async {
      // Arrange
      when(()=> getTodoListUsecase.call(any())).thenAnswer((invocation) async => Future.value(Right(MockData.listTodo)));

      //act
      bloc.add(GetTodoListEvent());
      await untilCalled(()=>
        getTodoListUsecase.call(any())
      );

      //assert
      verify(()=>
          getTodoListUsecase.call(any()));

    });

    blocTest<GetTodoHomeBloc, GetTodoHomeState>(
      'should emit Success',
      build: (){
        //arrange
        when(()=> getTodoListUsecase.call(any()))
            .thenAnswer((invocation) async => Future.value(Right(MockData.listTodo)));

        return bloc;
      },
      act: (bloc)=> bloc.add(GetTodoListEvent()),
      expect: ()=> [
        GetTodoHomeLoading(),
        GetTodoHomeLoaded(MockData.listTodo)
      ]
    );


    String errorMessage = 'some message';

    blocTest<GetTodoHomeBloc, GetTodoHomeState>(
        'should emit Error',
        build: (){

          //arrange
          when(()=> getTodoListUsecase.call(any()))
              .thenAnswer((invocation) async => Future.value(Left(CacheFailure(errorMessage))));

          return bloc;
        },
        act: (bloc)=> bloc.add(GetTodoListEvent()),
        expect: ()=> [
          GetTodoHomeLoading(),
          GetTodoHomeError(errorMessage)
        ]
    );
    
  });
  
}