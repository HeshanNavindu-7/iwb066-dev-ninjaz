import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class DoctorDataManager {
  static Future<List<dynamic>> fetchDoctorDetails() async {
    String baseUrl = dotenv.env['API_URL'] ?? '';
    final response = await http.get(Uri.parse('$baseUrl/doctors/'));

    if (response.statusCode == 200) {
      // Parse the response JSON
      return jsonDecode(response.body);
    } else {
      // Handle error
      throw Exception('Failed to fetch doctor details: ${response.statusCode}');
    }
  }
}
