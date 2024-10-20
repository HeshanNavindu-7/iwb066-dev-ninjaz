import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class SkinCareScreen extends StatefulWidget {
  @override
  _SkinCareScreenState createState() => _SkinCareScreenState();
}

class _SkinCareScreenState extends State<SkinCareScreen> {
  File? _selectedImage;
  String? _skinType;
  String? _skinTone;
  bool _isLoading = false;
  final picker = ImagePicker();

  final List<String> skinTypes = ['Oily', 'Dry', 'Combination'];
  final List<String> skinTones = ['Fair', 'Medium', 'Dark'];

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 150,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.blue),
              title: Text('Take a Photo'),
              onTap: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    _selectedImage = File(pickedFile.path);
                  });
                } else {
                  _showSnackbar('No image selected.');
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.blue),
              title: Text('Select from Gallery'),
              onTap: () async {
                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    _selectedImage = File(pickedFile.path);
                  });
                } else {
                  _showSnackbar('No image selected.');
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitData() async {
    if (_selectedImage == null || _skinType == null || _skinTone == null) {
      _showSnackbar('Please complete all fields and select an image.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final uri = Uri.parse('http://192.168.1.100:3000/skin-care-routines');
    var request = http.MultipartRequest('POST', uri);

    request.files.add(
      await http.MultipartFile.fromPath('file', _selectedImage!.path),
    );
    request.fields['skin_type'] = _skinType!;
    request.fields['skin_tone'] = _skinTone!;

    try {
      final response = await request.send();
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        _showSnackbar('Prediction successful!', isError: false);
        _showResult(responseBody);
      } else {
        final errorResponse = await response.stream.bytesToString();
        _showSnackbar('Error: ${response.statusCode}, Details: $errorResponse');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showSnackbar('Error: $e');
    }
  }

  void _showSnackbar(String message, {bool isError = true}) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            isError ? Icons.error : Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Expanded(child: Text(message)),
        ],
      ),
      backgroundColor: isError ? Colors.red : Colors.green,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showResult(String result) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Prediction Result',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[200]!, Colors.blue[800]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                  Center(
                    child: Text(
                      'Skin Care Prediction',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Upload a photo and select your skin type and tone to receive personalized care recommendations.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                            child: Center(
                              child: Icon(Icons.camera_alt,
                                  size: 50, color: Colors.blue),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(_selectedImage!,
                                height: 200, fit: BoxFit.cover),
                          ),
                  ),
                  SizedBox(height: 50),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Skin Type',
                          border: OutlineInputBorder(),
                        ),
                        value: _skinType,
                        onChanged: (value) {
                          setState(() {
                            _skinType = value;
                          });
                        },
                        items: skinTypes
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Select Skin Tone',
                          border: OutlineInputBorder(),
                        ),
                        value: _skinTone,
                        onChanged: (value) {
                          setState(() {
                            _skinTone = value;
                          });
                        },
                        items: skinTones
                            .map((tone) => DropdownMenuItem(
                                  value: tone,
                                  child: Text(tone),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: Colors.blue[600],
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      onPressed: _isLoading ? null : _submitData,
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Submit'),
                    ),
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
