import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Login/signinPage.dart';
import 'package:http/http.dart' as http;

class SignUp_Page extends StatefulWidget {
  const SignUp_Page({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUp_Page> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String phoneNumberErrorText = '';

  Future<void> signUp() async {
    // Your backend endpoint URL
    String url =
        'http://172.20.16.1:8080/addUser'; // Set your backend API URL here

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': firstNameController.text,
          'age': ageController.text,
          'email': emailController.text,
          'phone_number': phoneNumberController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 201) {
        // Request successful
        print('Sign up successful');
        // Navigate to the home screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        // Request failed
        print('Sign up failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Newback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment(-1, -0.5),
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.0, left: 130),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // Input fields
                      buildTextField(
                          firstNameController, 'User Name', Icons.person),
                      buildTextField(
                          ageController, 'Age', Icons.calendar_today),
                      buildTextField(emailController, 'Email', Icons.email),
                      buildPhoneNumberField(),
                      buildTextField(
                          passwordController, 'Password', Icons.lock),
                      buildTextField(
                          null,
                          'Confirm Password',
                          Icons
                              .lock), // Add your controller for confirm password

                      ElevatedButton(
                        onPressed: () {
                          if (_validateFields()) {
                            signUp();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004080),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildSignInPrompt(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build text fields
  Widget buildTextField(
      TextEditingController? controller, String hintText, IconData icon) {
    return Align(
      alignment: const Alignment(0, 0.06),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            hintText: hintText,
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 212, 207, 207)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            filled: true,
            fillColor: const Color(0xFF282635).withOpacity(0.5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          ),
        ),
      ),
    );
  }

  // Helper method to build the phone number field with validation
  Widget buildPhoneNumberField() {
    return Align(
      alignment: const Alignment(0, 0.06),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.phone),
            hintText: 'Phone Number',
            hintStyle:
                const TextStyle(color: Color.fromARGB(255, 212, 207, 207)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.blue, width: 2.0),
            ),
            filled: true,
            fillColor: const Color(0xFF282635).withOpacity(0.5),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
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
      ),
    );
  }

  // Method to validate fields before signup
  bool _validateFields() {
    if (firstNameController.text.isEmpty ||
        ageController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        passwordController.text.isEmpty) {
      // Show error message if any required field is empty
      _showErrorDialog('Please fill in all required fields.');
      return false;
    } else if (phoneNumberErrorText.isNotEmpty) {
      // Show error message if phone number is invalid
      _showErrorDialog(phoneNumberErrorText);
      return false;
    }
    return true;
  }

  // Method to show error dialog
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

  // Method to build sign-in prompt
  Widget _buildSignInPrompt() {
    return Center(
      child: Row(
        children: [
          const SizedBox(width: 80),
          const Text("If you already have an account,"),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignInPage()), // Corrected class name
              );
            },
            child: const Text(
              "Sign In",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
