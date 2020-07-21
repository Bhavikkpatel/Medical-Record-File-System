import 'package:dms/Doctor_Menu.dart';
import 'package:dms/register_select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => register_select(),
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

Route _MenuRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Doctor_Menu(),
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

class _LoginPageState extends State<LoginPage> {
  final _LoginValidate = GlobalKey<FormState>();

  bool _passwordVisible = true;

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  AssetImage background = new AssetImage('assets/images/background3.jpg');
  RegExp Mobile_number = new RegExp(r"^[0-9]{10,10}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: background, fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _LoginValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //Email
                    Padding(
                      padding:
                          EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                      child: TextFormField(
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            // hintText: "Username",
                            labelStyle: TextStyle(
                              fontFamily: "CenturyGothic",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                          ),
                          validator: Validators.compose([
                            Validators.patternRegExp(
                                Mobile_number, "Enter Valid Number"),
                          ])),
                    ),
                    // password
                    Padding(
                      padding: EdgeInsets.only(
                          left: 50.0, right: 50.0, top: 10.0),
                      child: TextFormField(
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons
                                  .visibility_off,
                              color: Theme
                                  .of(context)
                                  .primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontFamily: "CenturyGothic",
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 10.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.black,
                              )
                          ),
                        ),

                        validator: Validators.compose([
                          Validators.required('Password is require'),
                          Validators.patternString(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$',
                              'Enter valid password'),
                        ]),

                      ),
                    ),
                    // register button
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            if (_LoginValidate.currentState.validate()) {
                              Navigator.of(context).push(_MenuRoute());
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                color: Colors.black,
                              )
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: "CenturyGothic", fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 20.0),
                      child: Text(
                        "OR",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 10.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(_createRoute());
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                color: Colors.black,
                                // width: 10.0,
                              )
                          ),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontFamily: "CenturyGothic", fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}