import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  final tabs = [
    AddNewGrievance(),
    GrievanceReport(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Grievance Management System'),
          backgroundColor: Colors.lightBlueAccent[700],
        ),
        backgroundColor: Colors.white,
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          type: BottomNavigationBarType.shifting,
          backgroundColor: Colors.lightBlueAccent[700],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: Colors.lightBlueAccent[700],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.note_alt_rounded),
              title: Text("Grievance Report"),
              backgroundColor: Colors.lightBlueAccent[700],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              title: Text("Profile"),
              backgroundColor: Colors.lightBlueAccent[700],
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class AddNewGrievance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Add new Grievance"),
    );
  }
}

class GrievanceReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Grievance Report"),
    );
  }
}

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("User Profile"),
    );
  }
}
