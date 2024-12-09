import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Import the ApiService

class AddTutorialPage extends StatefulWidget {
  @override
  _AddTutorialPageState createState() => _AddTutorialPageState();
}

class _AddTutorialPageState extends State<AddTutorialPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Tutorial'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String title = _titleController.text;
                String description = _descriptionController.text;

                if (title.isEmpty || description.isEmpty) {
                  // Show an error message if any field is empty
                  print('Both fields must be filled');
                  return;
                }

                // Call the createTutorial method to save the tutorial
                try {
                  await apiService.createTutorial(title, description);
                  // After tutorial is created, go back to the previous screen
                  Navigator.pop(context);
                } catch (error) {
                  print('Error creating tutorial: $error');
                }
              },
              child: Text('Create Tutorial'),
            ),
          ],
        ),
      ),
    );
  }
}
