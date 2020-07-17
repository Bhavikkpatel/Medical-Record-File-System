import 'package:flutter/material.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _RegisterValidate = GlobalKey<FormState>();

    bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Form(
              key: _RegisterValidate,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                  padding: EdgeInsets.only(left: 50.0,right: 50.0),
                  child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Name",
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
                                                                                                              // phonenumber
                      Padding(
                  padding: EdgeInsets.only(left: 50.0,right: 50.0,top: 10.0),
                  child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Phone Number",
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
                      Validators.minLength(10,'Invalid Phone Number'),
                      Validators.maxLength(10,'Invalid Phone Number'),
                    ]
                  )
                      ),
                    ),
                                                                                                              //Email
                    Padding(
                  padding: EdgeInsets.only(left: 50.0,right: 50.0,top: 10.0),
                  child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
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
                      Validators.email('Invalid Email'),
                    ]
                  )
                      ),
                    ),
                                                                                                              // password
                    Padding(
                  padding: EdgeInsets.only(left: 50.0,right: 50.0,top: 10.0),
                  child: TextFormField(
                  obscureText: _passwordVisible,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: (){
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
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
                  
                  validator: Validators.compose([
                    Validators.required('Password is require'),
                    Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,20}$', 'Enter valid password'),
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
                      onPressed: (){
                      if(_RegisterValidate.currentState.validate()){
                        
                      }
                    },
                    
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: Colors.black,
                      )

                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(fontFamily: "CenturyGothic",fontSize: 20.0),
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