import 'package:flutter/material.dart';
import 'package:simple_crud/login_registro/login.dart';
import 'package:simple_crud/login_registro/registro.dart';
import 'package:simple_crud/courier/home_insert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => LoginPage(),
    RegistroPage.tag: (context) => RegistroPage(),
    '/home': (context) => Home(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kodeversitas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: LoginPage(),
      routes: routes,
    );
  }
}
