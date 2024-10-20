import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Signup/signUpPage.dart';
import 'package:http/http.dart' as http;
// import 'package:Glova/screens/signUpPage.dart';

// import 'home.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn() async {
    // Your backend endpoint URL
    String url = 'http://192.168.1.4:8080/api/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': usernameController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        // Request successful
        final responseData = jsonDecode(response.body);
        final userId = responseData['user_id'];
        print(userId);
        print('Sign in successful');
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
            image: AssetImage('assets/SignIn.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment(-1, -0.5),
                    child: Padding(
                      padding: EdgeInsets.only(left: 30.0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 58, 57, 57),
                        ),
                      ),
                    ),
                  ),
                  //Username
                  Align(
                    alignment: const Alignment(0, 0.06),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(113, 255, 255, 255)),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.blue, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF282635).withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),

                  //Password
                  Align(
                    alignment: const Alignment(0, 0.06),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color.fromARGB(113, 255, 255, 255)),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              color: Colors.blue, // Border color
                              width: 2.0, // Border width
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xFF282635).withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Image(
                        image: AssetImage('assets/RememberMe.png'),
                      ),
                      SizedBox(width: 5),
                      Text('Remember Me'),
                      SizedBox(
                        width: 130,
                      ),
                      Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 18, 76, 236),
                          decoration: TextDecoration.underline,
                          decorationColor: Color.fromARGB(255, 18, 76, 236),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    //uncomment following comment when testing with backend
                    // onPressed: signIn,

                    //Only testing purpose (Front end testing)
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home()), // Corrected class name
                      );
                    },
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
                      'Sign In',
                      style:
                          TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Row(children: [
                    const SizedBox(
                      width: 80,
                    ),
                    const Text("Don't have an account?"),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignUpPage()), // Corrected class name
                          );
                        },
                        child: const Text(
                          'SignUp',
                          style: TextStyle(
                            color: Color.fromARGB(255, 18, 76, 236),
                            decoration: TextDecoration.underline,
                            decorationColor: Color.fromARGB(255, 18, 76, 236),
                          ),
                        )),
                  ])),
                  const Column(children: [
                    Text('or'),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage('assets/Loginfb.png')),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Image(image: AssetImage('assets/Logingoogle.png')),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
