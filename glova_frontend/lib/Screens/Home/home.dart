import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:glova_frontend/APIs/doctorDetails.dart';
import 'package:glova_frontend/APIs/userDetails.dart';
import 'package:glova_frontend/Screens/Other/aboutdoctor.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/doctorRecommendation.dart';
import 'package:glova_frontend/Screens/Other/notifications.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? userName;
  String? doctorName;

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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: _buildImageCarousel(),
                ),
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
                  child: _buildDoctorCards(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildFeaturedProducts(),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }

  Widget _buildDoctorCards() {
    // Dummy doctor data with placeholder names and specialties
    final List<Map<String, String>> doctors = [
      {
        'name': 'Dr. Sarah Johnson',
        'specialty': 'Cardiologist',
        'distance': '800m away'
      },
      {
        'name': 'Dr. John Doe',
        'specialty': 'Dermatologist',
        'distance': '1.2km away'
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: doctors.map((doctor) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _buildDoctorCard(
              doctor['name']!,
              doctor['specialty']!,
              doctor['distance']!,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDoctorCard(String name, String specialty, String distance) {
    return SizedBox(
      width: 160, // Adjusted width to avoid overflow
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutDoctor()),
                );
              },
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  'assets/carosal/doc2.jpg',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      const Text('4.5',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                      const Spacer(),
                      const Icon(Icons.location_on,
                          color: Colors.grey, size: 14),
                      const SizedBox(width: 4),
                      Text(distance,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
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

  Widget _buildImageCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 130,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 1,
      ),
      items: [
        'assets/carosal/img1.png',
        'assets/carosal/img2.png',
        'assets/carosal/img3.png',
      ].map((imagePath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFeaturedProducts() {
    // Dummy skincare products
    final List<Map<String, String>> products = [
      {'imagePath': 'assets/beauty.png', 'title': 'Aloe Vera Gel'},
      {'imagePath': 'assets/carosal/p1.png', 'title': 'Vitamin C Serum'},
      {'imagePath': 'assets/p2.jpg', 'title': 'Sunscreen SPF'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Featured Skincare Products',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: products.map((product) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child:
                    _buildProductCard(product['imagePath']!, product['title']!),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(String imagePath, String title) {
    return SizedBox(
      width: 150,
      height: 180,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                imagePath,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
