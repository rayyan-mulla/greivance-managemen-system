import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  File image;

  bool showLoading = false;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final rollNumberController = TextEditingController();

  String selectedDepartment;
  List<String> departments = [
    "Artificial Intelligence",
    "Civil Engineering",
    "Computer Engineering",
    "Electrical Engineering",
    "Eelecronics Engineering",
    "Information Technology",
    "Mechanical Engineering",
  ];

  DatabaseReference _reference =
      FirebaseDatabase.instance.reference().child('Users');

  final user = FirebaseAuth.instance.currentUser;

  void registerUser() {
    String name = nameController.text;
    String rollNumber = rollNumberController.text;
    String email = emailController.text;

    _reference.child(user.uid).set({
      'name': name,
      'roll_number': rollNumber,
      'department': selectedDepartment,
      'email': email,
    });

    setState(() {
      showLoading = false;
    });
  }

  Future pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage == null) return;
    final temporaryImage = File(pickedImage.path);
    setState(() {
      image = temporaryImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 40),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Student Grievance Registration',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Join us to address and resolve your concerns',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CircleAvatar(
                maxRadius: 80.0,
                backgroundColor: Colors.black,
                backgroundImage: image != null
                    ? FileImage(image)
                    : NetworkImage(
                        'https://freesvg.org/img/abstract-user-flat-4.png'),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.camera_alt_rounded),
                                  title: Text('Camera'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickImage(ImageSource.camera);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.image_rounded),
                                  title: Text('Gallery'),
                                  onTap: () {
                                    Navigator.pop(context);
                                    pickImage(ImageSource.gallery);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent[700],
                          child: Icon(Icons.add_a_photo_rounded,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_rounded),
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: rollNumberController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.confirmation_number_rounded),
                  labelText: 'Roll Number',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Department',
                  prefixIcon: Icon(Icons.business_rounded),
                  border: OutlineInputBorder(),
                ),
                value: selectedDepartment,
                items: departments.map((dept) {
                  return DropdownMenuItem(
                    value: dept,
                    child: Text(dept),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.mail_rounded),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),
              Container(
                child: TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.lightBlueAccent[700],
                    textStyle:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    registerUser();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  backgroundColor: Colors.white,
                                  body: Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )));
                    await Future.delayed(Duration(seconds: 5), () {
                      print(nameController.text);
                      print(emailController.text);
                      print(rollNumberController.text);
                      print(selectedDepartment);
                    });
                  },
                  child: Text('REGISTER'),
                ),
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
