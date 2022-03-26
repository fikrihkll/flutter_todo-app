import 'package:flutter/material.dart';
import 'features/presentation/routes/route.dart' as route;
import 'core/util/theme_util.dart' as themeUtil;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          headline1: themeUtil.headline_1,
          headline2: themeUtil.headline_2,
          headline3: themeUtil.headline_3,
          headline4: themeUtil.headline_4,
          subtitle1: themeUtil.subtitle1
        )
      ),
      onGenerateRoute: route.controller,
      initialRoute: route.homePage,
    );
  }
}