import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _LoginValidate = GlobalKey<FormState>();


  bool validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Form(
              key: _LoginValidate,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 500.0,
                    // ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0,right: 50.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                          
                          labelText: "Username",
                          // hintText: "Username",
                          labelStyle: TextStyle(fontFamily: "CenturyGothic",color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 10.0,
                            )
                          ),
                          focusedBorder: OutlineInputBorder(
                            
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                            )
                          ),
                        ),
                        
                        validator: Validators.compose(
                          [
                            Validators.required('Username is required'),
                            Validators.minLength(8,'Minimum 8 characters required'),
                            Validators.maxLength(20, 'Maximum 20 characters'),
                          ]
                        )
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 50.0,right: 50.0,top: 10.0),
                        child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontFamily: "CenturyGothic",color: Colors.black),
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
                        obscureText: true,
                        validator: Validators.compose([
                          Validators.required('Password is require'),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 200.0,
                        height: 50.0,
                        child: RaisedButton(
                          onPressed: (){
                            if(_LoginValidate.currentState.validate()){
                               
                            }
                          },
                          
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(
                              color: Colors.black,
                            )

                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(fontFamily: "CenturyGothic",fontSize: 20.0),
                            ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      )
    );
  }
}