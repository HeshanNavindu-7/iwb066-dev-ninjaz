import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/ProductService.dart';
import 'package:http/http.dart' as http;

class MarketPlaceScreen extends StatefulWidget {
  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  List<ProductService> _products = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products on initialization
  }

  // Function to fetch products from the backend
  Future<void> _fetchProducts() async {
    final url = Uri.parse(
        'http://192.168.1.7:8080/api/products'); // Replace with your actual backend URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Decode the JSON response into a list of Product objects
        final List<dynamic> productData = jsonDecode(response.body);
        setState(() {
          _products =
              productData.map((data) => ProductService.fromJson(data)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage =
              'Failed to load products. Status code: ${response.statusCode}';
        });
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error fetching products: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : _errorMessage.isNotEmpty
              ? Center(
                  child:
                      Text(_errorMessage, style: TextStyle(color: Colors.red)))
              : _products.isEmpty
                  ? Center(child: Text('No products available'))
                  : ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];

                        // Constructing full image path if it's a relative path
                        final imageUrl = product.imagePath != null &&
                                product.imagePath!.isNotEmpty
                            ? (product.imagePath!.startsWith('http')
                                ? product.imagePath!
                                : 'http://192.168.1.7:8080${product.imagePath!}') // Construct full URL if path is relative
                            : 'https://via.placeholder.com/150'; // Use placeholder image if no image

                        return Card(
                          elevation: 4.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: ListTile(
                            leading: Image.network(
                              imageUrl,
                              width: 50, // Set width
                              height: 50, // Set height
                              fit: BoxFit
                                  .cover, // Ensure the image fits within the box
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons
                                    .broken_image); // Show fallback if image fails to load
                              },
                            ),
                            title: Text(product.productName ?? 'No Name'),
                            subtitle: Text(
                              '\$${product.price?.toStringAsFixed(2) ?? 'N/A'} - ${product.category ?? 'Unknown Category'}',
                            ),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              // Navigation to product details or another screen can be added here
                              // Navigator.push(...);
                            },
                          ),
                        );
                      },
                    ),
    );
  }
}
