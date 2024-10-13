import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/doctorDetails.dart';

import 'aboutdoctor.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({super.key, required doctor});

  @override
  _DoctorCardState createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  List<dynamic>? doctorData;

  @override
  void initState() {
    super.initState();
    _fetchDoctorDetails();
  }

  Future<void> _fetchDoctorDetails() async {
    try {
      final List<dynamic> data = await DoctorDataManager.fetchDoctorDetails();

      if (data.isNotEmpty) {
        setState(() {
          doctorData = data;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: doctorData == null
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: doctorData!.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> doctor = doctorData![index];
                return buildDoctorCard(doctor);
              },
            ),
    );
  }

  Widget buildDoctorCard(Map<String, dynamic> doctor) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutDoctor(),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Image(
              image: AssetImage('assets/Doctor1.png'),
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Text(
                doctor['name'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 5),
              child: Text(
                doctor['specialties'] ?? 'Unknown',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/Rating.png'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/Location.png'),
                  ),
                ),
                Text(
                  '800m away',
                  style: TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
