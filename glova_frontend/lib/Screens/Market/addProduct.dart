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
          'http://192.168.1.103:8080/api/addProduct'); // Replace with your backend URL
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Product Name Field
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product name' : null,
              ),
              // Price Field
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
              ),
              // Category Field
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter category' : null,
              ),
              // Product Details Field
              TextFormField(
                controller: _productDetailsController,
                decoration: InputDecoration(labelText: 'Product Details'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product details' : null,
              ),
              // Image Uploader
              SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(_imageFile!,
                      height: 150, width: 150) // Show selected image
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _pickImage, // Pick image logic
                child: Text('Upload Image'),
              ),
              Spacer(),
              // Submit Button
              ElevatedButton(
                onPressed: _submitForm, // Submit form logic
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
