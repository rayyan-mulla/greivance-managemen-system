import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grievance_management_system/screens/registration/registration.dart';

enum MobileVerification {
  Display_Mobile_Form_State,
  Display_OTP_Verification_State,
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  MobileVerification currentState =
      MobileVerification.Display_Mobile_Form_State;

  final phoneNumber = TextEditingController();
  final otpDigit1 = TextEditingController();
  final otpDigit2 = TextEditingController();
  final otpDigit3 = TextEditingController();
  final otpDigit4 = TextEditingController();
  final otpDigit5 = TextEditingController();
  final otpDigit6 = TextEditingController();

  String otp;

  String countryCode = "+91";

  String phoneNumberError;

  bool showLoading = false;

  String verificationId;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.additionalUserInfo.isNewUser) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Registration()));
      } else {
        print("Existing User");
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      phoneNumberError = e.message;
    }
  }

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
                await _auth.verifyPhoneNumber(
                    phoneNumber: countryCode + phoneNumber.text,
                    verificationCompleted: (phoneAuthCredential) async {
                      setState(() {
                        showLoading = false;
                      });
                    },
                    verificationFailed: (FirebaseAuthException exception) {
                      setState(() {
                        showLoading = false;
                      });
                      if (exception.code == 'invalid-phone-number') {
                        phoneNumberError = "Invalid Phone Number";
                      }
                    },
                    codeSent: (verificationId, resendingToken) async {
                      setState(() {
                        showLoading = false;
                        currentState =
                            MobileVerification.Display_OTP_Verification_State;
                        this.verificationId = verificationId;
                      });
                    },
                    codeAutoRetrievalTimeout: (verificationId) async {});
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

  getOTPVerificationWidget(context) {
    final node = FocusScope.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'OTP Verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Please Enter the OTP send to +91 ${phoneNumber.text}',
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
          ),
          SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit1,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit2,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit3,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit4,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit5,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
              SizedBox(width: 10),
              Flexible(
                  child: Container(
                child: TextFormField(
                  controller: otpDigit6,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.length == 1) node.nextFocus();
                  },
                  decoration: InputDecoration(
                    counter: Offstage(),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                width: 40,
              )),
            ],
          ),
          SizedBox(height: 60),
          Container(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.lightBlueAccent[700],
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                otp = otpDigit1.text +
                    otpDigit2.text +
                    otpDigit3.text +
                    otpDigit4.text +
                    otpDigit5.text +
                    otpDigit6.text;
                print(otp);
                PhoneAuthCredential phoneAuthCredential =
                    PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: otp);
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              child: Text('VERIFY'),
            ),
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          )
        ],
      )),
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
            : currentState == MobileVerification.Display_Mobile_Form_State
                ? getMobileNumberWidget(context)
                : getOTPVerificationWidget(context),
      ),
    );
  }
}
