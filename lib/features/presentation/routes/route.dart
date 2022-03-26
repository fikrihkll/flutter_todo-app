import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/data/datasources/db/database_handler.dart';
import 'package:todo_app/features/data/datasources/local_data_source.dart';
import 'package:todo_app/features/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/get_todo_list_usecase.dart';
import 'package:todo_app/features/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/update_todo_usecase.dart';
import 'package:todo_app/features/presentation/pages/create_todo/bloc/create_todo_bloc.dart';
import 'package:todo_app/features/presentation/pages/home/bloc/get_todo_home_bloc.dart';
import 'package:todo_app/features/presentation/pages/home/home_page.dart';

const String homePage = 'home_page';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage :
      // Setup dependencies
      DatabaseHandler databaseHandler = DatabaseHandler();
      LocalDataSource localDataSource = LocalDataSourceImpl(databaseHandler: databaseHandler);
      TodoRepository repository = TodoRepositoryImpl(localDataSource: localDataSource);
      GetTodoListUsecase getTodoListUsecase = GetTodoListUsecase(repository: repository);
      InsertTodoUsecase insertTodoUsecase = InsertTodoUsecase(repository: repository);
      UpdateTodoUsecase updateTodoUsecase = UpdateTodoUsecase(repository: repository);
      DeleteTodoUsecase deleteTodoUsecase = DeleteTodoUsecase(repository: repository);

      return MaterialPageRoute(builder: (context) =>
          MultiBlocProvider(
            providers: [
              BlocProvider<GetTodoHomeBloc>(
                create: (context) => GetTodoHomeBloc(getTodoListUsecase: getTodoListUsecase),
              ),
              BlocProvider<CreateTodoBloc>(
                create: (context) => CreateTodoBloc(
                    insertTodoUsecase: insertTodoUsecase,
                    updateTodoUsecase: updateTodoUsecase,
                    deleteTodoUsecase: deleteTodoUsecase
                ),
              )
            ],
            child: const HomePage(),
          ));
    default:
      throw Exception('no route detected');
  }
}