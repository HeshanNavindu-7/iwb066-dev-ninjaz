import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
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
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Notification List
          Positioned(
            top: 0, // No need to set top since AppBar handles the top space
            left: 0,
            right: 0,
            bottom: 80, // Leave space for the navigation bar
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: 3, // Replace with the actual number of notifications
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: Text('Notification Title $index'),
                    subtitle:
                        Text('This is the detail of notification $index.'),
                    onTap: () {
                      // Add your notification tap handling code here
                    },
                  ),
                );
              },
            ),
          ),

          // Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
