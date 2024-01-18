import 'package:flutter/material.dart';

class GrievanceReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            buildGrievanceCard(
              'Title 1',
              'Description for grievance 1. This is a longer description to demonstrate the layout.',
              'Category A',
              '2022-01-01',
              'Technical Issues',
              'Under Process',
            ),
            buildGrievanceCard(
              'Title 2',
              'Description for grievance 2.',
              'Category B',
              '2022-01-02',
              null,
              'Rejected',
            ),
            buildGrievanceCard(
              'Title 3 with a Very Long Name',
              'Description for grievance 3. This is another long description to test the layout.',
              'Category C',
              '2022-01-03',
              'Miscellaneous',
              'Approved',
            ),
            buildGrievanceCard(
              'Title 4',
              'Description for grievance 4.',
              'Category D',
              '2022-01-04',
              null,
              'Affected',
            ),
            buildGrievanceCard(
              'Title 5',
              'Description for grievance 5. This is a new complaint description.',
              'Category E',
              '2022-01-05',
              'Suggestions',
              'New Complaint',
            ),
          ],
        ),
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
                fontSize: 24,
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
                      category,
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
                      date,
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
                      status,
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
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
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
