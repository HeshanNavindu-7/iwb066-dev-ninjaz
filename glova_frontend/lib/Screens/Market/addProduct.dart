import 'dart:io'; // For File operations

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; // For image picking

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _productDetailsController =
      TextEditingController();
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  // Function to handle image picking
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
    }
  }

  // Function to handle the form submission
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Prepare the product data as a form field
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://192.168.1.100:8080/api/addProduct'),
      );

      // Add text fields as form fields
      request.fields['product_name'] = _productNameController.text;
      request.fields['price'] = _priceController.text;
      request.fields['category'] = _categoryController.text;
      request.fields['product_details'] = _productDetailsController.text;

      // If an image is selected, add it as a multipart file
      if (_imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'image', // field name in backend
          _imageFile!.path,
        ));
      }

      // Send the request
      try {
        var streamedResponse = await request.send();
        var response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Product added successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to add product: ${response.body}')),
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
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Enter category' : null,
              ),
              TextFormField(
                controller: _productDetailsController,
                decoration: InputDecoration(labelText: 'Product Details'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter product details' : null,
              ),
              SizedBox(height: 20),
              _imageFile != null
                  ? Image.file(_imageFile!, height: 150, width: 150)
                  : Text('No image selected.'),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Upload Image'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
