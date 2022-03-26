import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/features/data/models/todo_model.dart';

class DatabaseHandler{

  static const String _TABLE_TODO = 'todo';
  static const String _C_ID = 'id';
  static const String _C_TITLE = 'title';
  static const String _C_DESC = 'desc';
  static const String _C_DATE = 'date';
  static const String _C_HAS_DONE = 'has_done';

  late Database? db=null;

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'todo.db'),
      onCreate: (database, version) async {
        await database.execute(
          '''
          CREATE TABLE $_TABLE_TODO(
          $_C_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
          $_C_TITLE TEXT NOT NULL, 
          $_C_DESC TEXT NOT NULL, 
          $_C_DATE TEXT NOT NULL, 
          $_C_HAS_DONE INTEGER NOT NULL
          );
          ''',
        );
      },
      version: 2,
    );
  }

  Future<Database> _getDatabase()async{
    if(db == null){
      db = await initializeDB();
      return db!;
    }else{
      return db!;
    }
  }

  Future<int> insertTodo(TodoModel todo) async {
    int result = 0;
    final Database db = await _getDatabase();

    // Insert TodoModel to database which model that has been converted to map
    result = await db.insert(_TABLE_TODO, TodoModel.toMap(todo));
    return result;
  }

  Future<int> updateTodo(TodoModel todo) async {
    int result = 0;
    final Database db = await _getDatabase();

    // Update TodoModel to database which model that has been converted to map
    result = await db.update(
        _TABLE_TODO,
        TodoModel.toMap(todo),
        where: '$_C_ID = ?',
        whereArgs: [todo.id]);
    return result;
  }

  Future<List<TodoModel>> getTodoList() async {
    final Database db = await _getDatabase();

    // Filter all to-do data from the has_done column that false and the closest date
    final List<Map<String, dynamic>> queryResult = await db.rawQuery('SELECT * FROM $_TABLE_TODO ORDER BY $_C_HAS_DONE = 1 ASC, $_C_DATE ASC');

    // Convert from map to model then will be converted to list
    return queryResult.map((e) => TodoModel.fromMap(e)).toList();
  }

  Future<void> deleteTodo(int id) async {
    final db = await _getDatabase();
    await db.delete(
      _TABLE_TODO,
      where: "id = ?",
      whereArgs: [id],
    );
  }

}