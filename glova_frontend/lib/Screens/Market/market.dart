import 'dart:convert'; // For JSON encoding and decoding
import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/ProductService.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;

class MarketPlaceScreen extends StatefulWidget {
  @override
  _MarketPlaceScreenState createState() => _MarketPlaceScreenState();
}

class _MarketPlaceScreenState extends State<MarketPlaceScreen> {
  List<ProductService> _products = [];
  List<ProductService> _filteredProducts = [];
  bool _isLoading = true;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 1; // Default to Marketplace

  @override
  void initState() {
    super.initState();
    _fetchProducts(); // Fetch products on initialization
    _searchController
        .addListener(_filterProducts); // Listen for changes in the search input
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
          _filteredProducts = _products; // Initialize filtered list
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

  // Function to filter products based on search input
  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProducts = _products.where((product) {
        return product.productName.toLowerCase().contains(query) ||
            product.category.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller
    super.dispose();
  }

  // Function to handle bottom navigation bar item taps
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add navigation logic here, if necessary
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 173, 216, 230),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search ...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(
                height: 16.0), // Add space between search bar and product list
            Expanded(
              child: _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Show loading spinner
                  : _errorMessage.isNotEmpty
                      ? Center(
                          child: Text(_errorMessage,
                              style: TextStyle(color: Colors.red)))
                      : _filteredProducts.isEmpty
                          ? Center(child: Text('No products available'))
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 cards in a row
                                childAspectRatio:
                                    1, // Adjusted aspect ratio for shorter cards
                                crossAxisSpacing: 12.0,
                                mainAxisSpacing: 16.0,
                              ),
                              itemCount: _filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = _filteredProducts[index];

                                // Constructing full image path if it's a relative path
                                final imageUrl = product.imagePath != null &&
                                        product.imagePath!.isNotEmpty
                                    ? (product.imagePath!.startsWith('http')
                                        ? product.imagePath!
                                        : 'http://192.168.1.7:8080${product.imagePath!}') // Construct full URL if path is relative
                                    : null; // Set to null if no image

                                return Card(
                                  elevation: 4.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Displaying the image
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(10)),
                                        child: imageUrl != null
                                            ? Image.network(
                                                imageUrl,
                                                height:
                                                    70, // Further decrease height here
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Image.asset(
                                                    'assets/beauty.png', // Fallback asset image
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/beauty.png', // Fallback asset image if no URL
                                                height:
                                                    70, // Further decrease height here
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                            4.0), // Reduced padding
                                        child: Text(
                                          product.productName ?? 'No Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0), // Reduced padding
                                        child: Text(
                                          '\$${product.price?.toStringAsFixed(2) ?? 'N/A'} - ${product.category ?? 'Unknown Category'}',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
