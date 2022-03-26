import 'package:todo_app/features/data/datasources/db/database_handler.dart';
import 'package:todo_app/features/data/models/todo_model.dart';

abstract class LocalDataSource{
  Future<int> insertTodo(TodoModel model);
  Future<int> updateTodo(TodoModel model);
  Future<List<TodoModel>> getTodoList();
  Future<void> deleteTodo(int id);
}

class LocalDataSourceImpl implements LocalDataSource{

  final DatabaseHandler databaseHandler;


  LocalDataSourceImpl({required this.databaseHandler});

  @override
  Future<void> deleteTodo(int id) async {
    return await databaseHandler.deleteTodo(id);
  }

  @override
  Future<List<TodoModel>> getTodoList() async {
    return await databaseHandler.getTodoList();
  }

  @override
  Future<int> insertTodo(TodoModel model) async {
    return await databaseHandler.insertTodo(model);
  }

  @override
  Future<int> updateTodo(TodoModel model) async {
    return await databaseHandler.updateTodo(model);
  }


}