import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class GrievanceReport extends StatefulWidget {
  @override
  _GrievanceReportState createState() => _GrievanceReportState();
}

class _GrievanceReportState extends State<GrievanceReport> {
  final user = FirebaseAuth.instance.currentUser;
  DatabaseReference _reference =
      FirebaseDatabase.instance.reference().child('Grievances');

  bool isLoading = true;
  bool dataAvailable = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    DataSnapshot snapshot = await _reference.once();

    bool hasData = snapshot.value != null;

    setState(() {
      isLoading = false;
      dataAvailable = hasData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : dataAvailable
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: FirebaseAnimatedList(
                    query: _reference.child(user.uid),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      if (snapshot.value == null) {
                        return Container();
                      } else {
                        return buildGrievanceCard(
                          snapshot.value['title'] ?? '',
                          snapshot.value['description'] ?? '',
                          snapshot.value['category'] ?? '',
                          snapshot.value['date'] ?? '',
                          snapshot.value['other_category'] ?? null,
                          snapshot.value['status'] ?? '',
                        );
                      }
                    },
                  ),
                )
              : Center(
                  child: Text("No Grievance Found"),
                ),
    );
  }

  Widget buildGrievanceCard(
    String title,
    String description,
    String category,
    String date,
    String otherCategory,
    String status,
  ) {
    Color statusColor = _getStatusColor(status);

    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            Divider(color: Colors.grey[400]),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      category ?? '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      date ?? '',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      status ?? '',
                      style: TextStyle(
                        fontSize: 16,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            if (otherCategory != null) ...[
              SizedBox(height: 8),
              Text(
                'Other Category:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              Text(
                otherCategory,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
            SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  label: Text('Edit'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  label: Text('Delete'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    onPrimary: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status?.toLowerCase()) {
      case 'under process':
        return Colors.blue;
      case 'rejected':
        return Colors.red;
      case 'approved':
        return Colors.green;
      case 'affected':
        return Colors.orange;
      case 'new complaint':
        return Colors.purple;
      default:
        return Colors.grey[800];
    }
  }
}
