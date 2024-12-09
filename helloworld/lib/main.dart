import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'screens/add_tutorial_page.dart'; // Import the AddTutorialPage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorial App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TutorialListScreen(),
    );
  }
}

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
        onPressed: () {
          // Navigate to the AddTutorialPage
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTutorialPage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Tutorial',
      ),
    );
  }
}
