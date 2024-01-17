import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:grievance_management_system/screens/login/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _auth = FirebaseAuth.instance;

  final user = FirebaseAuth.instance.currentUser;

  DatabaseReference _reference =
      FirebaseDatabase.instance.reference().child('Users');

  String name = '';
  String rollNumber = '';
  String department = '';
  String email = '';

  @override
  void initState() {
    super.initState();

    _reference
        .child(user.uid)
        .child('name')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        name = snapshot.value;
      });
    });

    _reference
        .child(user.uid)
        .child('roll_number')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        rollNumber = snapshot.value;
      });
    });

    _reference
        .child(user.uid)
        .child('department')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        department = snapshot.value;
      });
    });

    _reference
        .child(user.uid)
        .child('email')
        .once()
        .then((DataSnapshot snapshot) {
      setState(() {
        email = snapshot.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                maxRadius: 80.0,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(
                    'https://freesvg.org/img/abstract-user-flat-4.png'),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text(
                  'Name',
                  style: TextStyle(color: Colors.black54),
                ),
                subtitle: Text(
                  name,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.confirmation_number_rounded),
                title: Text(
                  'Roll Number',
                  style: TextStyle(color: Colors.black54),
                ),
                subtitle: Text(
                  rollNumber,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.business_rounded),
                title: Text(
                  'Department',
                  style: TextStyle(color: Colors.black54),
                ),
                subtitle: Text(
                  department,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.email_rounded),
                title: Text(
                  'Email',
                  style: TextStyle(color: Colors.black54),
                ),
                subtitle: Text(
                  email,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Icon(Icons.logout_rounded),
      ),
    );
  }
}
