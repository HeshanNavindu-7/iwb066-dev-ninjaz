// Add the required imports
import 'dart:convert'; // Import this to handle JSON responses

import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Login/signinPage.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String phoneNumberErrorText = '';

  Future<void> signUp() async {
    String url =
        'http://192.168.1.7:8080/api/addUser'; // Set your backend API URL here

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json'
        }, // Set content type to JSON
        body: jsonEncode({
          'first_name': firstNameController.text,
          'age': int.tryParse(ageController.text) ?? 0,
          'email': emailController.text,
          'phone_number': phoneNumberController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 201) {
        print('Sign up successful');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        final responseBody = json.decode(response.body);
        _showErrorDialog(responseBody['message'] ?? 'Sign up failed.');
        print('Sign up failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      _showErrorDialog('An error occurred. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/SignIn.png'), // Set your background image path here
                fit: BoxFit.cover, // Cover the entire screen
              ),
            ),
          ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0), // Dark overlay at the top
                  Colors.transparent, // Transparent in the middle
                  Color.fromARGB(255, 57, 138, 175)
                      .withOpacity(0.6), // Dark overlay at the bottom
                ],
              ),
            ),
          ),
          // Signup Form Content
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 50),
                  const Center(
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  buildTextField(
                      firstNameController, 'Full Name', Icons.person),
                  buildTextField(ageController, 'Age', Icons.calendar_today),
                  buildTextField(emailController, 'Email', Icons.email),
                  buildPhoneNumberField(),
                  buildTextField(passwordController, 'Password', Icons.lock),
                  buildTextField(confirmPasswordController, 'Confirm Password',
                      Icons.lock),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_validateFields()) {
                        signUp();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF1A237E), // Modern blue shade
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Rounded button
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSignInPrompt(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build text fields
  Widget buildTextField(
      TextEditingController controller, String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: controller,
        obscureText: hintText.contains('Password'),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Helper method to build the phone number field with validation
  Widget buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        controller: phoneNumberController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.phone, color: Colors.white),
          hintText: 'Phone Number',
          hintStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.black.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Rounded corners
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
            setState(() {
              phoneNumberErrorText = 'Please enter a valid phone number';
            });
          } else {
            setState(() {
              phoneNumberErrorText = '';
            });
          }
        },
      ),
    );
  }

  bool _validateFields() {
    if (firstNameController.text.isEmpty ||
        ageController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all required fields.');
      return false;
    } else if (phoneNumberErrorText.isNotEmpty) {
      _showErrorDialog(phoneNumberErrorText);
      return false;
    } else if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSignInPrompt() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Already have an account? ",
            style: TextStyle(color: Colors.white70),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text(
              "Sign In",
              style: TextStyle(
                color: Color.fromARGB(255, 10, 118, 233),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
