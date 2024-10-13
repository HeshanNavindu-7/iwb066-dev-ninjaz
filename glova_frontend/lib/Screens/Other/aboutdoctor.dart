import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/reviewdoctor.dart';
// import 'package:midassist/screens/appointments.dart';
// import 'package:midassist/screens/home.dart';
// import 'package:midassist/screens/reviewdoctor.dart';

// import 'custom_bottom_navigation_bar.dart';

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profileback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            //Navigation Bar
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(),
            ),
            //Doctor photo
            const Positioned(
              top: 50,
              left: 150,
              child: Image(image: AssetImage('assets/smalldoc.png')),
            ),
            const Positioned(
              top: 170,
              left: 150,
              child: Text(
                'Dr. Marcus Holmes',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            //Doctor Review
            Positioned(
              top: 190,
              left: 152,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Review(),
                    ),
                  );
                },
                child: const Text(
                  'Review this doctor',
                  style: TextStyle(color: Color.fromARGB(255, 14, 99, 236)),
                ),
              ),
            ),
            //Three Icons
            const Positioned(
              top: 220,
              left: 50,
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Image(image: AssetImage('assets/patient.png')),
                      ),
                      Text(' 10000+\nPatients'),
                    ],
                  ),
                  SizedBox(
                    width: 55,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Image(image: AssetImage('assets/years.png')),
                      ),
                      Text('  10 Years+\n Experience'),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Image(image: AssetImage('assets/star.png')),
                      ),
                      Text('   4.5\nRating'),
                    ],
                  ),
                ],
              ),
            ),
            //About Doctor

            Positioned(
              top: 320,
              left: 15,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // About Doctor
                    const Text(
                      'About Doctor',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8), // Adds space between text blocks
                    const Padding(
                      padding: EdgeInsets.only(left: 7.0),
                      child: Text(
                        'Dr. Marcus Holmes is a top specialist at London Bridge \nHospital at London. He has achieved several awards and \nrecognition for his contribution in his own field.',
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Working Time
                    const Text(
                      'Working Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.only(left: 7.0),
                      child: Text('Mon - Sat (08:30 AM - 09:00 PM)'),
                    ),
                    const SizedBox(height: 10),
                    // Communication
                    const Text(
                      'Communication',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Messaging
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45, top: 10),
                          child: Image.asset('assets/message.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Messaging\nChat me up, share photos.'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Audio Call
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45, top: 10),
                          child: Image.asset('assets/call.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Audio Call\nCall your doctor directly.'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Video Call
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45, top: 10),
                          child: Image.asset('assets/video.png'),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text('Video Call\nSee your doctor live.'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Book appointment
            Positioned(
              top: 715,
              left: 70,
              child: GestureDetector(
                onTap: () {
                  // Handle the 'Book appointment' action here
                },
              ),
            ),
            //Back button
            Positioned(
              top: 35,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ),
                  );
                },
                child: const Image(
                  image: AssetImage('assets/back.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
