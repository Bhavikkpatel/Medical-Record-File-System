import 'package:flutter/material.dart';
// import 'LoginPage.dart';
// import 'Registration.dart';
import 'register_select.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distributer Medical System',
      debugShowCheckedModeBanner: false,
      home: register_select(),
    );
  }
}
