import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';
// import 'package:midassist/screens/myappointments.dart';
// import 'package:midassist/screens/custom_bottom_navigation_bar.dart';

class AppDet extends StatelessWidget {
  const AppDet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      //Background
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //back button
                GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   // context,
                    //   // MaterialPageRoute(
                    //   //   builder: (context) => const MyAppo(),
                    //   // ),
                    // );
                  },
                  child: const Image(
                    image: AssetImage('assets/back.png'),
                    height: 50,
                  ),
                ),
                const SizedBox(
                  width: 35,
                ),
                //appointment details text
                const Text(
                  'Appointment Details',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          //doctor photo
          const Positioned(
            top: 90,
            left: 25,
            child: Image(
              image: AssetImage(
                'assets/Doctor1.png',
              ),
              width: 150,
              height: 150,
            ),
          ),
          //doctor details
          const Positioned(
            top: 100,
            left: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Marcus Holmes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  'Viralogist',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '1km away',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '+94 70 123 456 7',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Image(
                      image: AssetImage(
                        'assets/calender.jpg',
                      ),
                      width: 35,
                      height: 35,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [Text('2024 July 07'), Text('10am-12am')],
                    )
                  ],
                ),
              ],
            ),
          ),
          //services
          const Positioned(
              top: 270,
              left: 35,
              child: Column(
                children: [
                  Text(
                    'Services',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Order Examination',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 140,
                      ),
                      Text('Rs. 1500/h')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Blood Test',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 190,
                      ),
                      Text('Rs. 800/=')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Pressure Test',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 170,
                      ),
                      Text('Rs. 300/=')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Kidney Checkup',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 165,
                      ),
                      Text('Rs. 5300/=')
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        'Heart Checkup',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        width: 165,
                      ),
                      Text('Rs. 8300/=')
                    ],
                  )
                ],
              )),
          const Positioned(
              top: 550,
              left: 20,
              child: Image(image: AssetImage('assets/changebutton.png'))),
          const Positioned(
              top: 625,
              left: 20,
              child: Image(image: AssetImage('assets/cancelbutton.png'))),
          //Navigation Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    ));
  }
}
