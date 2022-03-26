import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/util/theme_util.dart';
import 'package:todo_app/features/presentation/pages/home/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late ThemeData _theme;

  void _onFloatingButtonPressed(){

  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Scaffold(
      backgroundColor: softGray,
      floatingActionButton: FloatingActionButton(
        child: const Icon(CupertinoIcons.add),
        onPressed: _onFloatingButtonPressed,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.list, color: Colors.black,),
                const SizedBox(height: 16,),
                const Text('What would you do now?',),
                const SizedBox(height: 64, ),
                Text('There are a few things you must do today', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                const SizedBox(height: 16,),
                //------------------------- ListView
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: 3,
                    itemBuilder: (context, position){
                      return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4),
                        child: const TodoListWidget(),
                      );
                    }
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
