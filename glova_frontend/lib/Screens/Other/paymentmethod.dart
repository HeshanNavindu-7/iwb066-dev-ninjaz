import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
import 'package:glova_frontend/Screens/Other/profilepage.dart';

class Pay extends StatefulWidget {
  const Pay({Key? key}) : super(key: key);

  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  bool rememberMe = false;
  bool savingsAccount = false;
  bool currentAccount = false;
  String? selectedBank = 'Union Bank'; // Initial selected bank

  final List<String> banks = [
    'Union Bank',
    'Commercial Bank',
    'HSBC',
    'Sampath Bank',
    'Hatton National Bank'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profile2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 25,
              left: 10,
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfilePage(),
                        ),
                      );
                    },
                    child: const Image(
                      image: AssetImage('assets/back.png'),
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 45),
                  // Payment Method text
                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              left: 20,
              child: Container(
                width: 350,
                height: 132,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Rs. 14800/=',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(child: Text('Ref. Number: 4587621569'))
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 260,
              left: 50,
              right: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    '  Pay with  ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 300,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('How would you like to pay?'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text('Credit or Debit card'),
                      const SizedBox(width: 10),
                      const Image(
                        image: AssetImage('assets/visa.png'),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      const Image(
                        image: AssetImage('assets/master.png'),
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() {
                            rememberMe = value!;
                          });
                        },
                      ),
                      const Text('Pay Online (Mobile Banking)'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 425,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Bank'),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.black, width: 1),
                      color: Colors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedBank,
                        items: banks.map((String bank) {
                          return DropdownMenuItem<String>(
                            value: bank,
                            child: Text(bank),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedBank = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 520,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Account Type'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: savingsAccount,
                        onChanged: (bool? value) {
                          setState(() {
                            savingsAccount = value!;
                            if (savingsAccount) {
                              currentAccount = false;
                            }
                          });
                        },
                      ),
                      const Text('Saving Account'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: currentAccount,
                        onChanged: (bool? value) {
                          setState(() {
                            currentAccount = value!;
                            if (currentAccount) {
                              savingsAccount = false;
                            }
                          });
                        },
                      ),
                      const Text('Current Account'),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 640,
              left: 105,
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Select',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Navigation Bar
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomBottomNavigationBar(),
            ),
          ],
        ),
      ),
    );
  }
}
