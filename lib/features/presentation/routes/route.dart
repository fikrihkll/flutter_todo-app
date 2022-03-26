import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/features/presentation/pages/home/home_page.dart';


const String homePage = 'home_page';

Route<dynamic> controller(RouteSettings settings){
  switch(settings.name){
    case homePage :
      return MaterialPageRoute(builder: (context)=> HomePage());
    default:
      throw Exception('no route detected');
  }
}