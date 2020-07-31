import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'LoginPage.dart';
import 'usermodal.dart';

Future<UserModel> verifyUser(String phone) async {
  final String apiUrl = "http://10.0.2.2:8000/verify-user";

  final response = await http.post(apiUrl, body: {"phone": phone});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    print(response.body);
  }
}

Future<UserModel> registerUser(String phone, String password, String otp,
    String name, String gender) async {
  final String apiUrl = "http://10.0.2.2:8000/create-user";
  final response = await http.post(apiUrl, body: {
    'phone': phone,
    'password': password,
    'OTP': otp,
    'user_type': 'Patient',
    'gender': gender,
    'name': name
  });
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

class PatientRegister extends StatefulWidget {
  @override
  _PatientRegisterState createState() => _PatientRegisterState();
}

class _PatientRegisterState extends State<PatientRegister> {
  AssetImage background = new AssetImage('assets/images/background3.jpg');
  final _PatientRegisterValidate = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();
  final TextEditingController phno = TextEditingController();
  final TextEditingController otpValue = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController uname = TextEditingController();
  final TextEditingController gend = TextEditingController();
  UserModel _user;
  String selectGender = "";
  static List<String> gender = ['Male', 'Female'];

  _onAlertWithCustomImagePressed1(context) {
    Alert(
        context: context,
        title: "REGISTRATION SUCCESS",
        desc: '${_user.detail}',
        image: Image.asset('assets/icons/greentick.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  _onAlertWithCustomImagePressed2(context) {
    Alert(
        context: context,
        title: "REGISTRATION FAILED",
        desc: 'invalid OTP',
        image: Image.asset('assets/icons/redcross.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "close",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  _onAlertWithCustomContentPressed(context) {
    Alert(
        context: context,
        title: '${_user.detail}',
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'enter otp',
              ),
              controller: otpValue,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () async {
              final String phone = phno.text;
              final String password = pass.text;
              final String otp = otpValue.text;
              final String name = uname.text;
              final String gender = gend.text;

              final UserModel user =
                  await registerUser(phone, password, otp, name, gender);
              setState(() {
                _user = user;
              });
              Navigator.pop(context);
              if (_user != null) {
                _onAlertWithCustomImagePressed1(context);
              } else {
                _onAlertWithCustomImagePressed2(context);
              }
            },
            child: Text(
              "verify",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: background, fit: BoxFit.cover)),
      child: Center(
        child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _PatientRegisterValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0),
                      child: TextFormField(
                          controller: uname,
                          decoration: InputDecoration(
                            labelText: "Name",
                            // hintText: "Username",
                            labelStyle: TextStyle(
                                fontFamily: "CenturyGothic",
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 10.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                          ),
                          validator: Validators.compose([
                            Validators.required('Username is required'),
                            Validators.minLength(
                                8, 'Minimum 8 characters required'),
                            Validators.maxLength(20, 'Maximum 20 characters'),
                          ])),
                    ),
                    // phonenumber
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                      child: TextFormField(
                          controller: phno,
                          decoration: InputDecoration(
                            labelText: "Phone Number",
                            labelStyle: TextStyle(
                                fontFamily: "CenturyGothic",
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 10.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                          ),
                          validator: Validators.compose([
                            Validators.required('Username is required'),
                            Validators.minLength(10, 'Invalid Phone Number'),
                            Validators.maxLength(10, 'Invalid Phone Number'),
                          ])),
                    ),
                    //Email
                    Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                      child: TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: "Email",
                            // hintText: "Username",
                            labelStyle: TextStyle(
                                fontFamily: "CenturyGothic",
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 10.0,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                          ),
                          validator: Validators.compose([
                            Validators.required('Username is required'),
                            Validators.email('Invalid Email'),
                          ])),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                      child: DropDownField(
                        controller: gend,
                        labelText: 'Gender',
                        enabled: true,
                        hintText: 'choose a Gender',
                        items: gender,
                        onValueChanged: (value) {
                          setState(() {
                            selectGender = value;
                          });
                        },
                      ),
                    ),
                    // password
                    Padding(
                      padding: EdgeInsets.only(
                          left: 50.0, right: 50.0, top: 10.0),
                      child: TextFormField(
                        controller: pass,
                        obscureText: _passwordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
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
                              fontWeight: FontWeight.bold),
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
                              )),
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
                          onPressed: () async {
                            if (_PatientRegisterValidate.currentState
                                .validate()) {
                              final String phone = phno.text;

                              final UserModel user = await verifyUser(phone);
                              setState(() {
                                _user = user;
                              });
                              if (_user != null) {
                                _onAlertWithCustomContentPressed(context);
                              } else {
                                print('user exists!!');
                              }
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()),
                              );
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                color: Colors.black,
                              )),
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontFamily: "CenturyGothic",
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
