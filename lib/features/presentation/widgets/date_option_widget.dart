import 'package:flutter/material.dart';
import 'package:todo_app/core/util/theme_util.dart';

class TimeOptionWidget extends StatefulWidget {

  Function onOptionSelected;

  TimeOptionWidget({Key? key, required this.onOptionSelected}) : super(key: key);

  @override
  State<TimeOptionWidget> createState() => _TimeOptionWidgetState();
}

class _TimeOptionWidgetState extends State<TimeOptionWidget> {

  final List<String> listOption = ['Today', 'Tomorrow', 'Select'];
  int selectedPosition = 0;

  void _onOptionSelected(){
    widget.onOptionSelected(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          primary: false,
          itemCount: listOption.length,
          itemBuilder: (context, position){
            return GestureDetector(
              onTap: (){
                selectedPosition = position;
                _onOptionSelected();
                setState(() {
                  
                });
              },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: TimeListWidget(
                    text: listOption[position],
                    isSelected: selectedPosition == position,
                  ),
                )
            );
          }
      ),
    );
  }
}


class TimeListWidget extends StatelessWidget {

  bool isSelected;
  String text;
  TimeListWidget({Key? key, this.isSelected=false, required this.text}) : super(key: key);

  late ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkGray,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(
            width: 3,
            color: isSelected ? _theme.primaryColor : darkGray
        )
      ),
      child: Center(child: Text(text, style: const TextStyle(color: Colors.white),)),
    );
  }
}

