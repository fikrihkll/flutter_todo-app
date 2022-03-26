import 'package:equatable/equatable.dart';

class Todo extends Equatable{
  int id;
  String title;
  String description;
  String date;
  bool hasDone;

  Todo({required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.hasDone
  });

  @override
  List<Object?> get props => [id, title, description, date, hasDone];
}