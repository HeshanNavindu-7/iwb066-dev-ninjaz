import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
// import 'package:midassist/screens/home.dart';
// import 'package:midassist/screens/custom_bottom_navigation_bar.dart';

class Ambulance extends StatelessWidget {
  const Ambulance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(
            255, 173, 216, 230), // You can customize the AppBar color
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 200,
            left: 65,
            child: Image(image: AssetImage('assets/1919.png')),
          ),
          Positioned(
            top: 500,
            left: 45,
            child: Text(
              'Call an emergency service vehicle',
              style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 253, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
          // Add the red circular button
          Positioned(
            bottom: 100,
            right: 30,
            child: FloatingActionButton(
              onPressed: () {
                // Add your emergency call logic here
              },
              backgroundColor: Colors.red,
              child: const Icon(Icons.call, color: Colors.white),
            ),
          ),
          // Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(),
          )
        ],
      ),
    );
  }
}
