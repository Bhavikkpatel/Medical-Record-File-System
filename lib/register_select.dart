import 'package:flutter/material.dart';
import 'Registration.dart';

class register_select extends StatefulWidget {
  @override
  _register_selectState createState() => _register_selectState();
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Registration(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class _register_selectState extends State<register_select> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 200.0,
              ),
              IconButton(
                icon: Image.asset('assets/images/doc.png'),
                iconSize: 150,
                splashColor: Colors.white,
                onPressed: () {

                },
              ),
              Text(
                'I am a doctor!',
                style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'CenturyGothic',
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              IconButton(
                icon: Image.asset('assets/images/patient.png'),
                iconSize: 100,
                splashColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
              ),
              Text(
                'I am a patient!',
                style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: 'CenturyGothic',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}