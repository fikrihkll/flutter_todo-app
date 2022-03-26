import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/usecase/usecase.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';

part 'get_todo_home_event.dart';
part 'get_todo_home_state.dart';

class GetTodoHomeBloc extends Bloc<GetTodoHomeEvent, GetTodoHomeState> {

  final GetTodoListUsecase getTodoListUsecase;

  GetTodoHomeBloc({required this.getTodoListUsecase}) : super(GetTodoHomeInitial()) {
    on<GetTodoListEvent>((event, emit) async {

      emit(GetTodoHomeLoading());

      var data = await getTodoListUsecase.call(NoParams());

      emit(
        data.fold((l) => GetTodoHomeError(getErrorMessage(l)), (r) => GetTodoHomeLoaded(r))
      );
    });
  }



}
