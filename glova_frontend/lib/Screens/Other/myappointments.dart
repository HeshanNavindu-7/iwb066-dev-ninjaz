import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/appointments.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/doctor_card.dart';
import 'package:glova_frontend/Screens/Other/profilepage.dart';

class MyAppo extends StatefulWidget {
  const MyAppo({Key? key}) : super(key: key);

  @override
  _MyAppoState createState() => _MyAppoState();
}

class _MyAppoState extends State<MyAppo> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 173, 216, 230),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _isFocused ? '' : 'Search for appointments...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Appointment cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DoctorCard(
                        doctorName: "Dr. John Doe",
                        specialty: "Cardiologist",
                        distance: "800m away",
                        imagePath: 'assets/doc.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Appointments(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DoctorCard(
                        doctorName: "Dr. Jane Smith",
                        specialty: "Cardiologist",
                        distance: "800m away",
                        imagePath: 'assets/doc.png',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Appointments(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
