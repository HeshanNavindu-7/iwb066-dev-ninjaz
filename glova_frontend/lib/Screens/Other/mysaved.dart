import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/aboutdoctor.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/profilepage.dart';

class MySaved extends StatefulWidget {
  const MySaved({Key? key}) : super(key: key);

  @override
  _MySavedState createState() => _MySavedState();
}

class _MySavedState extends State<MySaved> {
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

  Widget _buildDoctorCard(
      BuildContext context, String doctorName, bool isFavorite) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 227, 227, 227), // Color for the doctor card
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutDoctor()),
                    );
                  },
                  child: const Image(
                    image: AssetImage('assets/doc.png'),
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    doctorName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Cardiologist',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/Rating.png')),
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('assets/Location.png')),
                    ),
                    Text(
                      '800m away',
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    // Toggle favorite status
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Doctors'),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: _isFocused ? '' : 'Search doctor, drugs, articles...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDoctorCard(context, "Dr. John Doe", true),
                  const SizedBox(width: 40),
                  _buildDoctorCard(context, "Dr. Jane Smith", false),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
