import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/doctorDetails.dart';
import 'package:glova_frontend/APIs/userDetails.dart';
import 'package:glova_frontend/Screens/Other/aboutdoctor.dart';
import 'package:glova_frontend/Screens/Other/ambulance.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/doctorRecommendation.dart';
import 'package:glova_frontend/Screens/Other/hospitals.dart';
import 'package:glova_frontend/Screens/Other/market.dart';
import 'package:glova_frontend/Screens/Other/notifications.dart';

import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userName;
  String? doctorName;
  // final ImageFilePicker imageFilePicker = ImageFilePicker();
  final http.Client client = http.Client();

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    _fetchDoctorDetails();
  }

  Future<void> _fetchUserDetails() async {
    try {
      final Map<String, dynamic> data =
          await UserDataManager.fetchUserDetails();
      setState(() {
        userName = data['name'];
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchDoctorDetails() async {
    try {
      final List<dynamic> data = await DoctorDataManager.fetchDoctorDetails();
      if (data.isNotEmpty) {
        setState(() {
          doctorName = data[0]['name'];
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 173, 216, 230),
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Hello, ${userName ?? 'Guest'}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Notifications()),
                  );
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search doctor, drugs, articles...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavigationIcon(
                      'assets/shop.png',
                      'Market',
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Market()),
                      ),
                    ),
                    // _buildNavigationIcon(
                    //   // 'assets/carts.png',
                    //   // 'Cart',
                    //   // () => Navigator.pushReplacement(
                    //   //   // context,
                    //   //   // MaterialPageRoute(builder: (context) => const Cart()),
                    //   // ),
                    // ),
                    _buildNavigationIcon(
                      'assets/hospitals.png',
                      'Hospital',
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Hospitals()),
                      ),
                    ),
                    _buildNavigationIcon(
                      'assets/ambulances.png',
                      'Ambulance',
                      () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Ambulance()),
                      ),
                    ),
                  ],
                ),
                // Padding(
                //   // padding: const EdgeInsets.all(25.0),
                //   // child: _buildImageCarousel(),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Doctors',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const DoctorRecommendation()),
                          );
                        },
                        child: const Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 24, 184, 149),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: _buildDoctorCard(),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 20.0),
                //   child: _buildFeaturedServices(),
                // ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildNavigationIcon(
      String imagePath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: 80,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(imagePath),
                height: 40,
                width: 40,
              ),
              const SizedBox(height: 8.0),
              Text(
                label,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildImageCarousel() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 110,
  //       enlargeCenterPage: true,
  //       autoPlay: true,
  //       autoPlayCurve: Curves.fastOutSlowIn,
  //       enableInfiniteScroll: true,
  //       autoPlayAnimationDuration: Duration(milliseconds: 1000),
  //       viewportFraction: 1,
  //     ),
  //     items: [
  //       'assets/CarosalCard/img1.png',
  //       'assets/CarosalCard/img2.png',
  //       'assets/CarosalCard/img3.png'
  //     ].map((imagePath) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return Container(
  //             margin: EdgeInsets.all(5.0),
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10.0),
  //               image: DecorationImage(
  //                 image: AssetImage(imagePath),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  Widget _buildDoctorCard() {
    return SizedBox(
      width: 180, // Increased width for a better appearance
      child: Card(
        elevation: 5, // Adds shadow to the card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutDoctor(),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/Doctor1.png',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center items horizontally
                children: [
                  Text(
                    doctorName ??
                        'Doctor Name', // Provide a fallback if doctorName is null
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center, // Center text alignment
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Cardiologist',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '4.5', // Placeholder for rating
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        '800m away',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildFeaturedServices() {
  //   return SizedBox(
  //     height: 150,
  //     child: ListView(
  //       scrollDirection: Axis.horizontal,
  //       children: [
  //         _buildServiceCard(
  //           'assets/service1.png',
  //           'Service 1',
  //           'Description for Service 1',
  //         ),
  //         _buildServiceCard(
  //           'assets/service2.png',
  //           'Service 2',
  //           'Description for Service 2',
  //         ),
  //         _buildServiceCard(
  //           'assets/service3.png',
  //           'Service 3',
  //           'Description for Service 3',
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildServiceCard(String imagePath, String title, String description) {
  //   return Container(
  //     margin: EdgeInsets.symmetric(horizontal: 8.0),
  //     width: 120,
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.black, width: 1),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
  //           child: Image.asset(
  //             imagePath,
  //             height: 80,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             title,
  //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //           child: Text(
  //             description,
  //             style: TextStyle(fontSize: 12),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
