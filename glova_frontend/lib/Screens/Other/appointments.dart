import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:glova_frontend/Screens/Other/aboutdoctor.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';

class Appointments extends StatefulWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  DateTime _selectedDate = DateTime.now();
  String _selectedGender = '';
  String _selectedTime = '';

  // Function to select a date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Function to get the formatted day string
  // String _getDayString(DateTime date) {
  //   return "${date.day} ${DateFormat('MMM').format(date)}";
  // }

  @override
  Widget build(BuildContext context) {
    DateTime day1 = _selectedDate.subtract(const Duration(days: 1));
    DateTime day2 = _selectedDate;
    DateTime day3 = _selectedDate.add(const Duration(days: 1));
    DateTime day4 = _selectedDate.add(const Duration(days: 2));

    // Sample time slots
    List<String> timeSlots = ['9:00 AM', '9:30 AM', '10:00 AM'];

    return Scaffold(
      body: Container(
        // Background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/appoinmentback.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Navigation bar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(),
            ),
            // New appointment
            Positioned(
              top: 10,
              right: 100,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AboutDoctor(),
                          ),
                        );
                      },
                      child: const Image(
                        image: AssetImage('assets/back.png'),
                        height: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      'New Appointment',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Date picker
            Positioned(
              top: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    // Text(
                    //     '${DateFormat('MMMM').format(_selectedDate)}, ${_selectedDate.year}'),
                    // const SizedBox(width: 10),
                    // GestureDetector(
                    //   onTap: () {
                    //     _selectDate(context);
                    //   },
                    //   child: const Image(
                    //     image: AssetImage('assets/downarrow.png'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            // Days buttons
            Positioned(
              top: 100,
              left: 15,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  _buildDayButton(day1, day1 == _selectedDate),
                  const SizedBox(width: 10),
                  _buildDayButton(day2, day2 == _selectedDate),
                  const SizedBox(width: 10),
                  _buildDayButton(day3, day3 == _selectedDate),
                  const SizedBox(width: 10),
                  _buildDayButton(day4, day4 == _selectedDate),
                ],
              ),
            ),
            // Available Time
            const Positioned(
              top: 165,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Available Time',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Positioned(
              top: 190,
              left: 30,
              child: Row(
                children: timeSlots
                    .map(
                        (time) => _buildTimeButton(time, time == _selectedTime))
                    .toList(),
              ),
            ),
            // Patient details
            const Positioned(
              top: 235,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Patient Details',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Positioned(
              top: 265,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Full Name'),
                    const SizedBox(
                        height:
                            10), // Add some space between the text and the text field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Age
            Positioned(
              top: 365,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Age'),
                    const SizedBox(
                        height:
                            10), // Add some space between the text and the text field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter your age',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Gender
            Positioned(
              top: 465,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gender'),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 65),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = 'Male';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == 'Male'
                                  ? Colors.blueAccent
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text(
                              'Male',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(width: 40),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _selectedGender = 'Female';
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedGender == 'Female'
                                  ? Colors.blueAccent
                                  : const Color.fromARGB(255, 255, 255, 255),
                            ),
                            child: const Text(
                              'Female',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Problem
            Positioned(
              top: 545,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Problem'),
                    const SizedBox(
                        height:
                            10), // Space between the label and the text field
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Write your problem in detail',
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 173, 170, 170),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Book appointment
            Positioned(
              top: 655,
              left: 70,
              child: GestureDetector(
                onTap: () {
                  // Handle the 'Book appointment' action here
                },
                child: Container(
                  width: 250,
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: const Center(
                    child: Text(
                      'Book Appointment',
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
    );
  }

  // Build a day button widget
  Widget _buildDayButton(DateTime date, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          // child: Text(
          //   _getDayString(date),
          //   style: TextStyle(
          //     color: isSelected ? Colors.white : Colors.black,
          //   ),
          // ),
        ),
      ),
    );
  }

  // Build a time button widget
  Widget _buildTimeButton(String time, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTime = time;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueAccent : Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.black12),
          ),
          child: Text(
            time,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
