import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';

class MedAssistAiChat extends StatelessWidget {
  const MedAssistAiChat({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 25,
            child: Row(
              children: [
                //back button
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(top: 30, left: 20),
                    child: Image(
                      image: AssetImage('assets/back.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                //medassist ai
                const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'MedAssist AI',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Image(image: AssetImage('assets/threedots.png')),
                )
              ],
            ),
          ),

          //chat box
          Positioned(
            bottom: 10,
            left: 70,
            right: 40,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Start typing here to chat...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          //send image
          const Positioned(
            bottom: 30,
            left: 300,
            child: Image(
              image: AssetImage('assets/Send.png'),
            ),
          )
        ],
      ),
    );
  }
}
