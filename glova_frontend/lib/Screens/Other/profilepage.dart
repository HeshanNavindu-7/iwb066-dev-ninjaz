import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glova_frontend/APIs/userDetails.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/myappointments.dart';
import 'package:glova_frontend/Screens/Other/mysaved.dart';
import 'package:glova_frontend/Screens/Other/paymentmethod.dart';
import 'package:glova_frontend/Screens/Signup/signUpPage.dart';

import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? userAge;

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final Map<String, dynamic> data =
          await UserDataManager.fetchUserDetails();
      setState(() {
        userName = data['name'];
        userAge = data['age']; // Add this line to fetch the age
      });
    } catch (e) {
      // Handle error
      print('Error: $e');
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    String baseUrl = dotenv.env['API_URL'] ?? '';
    String logoutUrl = '$baseUrl/log-out/';

    try {
      final response = await http.post(Uri.parse(logoutUrl));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final message = responseData['success'];

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(message),
        ));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUp_Page(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to logout. Please try again.'),
        ));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  void _navigateToEditProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          currentName: userName ?? '',
          onUpdate: (newName) {
            setState(() {
              userName = newName;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Wallpaper
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profileback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(),
            ),
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
                child: const Icon(Icons.arrow_back, size: 30),
              ),
            ),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/profilegirl.png'), // Use an icon if you want to remove this image
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Text(
                  //   userAge != null ? 'Age: $userAge' : 'Age not available',
                  //   style: const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 16,
                  //   ),
                  // ),
                ],
              ),
            ),
            Positioned(
              top: 80,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white),
                onPressed: _navigateToEditProfile,
              ),
            ),
            Positioned(
              top: 200,
              left: 50,
              right: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Icon(Icons.access_time, size: 30),
                      Text('Age\n24', textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.height, size: 30),
                      Text('Height\n175cm', textAlign: TextAlign.center),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.line_weight, size: 30),
                      Text('Weight\n103 lbs', textAlign: TextAlign.center),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 330,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MySaved(),
                        ),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.favorite, color: Colors.red),
                      title: Text('My Saved'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyAppo(),
                        ),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.blue),
                      title: Text('Appointments'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Pay(),
                        ),
                      );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.payment, color: Colors.green),
                      title: Text('Payment Method'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => const Faq(),
                      //   ),
                      // );
                    },
                    child: const ListTile(
                      leading: Icon(Icons.help_outline, color: Colors.grey),
                      title: Text('FAQs'),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      _handleLogout(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String currentName;
  final ValueChanged<String> onUpdate;

  const EditProfilePage({
    Key? key,
    required this.currentName,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.currentName;
  }

  void _saveChanges() {
    final newName = _nameController.text;
    widget.onUpdate(newName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            // Add more fields here if needed
          ],
        ),
      ),
    );
  }
}
