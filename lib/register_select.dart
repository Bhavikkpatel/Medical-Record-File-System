import 'package:dms/Doctor_Register.dart';
import 'package:flutter/material.dart';

import 'Patient_Register.dart';

class register_select extends StatefulWidget {
  @override
  _register_selectState createState() => _register_selectState();
}

Route _PatientRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PatientRegister(),
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

Route _DoctorRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DoctorRegister(),
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
  AssetImage background = new AssetImage('assets/images/background3.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: background, fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              IconButton(
                color: Colors.red,
                icon: Image.asset('assets/images/doctor.png'),
                iconSize: 150,
                splashColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(_DoctorRoute());
                },
              ),
              Text(
                'I am a doctor',
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
                icon: Image.asset('assets/images/patients.png'),
                iconSize: 100,
                splashColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(_PatientRoute());
                },
              ),
              Text(
                'I am a patient',
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