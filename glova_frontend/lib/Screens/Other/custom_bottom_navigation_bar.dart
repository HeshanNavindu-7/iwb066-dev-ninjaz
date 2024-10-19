import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Market/Market.dart';
import 'package:glova_frontend/Screens/Other/midassistaichat.dart';

import 'package:glova_frontend/Screens/Other/profilepage.dart';

import 'package:http/http.dart' as http;

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  // final ImageFilePicker imageFilePicker = ImageFilePicker();
  final http.Client client = http.Client();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MarketPlaceScreen()),
        );
        break;
      case 2:
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ImageUploder(
        //       imageFilePicker: imageFilePicker,
        //       client: client,
        //     ),
        //   ),
        // );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MedAssistAiChat()),
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.picture_as_pdf),
              label: 'Pdf',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Analyzer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'MediChat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color.fromARGB(221, 67, 67, 67),
          backgroundColor: Color.fromARGB(255, 173, 216, 230),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
