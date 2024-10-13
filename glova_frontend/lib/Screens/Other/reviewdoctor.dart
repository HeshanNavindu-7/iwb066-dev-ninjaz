import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/aboutdoctor.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  _ReviewState createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  int _selectedStars = 0;
  bool _isMedAssist = false;
  bool _isChecked = false;

  Widget _buildStarRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center stars
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedStars = index + 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Image(
              image: AssetImage(_selectedStars > index
                  ? 'assets/goldstar1.png'
                  : 'assets/goldstar.png'),
              width: 30,
              height: 30,
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appoinmentback.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutDoctor(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('assets/back.png'),
                    width: 34,
                    height: 34,
                  ),
                ),
              ),
              const SizedBox(height: 0), // Add some spacing
              // Doctor Image and Name
              Center(
                child: Column(
                  children: [
                    Image.asset('assets/smalldoc.png', width: 120, height: 120),
                    const SizedBox(height: 8),
                    const Text(
                      'Dr. Marcus Holmes',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Review question
              const Padding(
                padding: EdgeInsets.only(top: 16, left: 16),
                child: Text(
                  'How likely would you recommend Dr. Marcus?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 18),
              _buildStarRow(),
              const SizedBox(height: 16),
              // Review Title
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Review Title',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your title',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 173, 170, 170)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Tell More
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Tell us more about your visit',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'What stood out in your visit?',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 173, 170, 170)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // MedAssist?
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Was this a MedAssist appointment?',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isMedAssist = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            _isMedAssist ? Colors.white : Colors.black,
                        backgroundColor: _isMedAssist
                            ? Color.fromARGB(255, 0, 7, 81)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text('Yes'),
                    ),
                    const SizedBox(width: 8), // Space between buttons
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isMedAssist = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor:
                            !_isMedAssist ? Colors.white : Colors.black,
                        backgroundColor: !_isMedAssist
                            ? Color.fromARGB(255, 0, 7, 81)
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                      ),
                      child: const Text('No'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Email
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'E-mail',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your E-mail',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 173, 170, 170)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Bottom text
              const Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '(Your email is for confirmation of your review and will NOT appear on the review)',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              // Checkbox
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'I verify that I or my family member have received treatment from '
                        'this doctor and agree to the MedAssist User Agreement, Editorial '
                        'Policy, and Privacy Policy.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Save and Submit
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    // Handle the 'Save and submit' action here
                  },
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 7, 81),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: const Center(
                      child: Text(
                        'Save and Submit',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
