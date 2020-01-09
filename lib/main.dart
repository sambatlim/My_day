import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_day/ui/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        canvasColor: Colors.white,
      ),
      home: HomePage(title: 'MyDay'),
    );
  }
}
