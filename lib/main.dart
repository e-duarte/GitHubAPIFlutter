import 'package:flutter/material.dart';
import 'package:examples/main-page.dart';
import 'package:examples/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Examples',
      home: app,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      routes: <String, WidgetBuilder>{
        '/main': (BuildContext context) => Home(),
      },
    );
  }
}

final app = LoginHome();
