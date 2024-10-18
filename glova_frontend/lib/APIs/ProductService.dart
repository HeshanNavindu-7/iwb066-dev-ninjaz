import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _baseUrl =
      'https://your-backend-url.com/api/products'; // Replace with your API endpoint

  // Function to send product data to the backend
  Future<http.Response> addProduct(Map<String, dynamic> productData) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body:
            jsonEncode(productData), // Convert the product data to JSON format
      );

      if (response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Failed to add product');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
