import 'package:flutter/material.dart';

class GrievanceStartScreen extends StatefulWidget {
  @override
  _GrievanceStartScreenState createState() => _GrievanceStartScreenState();
}

class _GrievanceStartScreenState extends State<GrievanceStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to the Student Grievance Management System!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Do you have a grievance to report?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'If yes, click on the "Initiate Complaint" button below to submit your grievance.',
                style: TextStyle(fontSize: 14, color: Colors.black38),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.lightBlueAccent[700],
                      textStyle:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                    child: Text('Initiate Complaint')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
