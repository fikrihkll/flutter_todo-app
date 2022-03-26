import 'package:flutter/material.dart';
import 'package:todo_app/core/util/date_util.dart';
import 'package:todo_app/features/domain/entities/todo.dart';

class TodoListWidget extends StatefulWidget {

  final Todo todo;
  final Function onItemClicked;
  final Function onCheckboxChanged;

  const TodoListWidget({Key? key, required this.todo, required this.onItemClicked, required this.onCheckboxChanged}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {

  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Checkbox(value: widget.todo.hasDone, onChanged: (newValue){
            widget.onCheckboxChanged(newValue);
            setState(() {
              widget.todo.hasDone = !widget.todo.hasDone;
            });
          }),
          Expanded(
              child: GestureDetector(
                onTap: (){
                  widget.onItemClicked(widget.todo);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // -------------------------- Date
                    Text(dateFormat.format(ymdFormat.parse(widget.todo.date)), style: _theme.textTheme.subtitle1,),
                    // -------------------------- Date
                    const SizedBox(height: 8,),
                    // -------------------------- Title
                    Text(
                      widget.todo.title,
                      style: _theme.textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // -------------------------- Title
                    // -------------------------- Description
                    Text(
                      widget.todo.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                    // -------------------------- Description
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
