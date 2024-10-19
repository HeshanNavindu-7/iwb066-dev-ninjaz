import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/ProductService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding and decoding

class MarketPlaceScreen extends StatefulWidget {
  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  List<ProductService> _products = [];
  bool _isLoading = true;

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
        throw Exception('Failed to load products');
      }
    } catch (error) {
      print('Error fetching products: $error');
      setState(() {
        _isLoading = false;
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
          ? Center(
              child: CircularProgressIndicator(), // Show loading spinner
            )
          : _products.isEmpty
              ? Center(child: Text('No products available'))
              : ListView.builder(
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];

                    // Constructing full image path if it's a relative path
                    final imageUrl = product.imagePath != null
                        ? product.imagePath!.contains('http')
                            ? product.imagePath!
                            : 'http://192.168.1.7:8080${product.imagePath!}' // Append the base URL if imagePath is relative
                        : null;

                    return Card(
                      child: ListTile(
                        leading: imageUrl != null
                            ? Image.network(
                                imageUrl,
                                width: 50, // Set width
                                height: 50, // Set height
                                fit: BoxFit
                                    .cover, // Ensure the image fits within the box
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons
                                      .broken_image); // Show fallback if image fails to load
                                },
                              )
                            : Icon(Icons.image), // Fallback icon if no image
                        title: Text(product.productName),
                        subtitle:
                            Text('\$${product.price} - ${product.category}'),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          // You can add navigation to product details page here
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
