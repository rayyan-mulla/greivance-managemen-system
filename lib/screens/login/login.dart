import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final phoneNumber = TextEditingController();

  String countryCode = "+91";

  String phoneNumberError;

  bool showLoading = false;

  getMobileNumberWidget(context) {
    return ListView(
      children: [
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 60),

          Text(
            'Greivance Management System',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),

          SizedBox(height: 30),

          // Login Image
          Image.asset('assets/login.png'),

          // Phone Number TextField
          Container(
            child: TextFormField(
              controller: phoneNumber,
              maxLength: 10,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_phone_rounded),
                prefix: Text('+91 '),
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
                errorText: phoneNumberError,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
          ),

          // Send OTP Button
          Container(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.lightBlueAccent[700],
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                setState(() {
                  if (phoneNumber.text.length < 10) {
                    phoneNumberError = "Phone Number must contain 10 Digits";
                  } else {
                    showLoading = true;
                    return null;
                  }
                });
              },
              child: Text('SEND OTP'),
            ),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
          )
        ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : getMobileNumberWidget(context)),
    );
  }
}
