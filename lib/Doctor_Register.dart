import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import 'LoginPage.dart';
import 'usermodal.dart';

class DoctorRegister extends StatefulWidget {
  @override
  _DoctorRegisterState createState() => _DoctorRegisterState();
}

UserModel _user;

Future<UserModel> verifyUser(String phone) async {
  final String apiUrl = "http://10.0.2.2:8000/verify-user";

  final response = await http.post(apiUrl, body: {"phone": phone});
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else {
    return null;
  }
}

Future<UserModel> registerUser(String phone, String password, String otp,
    String name, String licence, String gender) async {
  final String apiUrl = "http://10.0.2.2:8000/create-user";
  final response = await http.post(apiUrl, body: {
    'phone': phone,
    'password': password,
    'OTP': otp,
    'user_type': 'Doctor',
    'gender': gender,
    'name': name,
    'licence_no': licence,
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

class _DoctorRegisterState extends State<DoctorRegister> {
  final _RegisterValidate = GlobalKey<FormState>();
  AssetImage background = new AssetImage('assets/images/background3.jpg');
  bool _passwordVisible = true;
  final doctorRegisterKey = GlobalKey<FormState>();
  final TextEditingController pass = TextEditingController();
  final TextEditingController phno = TextEditingController();
  final TextEditingController otpValue = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController licenceno = TextEditingController();
  final TextEditingController gend = TextEditingController();
  String selectGender = "";
  static List<String> gender = ['Male', 'Female'];

  @override
  _onAlertWithCustomImagePressed1(context) {
    Alert(
        context: context,
        title: 'REGISTERED SUCCESSFULLY',
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
              final String name = _name.text;
              final String licence = licenceno.text;
              final String gender = gend.text;

              final UserModel user = await registerUser(
                  phone, password, otp, name, licence, gender);
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

  _onAlertWithCustomContentPressed1(context) {
    Alert(
      context: context,
      title: '${_user.detail}',
    );
  }

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
            key: _RegisterValidate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0),
                  child: TextFormField(
                      controller: _name,
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(
                            fontFamily: "CenturyGothic", color: Colors.black),
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
                            fontFamily: "CenturyGothic", color: Colors.black),
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
                Padding(
                  padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                  child: TextFormField(
                    controller: licenceno,
                    decoration: InputDecoration(
                      labelText: "Enter License Number",
                      // hintText: "Username",
                      labelStyle: TextStyle(
                          fontFamily: "CenturyGothic", color: Colors.black),
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
                  ),
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
                            fontFamily: "CenturyGothic", color: Colors.black),
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
                  padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
                  child: TextFormField(
                    controller: pass,
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontFamily: "CenturyGothic", color: Colors.black),
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
                      // onPressed: () {
                      //   if (_RegisterValidate.currentState.validate()) {}
                      // },
                      onPressed: () async {
                        if (_RegisterValidate.currentState.validate()) {
                          final String phone = phno.text;
                          final UserModel user = await verifyUser(phone);
                          setState(() {
                            _user = user;
                          });
                          if (_user != null) {
                            _onAlertWithCustomContentPressed(context);
                          } else {
                            print('user exists');
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
                            fontFamily: "CenturyGothic", fontSize: 20.0),
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
