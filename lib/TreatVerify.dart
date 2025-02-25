import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

import 'doctor_treat.dart';
import 'usermodal.dart';

class TreatVerify extends StatefulWidget {
  @override
  _TreatVerifyState createState() => _TreatVerifyState(token);
  String token;

  TreatVerify(this.token);
}

class _TreatVerifyState extends State<TreatVerify> {
  final _requestPhone = GlobalKey<FormState>();

  TextEditingController _pphone = new TextEditingController();
  TextEditingController _otpValue = new TextEditingController();

  String token;

  _TreatVerifyState(this.token);

  Future<UserModel> verifyUser(String phone) async {
    final String aurl = "http://10.0.2.2:8000/request-access";
    final response = await http.post(aurl, body: {
      "patient_phone": phone,
    }, headers: {
      "Authorization": "Token " + token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return userModelFromJson(responseString);
    } else
      return null;
  }

  Future<UserModel> otpVerify(String _otp, String phone) async {
    final String aurl = "http://10.0.2.2:8000/verify-access-otp";
    final response = await http.post(aurl, body: {
      "OTP": _otp,
      "patient_phone": phone,
    }, headers: {
      "Authorization": "Token " + token,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return userModelFromJson(responseString);
    } else
      return null;
  }

  UserModel _user;

  _onAlertWithCustomImagePressed1(context) {
    Alert(
        context: context,
        title: 'ACCESS GRANTED',
        desc: '${_user.detail}',
        image: Image.asset('assets/icons/greentick.png'),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Doctor_Treat(_pphone.text, token),
                  ));
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
        title: "ACCESS DENIED",
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
              controller: _otpValue,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            onPressed: () async {
              final String phone = _pphone.text;
              final String otp = _otpValue.text;

              final UserModel user = await otpVerify(otp, phone);
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

  AssetImage background = new AssetImage('assets/images/background3.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: background,
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _requestPhone,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'phone number',
                        ),
                        controller: _pphone,
                        validator: (value) {
                          Pattern pattern = r'^\d{10}$';
                          RegExp regex = new RegExp(pattern);
                          if (value.isEmpty) {
                            return 'please enter a phone number';
                          }
                          if (!regex.hasMatch(value)) {
                            return 'Enter a valid phone number ';
                          } else {
                            return null;
                          }
                        },
                      ),
                      FlatButton(
                        onPressed: () async {
                          if (_requestPhone.currentState.validate()) {
                            final String phone = _pphone.text;

                            final UserModel user = await verifyUser(phone);
                            setState(() {
                              _user = user;
                            });
                            if (_user != null) {
                              _onAlertWithCustomContentPressed(context);
                            } else {
                              print('user does\'nt exists');
                            }
                          }
                        },
                        child: Container(
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'Get OTP',
                            style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: 'Bangers',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
