import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      'http://localhost:8080/api/tutorials'; // Make sure this matches your backend URL

  // Fetch tutorials
  Future<List<dynamic>> fetchTutorials() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load tutorials');
      }
    } catch (error) {
      throw Exception('Failed to fetch tutorials: $error');
    }
  }

  // Create a new tutorial
  Future<void> createTutorial(String title, String description) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'title': title,
        'description': description,
        'published': false,
      }),
    );

    if (response.statusCode == 201) {
      print('Tutorial created successfully');
    } else {
      print('Failed to create tutorial: ${response.body}');
    }
  }
}
