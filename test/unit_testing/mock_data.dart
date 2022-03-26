import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/entities/todo.dart';

class MockData{
  static List<Todo> listTodo = [
    Todo(id: 1, title: 'Healing', description: 'Try to do some fun', date: '2022-10-6', hasDone: false),
    Todo(id: 2, title: 'Self Reward', description: 'Buy some coffee that you like', date: '2022-10-22', hasDone: false),
    Todo(id: 3, title: 'Home Decor', description: 'Make your setup cleaner in your work desk', date: '2022-7-13', hasDone: false),
    Todo(id: 4, title: 'New Macbook', description: 'We need this', date: '2022-3-16', hasDone: true),
  ];
  static List<TodoModel> listTodoModel = [
    TodoModel(id: 1, title: 'Healing', description: 'Try to do some fun', date: '2022-10-6', hasDone: false),
    TodoModel(id: 2, title: 'Self Reward', description: 'Buy some coffee that you like', date: '2022-10-22', hasDone: false),
    TodoModel(id: 3, title: 'Home Decor', description: 'Make your setup cleaner in your work desk', date: '2022-7-13', hasDone: false),
    TodoModel(id: 4, title: 'New Macbook', description: 'We need this', date: '2022-3-16', hasDone: true),
  ];
}