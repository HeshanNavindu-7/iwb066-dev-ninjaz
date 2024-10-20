import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Login/signinPage.dart';
import 'package:glova_frontend/Screens/Signup/signUpPage.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/secondPageBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            //Title
            const FractionallySizedBox(
              widthFactor: 0.7,
              child: Align(
                alignment: Alignment(5, 0.1),
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Nourish Your Beauty with Glova',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF423838),
                    ),
                  ),
                ),
              ),
            ),

            //small sentence
            const FractionallySizedBox(
              widthFactor: 0.9,
              child: Align(
                alignment: Alignment(5, 0.45),
                child: Padding(
                  padding: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Glova, your trusted skincare companion, is dedicated to safeguarding the health and radiance of your skin.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF423838),
                    ),
                  ),
                ),
              ),
            ),

            //Sign Up Button
            Align(
              alignment: const Alignment(-0.65, 0.7),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Padding
                ), // Change button color here
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            //Sign In Button
            Align(
              alignment: const Alignment(0.65, 0.7),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004080),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50), // Border radius
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 15), // Padding
                ), // Change button color here
                child: const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
