import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';

class Hospitals extends StatefulWidget {
  const Hospitals({Key? key}) : super(key: key);

  @override
  _HospitalsState createState() => _HospitalsState();
}

class _HospitalsState extends State<Hospitals> {
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
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        title: const Text("Hospitals"),
        centerTitle: true,
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
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _isFocused ? '' : 'Search for hospitals...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          // Hospitals list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                HospitalItem(
                  name: 'General Hospital Matale',
                  contactNumber: '011-1234567',
                  location: 'Matale, Sri Lanka',
                ),
                HospitalItem(
                  name: 'Asiri Hospitals Kandy',
                  contactNumber: '011-2345678',
                  location: 'Kandy, Sri Lanka',
                ),
                HospitalItem(
                  name: 'Suwa Sewana Hospitals Kandy',
                  contactNumber: '011-3456789',
                  location: 'Kandy, Sri Lanka',
                ),
                HospitalItem(
                  name: 'Kumudu Hospitals Matale',
                  contactNumber: '011-4567890',
                  location: 'Matale, Sri Lanka',
                ),
                HospitalItem(
                  name: 'Lanka Hospitals Kandy',
                  contactNumber: '011-5678901',
                  location: 'Kandy, Sri Lanka',
                ),
              ],
            ),
          ),
          // Navigation Bar
          const CustomBottomNavigationBar(),
        ],
      ),
    );
  }
}

class HospitalItem extends StatefulWidget {
  final String name;
  final String contactNumber;
  final String location;

  const HospitalItem({
    Key? key,
    required this.name,
    required this.contactNumber,
    required this.location,
  }) : super(key: key);

  @override
  _HospitalItemState createState() => _HospitalItemState();
}

class _HospitalItemState extends State<HospitalItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.name,
              style: const TextStyle(
                  // Make the hospital name bold
                  ),
            ),
            trailing: IconButton(
              icon: Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Contact: ${widget.contactNumber}'),
                  const SizedBox(height: 5),
                  Text('Location: ${widget.location}'),
                  const SizedBox(height: 10),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
