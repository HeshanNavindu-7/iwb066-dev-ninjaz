import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserDataManager {
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    String baseUrl = dotenv.env['BASE_URL'] ??
        ''; // Change this to your environment variable name
    final response = await http.get(Uri.parse('$baseUrl/users/'));

    if (response.statusCode == 200) {
      // Parse the response JSON
      return jsonDecode(response.body);
    } else {
      // Handle error
      throw Exception('Failed to fetch user details: ${response.statusCode}');
    }
  }
}
