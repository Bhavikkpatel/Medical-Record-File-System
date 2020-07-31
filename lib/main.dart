import 'package:flutter/material.dart';

import 'LoginPage.dart';
//import 'package:simple_permissions/simple_permissions.dart';

// import 'Registration.dart';
// import 'register_select.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Distributed Medical System',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}