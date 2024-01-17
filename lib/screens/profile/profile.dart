import 'package:flutter/material.dart';
import 'package:grievance_management_system/screens/login/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                  'John Doe',
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
                  '42315',
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
                  'Computer Engineering',
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
                  'john.doe@gmail.com',
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
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
        child: Icon(Icons.logout_rounded),
      ),
    );
  }
}
