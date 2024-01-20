import 'package:flutter/material.dart';
import 'package:grievance_management_system/screens/grievance/grievance_report.dart';
import 'package:grievance_management_system/screens/grievance/grievance_start_screen.dart';
import 'package:grievance_management_system/screens/profile/profile.dart';

class Home extends StatefulWidget {
  final int index;
  Home({Key key, this.index = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;

  final tabs = [
    GrievanceStartScreen(),
    GrievanceReport(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

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
