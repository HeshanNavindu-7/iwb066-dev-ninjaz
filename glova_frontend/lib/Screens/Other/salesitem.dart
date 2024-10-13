import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:glova_frontend/Screens/Other/custom_bottom_navigation_bar.dart';

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  int _amount = 0;
  final double _itemPrice = 5625.0; // Price of a single item

  void _incrementAmount() {
    setState(() {
      _amount++;
    });
  }

  void _decrementAmount() {
    setState(() {
      if (_amount > 0) {
        _amount--;
      }
    });
  }

  double get _totalPrice => _amount * _itemPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 25,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Back button
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                  child: const Image(
                    image: AssetImage('assets/back.png'),
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
          // Image and details
          const Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Image(image: AssetImage('assets/beauty.png')),
              ),
              // Text
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Boston Round Full Package',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      'Rs. 5625/=',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Image(image: AssetImage('assets/Rating.png'))
                ],
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    'The Boston Round Full Package offers a complete solution for skincare enthusiasts, featuring both cream and body lotion packaged in sleek, durable Boston Round bottles. These bottles, renowned for their classic cylindrical design and ease of use, ensure optimal product preservation and convenience. '),
              )
            ],
          ),
          // Increment button, amount display, and total price
          Positioned(
            top: 500,
            left: 40,
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _decrementAmount,
                      child: const Text('Decrease Amount'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: _incrementAmount,
                      child: const Text('Increase Amount'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Amount: $_amount',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total Price: Rs. ${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Add to cart image
          Positioned(
            top: 655,
            left: 70,
            child: GestureDetector(
              onTap: () {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Cart(),
                //   ),
                // );
              },
              child: Container(
                width: 250,
                height: 60,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black12),
                ),
                child: const Center(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Navigation Bar
          Positioned(
            top: 728,
            left: 0,
            right: 0,
            child: CustomBottomNavigationBar(),
          ),
        ],
      ),
    );
  }
}
