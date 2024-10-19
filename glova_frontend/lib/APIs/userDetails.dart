import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserDataManager {
  static Future<Map<String, dynamic>> fetchUserDetails() async {
    String baseUrl = dotenv.env['192.168.1.7'] ?? '';
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
