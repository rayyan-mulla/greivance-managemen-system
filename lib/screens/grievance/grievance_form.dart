import 'package:flutter/material.dart';

class GrievanceForm extends StatefulWidget {
  @override
  _GrievanceFormState createState() => _GrievanceFormState();
}

class _GrievanceFormState extends State<GrievanceForm> {
  String selectedCategory;
  List<String> categories = [
    "Academic",
    "Hostel",
    "Faculty",
    "Infrastructure",
    "Other",
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherCategoryController = TextEditingController();

  bool showOtherCategoryField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grievance Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Grievance Title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Grievance Description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(Icons.category),
                border: OutlineInputBorder(),
              ),
              value: selectedCategory,
              items: categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  showOtherCategoryField = value == 'Other';
                });
              },
            ),
            if (showOtherCategoryField) ...[
              SizedBox(height: 20),
              TextFormField(
                controller: otherCategoryController,
                decoration: InputDecoration(
                  labelText: 'Other Category',
                  prefixIcon: Icon(Icons.apps),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 16),
              ),
            ],
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Grievance Title: ${titleController.text}');
                  print('Grievance Description: ${descriptionController.text}');
                  print('Selected Category: $selectedCategory');
                  if (showOtherCategoryField) {
                    print('Other Category: ${otherCategoryController.text}');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlueAccent[700],
                  textStyle:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                child: Text('SUBMIT GRIEVANCE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
