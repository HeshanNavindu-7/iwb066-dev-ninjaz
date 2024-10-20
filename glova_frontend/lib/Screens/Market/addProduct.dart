import 'dart:convert'; // For encoding JSON
import 'dart:io'; // For File operations

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // For image picking

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  // Form key and controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productDetailsController =
      TextEditingController();
  File? _imageFile; // To store the picked image file

  // Image picker instance
  final ImagePicker _picker = ImagePicker();

  // Function to handle image picking
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      // Handle error or null image picking
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
    }
  }

  // Function to handle the form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the product data
      Map<String, dynamic> productData = {
        'product_name': _productNameController.text,
        'price': int.parse(_priceController.text),
        'category': _categoryController.text,
        'product_details': _productDetailsController.text,
        'image_path': _imageFile != null ? _imageFile!.path : null,
      };

      // Make the POST request to the backend
      final url = Uri.parse(
          'http://192.168.1.7:8080/api/addProduct'); // Replace with your backend URL
      try {
        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(productData),
        );

        if (response.statusCode == 201) {
          // Success - product added
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added successfully!')),
          );
          // Optionally, clear the form after submission
          _clearForm();
        } else {
          // Failure - handle error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product.')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      }
    }
  }

  // Function to clear the form fields after submission
  void _clearForm() {
    _productNameController.clear();
    _priceController.clear();
    _categoryController.clear();
    _productDetailsController.clear();
    setState(() {
      _imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        centerTitle: true, // Center the title
        backgroundColor: Color.fromARGB(255, 173, 216, 230), // AppBar color
      ),
      body: SingleChildScrollView(
        // Handle overflow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Product Name Field
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter product name' : null,
                ),
                SizedBox(height: 10), // Spacing between text fields

                // Price Field
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter price' : null,
                ),
                SizedBox(height: 10), // Spacing between text fields

                // Category Field
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter category' : null,
                ),
                SizedBox(height: 10), // Spacing between text fields

                // Product Details Field
                TextFormField(
                  controller: _productDetailsController,
                  decoration: InputDecoration(
                    labelText: 'Product Details',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                  ),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter product details' : null,
                ),
                SizedBox(height: 20),

                // Image Uploader
                _imageFile != null
                    ? Image.file(_imageFile!,
                        height: 150, width: 150) // Show selected image
                    : Text('No image selected.'),
                ElevatedButton(
                  onPressed: _pickImage, // Pick image logic
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    // Button color
                  ),
                  child: Text('Upload Image'),
                ),
                SizedBox(height: 20), // Spacing before submit button

                // Submit Button
                ElevatedButton(
                  onPressed: _submitForm, // Submit form logic
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15), // Rounded corners
                    ),
                    backgroundColor:
                        Color.fromARGB(255, 173, 216, 230), // Button color
                  ),
                  child: Text('Add Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
