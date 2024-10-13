import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final String doctorName;
  final String specialty;
  final String distance;
  final String imagePath;
  final VoidCallback onTap;

  const DoctorCard({
    Key? key,
    required this.doctorName,
    required this.specialty,
    required this.distance,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 200,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 227, 227),
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Image(
                image: AssetImage(imagePath),
                height: 100,
                width: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                doctorName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                specialty,
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/Rating.png')),
                ),
                const SizedBox(width: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('assets/Location.png')),
                ),
                Text(
                  distance,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
