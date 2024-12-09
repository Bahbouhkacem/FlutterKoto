import 'package:flutter/material.dart';
import '../services/api_service.dart'; // Corrected import path
import '../screens/add_tutorial_page.dart'; // Use `../` to go up a folder

class TutorialListScreen extends StatefulWidget {
  @override
  _TutorialListScreenState createState() => _TutorialListScreenState();
}

class _TutorialListScreenState extends State<TutorialListScreen> {
  final ApiService apiService = ApiService();
  List<dynamic> tutorials = [];

  @override
  void initState() {
    super.initState();
    fetchTutorials();
  }

  void fetchTutorials() async {
    try {
      List<dynamic> data = await apiService.fetchTutorials();
      setState(() {
        tutorials = data;
      });
    } catch (error) {
      print('Error fetching tutorials: $error');
    }
  }

  // Navigate to AddTutorialPage and refresh list after adding a tutorial
  void navigateToAddTutorialPage() async {
    // Wait for the user to finish adding a tutorial
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTutorialPage()), // Correct class name
    );
    // After returning from AddTutorialPage, refresh the list
    fetchTutorials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tutorial List')),
      body: tutorials.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: tutorials.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tutorials[index]['title']),
                  subtitle: Text(tutorials[index]['description']),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddTutorialPage, // Navigate to AddTutorialPage
        child: Icon(Icons.add),
        tooltip: 'Add Tutorial',
      ),
    );
  }
}
