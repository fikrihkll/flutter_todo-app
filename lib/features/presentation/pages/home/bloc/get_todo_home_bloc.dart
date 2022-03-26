import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';

part 'get_todo_home_event.dart';
part 'get_todo_home_state.dart';

class GetTodoHomeBloc extends Bloc<GetTodoHomeEvent, GetTodoHomeState> {

  List<Todo> listTodo = [];
  
  final GetTodoListUsecase getTodoListUsecase;

  GetTodoHomeBloc({required this.getTodoListUsecase}) : super(GetTodoHomeInitial()) {
    on<GetTodoListEvent>((event, emit) async {
      // Set loading state
      emit(GetTodoHomeLoading());

      // Wait data from db
      var data = await getTodoListUsecase.call(NoParams());

      // Check wether the data sucessfully fethced or not
      emit(
        data.fold(
                //Error
                (l) => GetTodoHomeError(getErrorMessage(l)), 
                (r) {
                  // Success
                  listTodo.clear();
                  listTodo.addAll(r);
                  return GetTodoHomeLoaded(listTodo);
                })
      );
    });
  }

}
