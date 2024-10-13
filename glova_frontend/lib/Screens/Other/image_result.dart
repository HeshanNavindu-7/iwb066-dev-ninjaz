import 'package:flutter/material.dart';

class ImageResult extends StatelessWidget {
  final dynamic imageData; // Adjust the type based on your needs

  const ImageResult({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Result'),
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
              'Image Data: $imageData'), // Display or process the image data
        ),
      ),
    );
  }
}
