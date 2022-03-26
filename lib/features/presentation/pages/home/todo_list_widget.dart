import 'package:flutter/material.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

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
          Checkbox(value: false, onChanged: (newValue){

          }),
          Expanded(
              child: GestureDetector(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('20 Oct 2022', style: _theme.textTheme.subtitle1,),
                    const SizedBox(height: 8,),
                    Text(
                      'Hello',
                      style: _theme.textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'desc',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
