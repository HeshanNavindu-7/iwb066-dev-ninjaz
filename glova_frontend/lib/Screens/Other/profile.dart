import 'dart:io';
import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/profilepage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  // Variable to store the path of the selected image
  String? _selectedImagePath;

  // State to toggle between view and edit modes
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers if needed
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  // Future<void> _pickFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.image,
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _selectedImagePath = result.files.single.path;
  //     });
  //   } else {
  //     // User canceled the picker
  //   }
  // }

  void _updateProfile() {
    // Get values from controllers
    String name = _nameController.text;
    String age = _ageController.text;
    String height = _heightController.text;
    String weight = _weightController.text;

    // Print or handle the updated profile data
    print('Name: $name, Age: $age, Height: $height, Weight: $weight');

    // Show a success message or navigate away
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile updated successfully!')),
    );

    // Handle additional actions such as saving data to a server or local storage
    setState(() {
      _isEditing = false; // Exit edit mode
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 25,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back button
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('assets/back.png'),
                    height: 50,
                  ),
                ),
                const SizedBox(width: 50),
                // Market text
                const Text(
                  'Profile Update',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Positioned(
            top: 80,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Edit Your Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 50,
            child: _selectedImagePath != null
                ? Image.file(
                    File(_selectedImagePath!),
                    height: 100,
                    width: 100,
                  )
                : Image.asset('assets/profilegirl.png'),
          ),
          Positioned(
            top: 150,
            left: 150,
            child: GestureDetector(
              // onTap: _pickFile,
              child: Container(
                width: 200,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Center(
                  child: Text(
                    'Change Profile Photo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 240,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 275,
            left: 10,
            right: 10,
            child: _isEditing
                ? TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                : Text(
                    _nameController.text.isEmpty
                        ? 'Enter your name'
                        : _nameController.text,
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          const Positioned(
            top: 340,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Age',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 375,
            left: 10,
            right: 10,
            child: _isEditing
                ? TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your age',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                : Text(
                    _ageController.text.isEmpty
                        ? 'Enter your age'
                        : _ageController.text,
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          const Positioned(
            top: 440,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Height',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 475,
            left: 10,
            right: 10,
            child: _isEditing
                ? TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      hintText: 'Enter your height',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                : Text(
                    _heightController.text.isEmpty
                        ? 'Enter your height'
                        : _heightController.text,
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          const Positioned(
            top: 540,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Your Weight',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Positioned(
            top: 575,
            left: 10,
            right: 10,
            child: _isEditing
                ? TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      hintText: 'Enter your weight',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  )
                : Text(
                    _weightController.text.isEmpty
                        ? 'Enter your weight'
                        : _weightController.text,
                    style: TextStyle(fontSize: 18),
                  ),
          ),
          Positioned(
            top: 655,
            left: 70,
            child: GestureDetector(
              onTap: _isEditing
                  ? _updateProfile
                  : () {
                      setState(() {
                        _isEditing = true; // Enter edit mode
                      });
                    },
              child: Container(
                width: 250,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black12),
                ),
                child: Center(
                  child: Text(
                    _isEditing ? 'Save Profile' : 'Edit Profile',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
