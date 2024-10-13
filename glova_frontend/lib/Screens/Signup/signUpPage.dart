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
    String url = '';

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
        // ignore: use_build_context_synchronously
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
        )),
        child: Stack(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 30, left: 10),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigate back to the previous screen when the button is pressed
            //       Navigator.pop(context);
            //     },
            //     child: const Padding(
            //       padding: EdgeInsets.only(top: 4),
            //       child: Text('Go Back'),
            //     ),
            //   ),
            // ),
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
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                      ),
                      //firstName
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                            controller: firstNameController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                hintText: 'User Name',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 207, 207)),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFF282635).withOpacity(0.5),
                                contentPadding: (const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2.5))),
                          ),
                        ),
                      ),

                      //Age
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.calendar_today),
                                hintText: 'Age',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 207, 207)),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFF282635).withOpacity(0.5),
                                contentPadding: (const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2.5))),
                          ),
                        ),
                      ),
                      //Email Address
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.email),
                                hintText: 'Email',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 207, 207)),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFF282635).withOpacity(0.5),
                                contentPadding: (const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2.5))),
                          ),
                        ),
                      ),
                      //Phone Number
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.phone),
                                  hintText: 'Phone Number',
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 212, 207, 207)),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.blue, // Border color
                                      width: 2.0, // Border width
                                    ),
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFF282635).withOpacity(0.5),
                                  contentPadding: (const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2.5))),
                              onChanged: (value) {
                                if (!RegExp(r'^[0-9]*$').hasMatch(value)) {
                                  setState(() {
                                    phoneNumberErrorText =
                                        'Please enter a valid phone number';
                                  });
                                } else {
                                  setState(() {
                                    phoneNumberErrorText = '';
                                  });
                                }
                              }),
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 207, 207)),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFF282635).withOpacity(0.5),
                                contentPadding: (const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2.5))),
                          ),
                        ),
                      ),
                      //Confirm Password
                      Align(
                        alignment: const Alignment(0, 0.06),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 15.0),
                          child: TextField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.lock),
                                hintText: ' Confirm Password',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 212, 207, 207)),
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.blue, // Border color
                                    width: 2.0, // Border width
                                  ),
                                ),
                                filled: true,
                                fillColor:
                                    const Color(0xFF282635).withOpacity(0.5),
                                contentPadding: (const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2.5))),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 230,
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/RememberMe.png'),
                            ),
                            SizedBox(width: 5),
                            Text('Remember Me'),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        //uncomment following comment when testing with backend
                        onPressed: () {
                          if (firstNameController.text.isEmpty ||
                              ageController.text.isEmpty ||
                              emailController.text.isEmpty ||
                              phoneNumberController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            // Show error message if any required field is empty
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: const Text(
                                      'Please fill in all required fields.'),
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
                          } else if (phoneNumberErrorText.isNotEmpty) {
                            // Show error message if phone number is invalid
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Error'),
                                  content: Text(phoneNumberErrorText),
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
                          } else {
                            // All fields are filled and phone number is valid, proceed with sign-up
                            signUp();
                          }
                        },

                        //Only testing purpose (Front end testing)
                        /* onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Home()), // Corrected class name
                          );
                        },*/
                        //end of the testing code

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004080),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // Border radius
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15), // Padding
                        ), // Change button color here
                        child: const Text(
                          'Sign Up ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                    child: Row(children: [
                  const SizedBox(
                    width: 80,
                  ),
                  const Text("If you already have an account,"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignInPage()), // Corrected class name
                        );
                      },
                      child: const Text(
                        'SignIn',
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 76, 236),
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 18, 76, 236),
                        ),
                      )),
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
