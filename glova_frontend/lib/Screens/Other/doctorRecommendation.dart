import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/doctorcards.dart';

class DoctorRecommendation extends StatefulWidget {
  const DoctorRecommendation({Key? key}) : super(key: key);

  @override
  _DoctorRecommendationState createState() => _DoctorRecommendationState();
}

class _DoctorRecommendationState extends State<DoctorRecommendation> {
  List<dynamic> _doctors = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  // void initState() {
  //   super.initState();
  //   _fetchDoctorDetails();
  // }

  // Future<void> _fetchDoctorDetails() async {
  //   try {
  //     final List<dynamic> doctors =
  //         await DoctorDataManager.fetchDoctorDetails();
  //     setState(() {
  //       _doctors = doctors;
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     print('Error: $e');
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = _doctors.where((doctor) {
      final name = doctor['name'].toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Doctors'),
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
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
      ),
      body: Column(
        children: [
          // Search Box
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 189, 189, 189)
                        .withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 25,
                    offset: const Offset(0, 7),
                  ),
                ],
              ),
              child: TextField(
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search for doctors...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ),
          // Dynamic Doctor Cards
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredDoctors.isEmpty
                    ? const Center(child: Text('No doctors available'))
                    : ListView.builder(
                        itemCount: filteredDoctors.length,
                        itemBuilder: (context, index) {
                          final doctor = filteredDoctors[index];
                          return DoctorCard(
                              doctor: doctor); // Pass doctor data to DoctorCard
                        },
                      ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
