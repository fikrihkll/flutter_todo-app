import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/error/failure.dart';
import 'package:todo_app/core/util/date_util.dart';
import 'package:todo_app/features/data/models/todo_model.dart';
import 'package:todo_app/features/domain/entities/todo.dart';
import 'package:todo_app/features/presentation/pages/create_todo/bloc/create_todo_bloc.dart';
import 'package:todo_app/features/presentation/widgets/date_option_widget.dart';

class CreateTodoBottomsheet extends StatefulWidget {

  final Todo? todo;

  const CreateTodoBottomsheet({Key? key, this.todo}) : super(key: key);

  @override
  State<CreateTodoBottomsheet> createState() => _CreateTodoBottomsheetState();
}

class _CreateTodoBottomsheetState extends State<CreateTodoBottomsheet> {

  // theme
  late ThemeData _theme;

  // Data variable
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerDesc = TextEditingController();
  late String selectedDate='';

  // Title for bottomSheetDialog
  String _titleView = 'Create New Todo';

  // this will store to-do after save is pressed
  late Todo? newTodo;

  // bloc
  late CreateTodoBloc bloc;

  // Error message variable
  String? _titleError;

  // merge to-do data from each component into model
  TodoModel _buildTodoData(){
    if(widget.todo != null){
      newTodo = Todo(
        id: widget.todo!.id,
        title: _controllerTitle.text,
        description: _controllerDesc.text,
        date: selectedDate,
        hasDone: widget.todo!.hasDone
      );
    }else{
      newTodo = Todo(
          id: 0,
          title: _controllerTitle.text,
          description: _controllerDesc.text,
          date: selectedDate,
          hasDone: false
      );
    }

    return TodoModel(
      id: newTodo!.id,
      title: newTodo!.title,
      description: newTodo!.description,
      date: newTodo!.date,
      hasDone: newTodo!.hasDone
    ) ;
  }

  void _onSavePressed()async{
    // Reset error message
    _titleError = null;
    setState(() {

    });

    // Validate data
    if(validateData()){
      TodoModel model = _buildTodoData();

      var result;
      if(widget.todo != null){
        // Update data
        result = await bloc.updateTodoEvent(model);
      }else{
        // Insert new data
        result = await bloc.createNewTodoEvent(model);
      }

      // Check Update/Insert result
      result.fold(
              (l) {
                //Failed
            ScaffoldMessenger
                .of(context)
                .showSnackBar(
                SnackBar(content: Text(getErrorMessage(l)),
                  backgroundColor: Colors.red,));
            Navigator.pop(context, newTodo);
          },
              (r){
                //Success
            ScaffoldMessenger
                .of(context)
                .showSnackBar(
                const SnackBar(content: Text('Success'),)
            );
            Navigator.pop(context, newTodo);
          }
      );
    }
  }

  Widget _buildSaveButton(){
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )
            )
        ),
        onPressed: _onSavePressed,
        child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16),)
        )
    );
  }

  void _handleDatePicker()async{
    FocusManager.instance.primaryFocus?.unfocus();
    final now = DateTime.now();
    final res = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: DateTime.now(),
        lastDate: DateTime(now.year+99),
        builder: (BuildContext context, Widget? widget){
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
                primaryColorDark: Colors.yellow,
                accentColor: Colors.teal,),
              dialogBackgroundColor:Colors.white,
            ),
            child: widget!,

          );
        }
    );
    if(res!=null){
      selectedDate = '${res.year}-${res.month}-${res.day}';
      setState(() {

      });
    }
  }

  bool validateData(){
    if(_controllerTitle.text.isEmpty){
      _titleError = 'Title is not allowed to be empty';
      setState(() {
      });
      return false;
    }else{
      return true;
    }
  }

  @override
  void initState() {
    super.initState();

    debugPrint('ID => ${widget.todo?.id}');
    debugPrint('TITLE => ${widget.todo?.title}');


    // fetch bloc instance from provider
    bloc = BlocProvider.of<CreateTodoBloc>(context);

    // set default time
    var now = DateTime.now();
    selectedDate = '${now.year}-${now.month}-${now.day}';

    // Check wether create new todo or update todo
    if(widget.todo != null){
      _titleView = 'Update Todo';
      _controllerTitle.text = widget.todo!.title;
      _controllerDesc.text = widget.todo!.description;
      selectedDate = widget.todo!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32,),
            // ------------------------------ Title Bottomsheet
            Text(_titleView, style: _theme.textTheme.headline3,),
            // ------------------------------ Title Bottomsheet
            const SizedBox(height: 16,),
            // ------------------------------ Title
            TextField(
              controller: _controllerTitle,
              style: _theme.textTheme.bodyText1,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  errorText: _titleError,
                  labelText: 'Title',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))
              ),
            ),
            // ------------------------------ Title
            const SizedBox(height: 16,),
            // ------------------------------ Description
            TextField(
              controller: _controllerDesc,
              style: _theme.textTheme.bodyText1,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))
              ),
            ),
            // ------------------------------ Description
            const SizedBox(height: 16,),
            // ------------------------------ Time Option Widget
            TimeOptionWidget(onOptionSelected: (pos){
              switch(pos){
                case 0:
                  var now = DateTime.now();
                  selectedDate = '${now.year}-${now.month}-${now.day}';
                  setState(() {
                  });
                  break;
                case 1:
                  var now = DateTime.now();
                  selectedDate = '${now.year}-${now.month}-${now.day+1}';
                  setState(() {
                  });
                  break;
                case 2:
                  _handleDatePicker();
                  break;

              }
            }),
            // ------------------------------ Time Option Widget
            const SizedBox(height: 8,),
            // ------------------------------ Selected Date
            Text(dateFormat.format(ymdFormat.parse(selectedDate))),
            // ------------------------------ Selected Date
            const SizedBox(
              height: 16,
            ),
            // ------------------------------ Save Button
            Align(
              alignment: Alignment.centerRight,
              child: _buildSaveButton()
            )
            // ------------------------------ Save Button
          ],
        ),
      ),
    );
  }
}
