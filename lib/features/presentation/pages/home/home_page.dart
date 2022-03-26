import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/util/theme_util.dart';
import 'package:todo_app/features/data/datasources/db/database_handler.dart';
import 'package:todo_app/features/data/datasources/local_data_source.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/data/repositories/todo_repository_impl.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/domain/repositories/todo_repository.dart';
import 'package:todo_app/features/domain/usecases/delete_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/insert_todo_usecase.dart';
import 'package:todo_app/features/domain/usecases/update_todo_usecase.dart';
import 'package:todo_app/features/presentation/pages/create_todo/bloc/create_todo_bloc.dart';
import 'package:todo_app/features/presentation/pages/create_todo/create_todo_bottomsheet.dart';
import 'package:todo_app/features/presentation/pages/home/bloc/get_todo_home_bloc.dart';
import 'package:todo_app/features/presentation/pages/home/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Theme
  late ThemeData _theme;

  // Bloc
  late GetTodoHomeBloc blocGet;
  late CreateTodoBloc blocCreate;

  void _showInputTodoDialog(Todo? data)async{
    // Setup dependencies
    DatabaseHandler databaseHandler = DatabaseHandler();
    LocalDataSource localDataSource = LocalDataSourceImpl(databaseHandler: databaseHandler);
    TodoRepository repository = TodoRepositoryImpl(localDataSource: localDataSource);
    InsertTodoUsecase insertTodoUsecase = InsertTodoUsecase(repository: repository);
    UpdateTodoUsecase updateTodoUsecase = UpdateTodoUsecase(repository: repository);
    DeleteTodoUsecase deleteTodoUsecase = DeleteTodoUsecase(repository: repository);

    // show input dialog then wait until it's callback
    var result = await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) => BlocProvider<CreateTodoBloc>(
          create: (context) => CreateTodoBloc(
              insertTodoUsecase: insertTodoUsecase,
              updateTodoUsecase: updateTodoUsecase,
              deleteTodoUsecase: deleteTodoUsecase
          ),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: CreateTodoBottomsheet(todo: data),
          ),
        )
    );

    // if the result is instance of to-do, it means transaction success
    if(result is Todo){
      blocGet.add(GetTodoListEvent());
    }
  }

  void _onFloatingButtonPressed() async {
    _showInputTodoDialog(null);
  }

  void _onTodoClicked(Todo data){
    _showInputTodoDialog(data);
  }

  void _onCheckBoxChanged(Todo todo, bool newValue)async{
    // Build to-do model
    TodoModel model = TodoModel(
        id: todo.id,
        title: todo.title,
        description: todo.description,
        date: todo.date,
        hasDone: newValue
    );

    // Update data in database
    await blocCreate.updateTodoEvent(model);

    // Refresh the list
    blocGet.add(GetTodoListEvent());
  }


  @override
  void initState() {
    super.initState();

    // Get bloc instance from its provider
    blocGet = BlocProvider.of<GetTodoHomeBloc>(context);
    blocCreate = BlocProvider.of<CreateTodoBloc>(context);

    // Get to-do list from db
    blocGet.add(GetTodoListEvent());
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: softGray,
      // -------------------------- FAB
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: _onFloatingButtonPressed,
      ),
      // -------------------------- FAB
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ------------------------ App Icon
                const Icon(Icons.list, color: Colors.black,),
                // ------------------------ App Icon
                const SizedBox(height: 16,),
                // ------------------------ Warm Message :)
                const Text('What would you do now?',),
                // ------------------------ Warm Message :)
                const SizedBox(height: 64,),
                //------------------------- ListView
                BlocBuilder<GetTodoHomeBloc, GetTodoHomeState>(
                  builder: (context, state) {
                    if(state is GetTodoHomeLoading){
                      return const Center(
                        child: CupertinoActivityIndicator(),
                      );
                    }else if(state is GetTodoHomeLoaded){
                      return ListView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.listData.length,
                          itemBuilder: (context, position) {
                            return Dismissible(
                              onDismissed: (direction)async{
                                blocCreate.deleteTodoEvent(state.listData[position].id);
                              },
                              key: Key(state.listData[position].id.toString()),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 4, bottom: 4),
                                child: TodoListWidget(
                                    todo: state.listData[position],
                                    onItemClicked: (data){
                                      _onTodoClicked(data);
                                    },
                                    onCheckboxChanged: (newValue){
                                      _onCheckBoxChanged(
                                          state.listData[position],
                                          newValue
                                      );
                                    },
                                ),
                              ),
                            );
                          }
                      );
                    }else if(state is GetTodoHomeError){
                      return Center(
                        child: Text(state.message),
                      );
                    }else{
                      return const Center(
                        child: Text('There might be something wrong'),
                      );
                    }
                  },
                )
                //------------------------- ListView
              ],
            ),
          ),
        ),
      ),
    );
  }
}
