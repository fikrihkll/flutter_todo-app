import 'package:todo_app/features/domain/entities/todo.dart';

class TodoModel extends Todo{
  final int id;
  String title;
  String description;
  String date;
  bool hasDone;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.hasDone
  }):super(
      id: id,
      title: title,
      description: description,
      date: date,
      hasDone: hasDone
  );

  factory TodoModel.fromMap(Map<String, dynamic> map){
    return TodoModel(
        id: map['id'],
        title: map['title'],
        description: map['desc'],
        date: map['date'],
        hasDone: map['has_done'] == 1
    );
  }

  static Map<String, dynamic> toMap(TodoModel model){
    return {
      'id': model.id,
      'title': model.title,
      'desc': model.description,
      'date': model.date,
      'has_done': model.hasDone
    };
  }
}