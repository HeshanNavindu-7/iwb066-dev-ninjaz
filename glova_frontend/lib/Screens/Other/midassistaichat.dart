import 'dart:convert'; // For JSON encoding/decoding

import 'package:flutter/material.dart';
import 'package:glova_frontend/Screens/Home/home.dart';
import 'package:http/http.dart' as http; // Import the HTTP package

class MedAssistAiChat extends StatefulWidget {
  const MedAssistAiChat({Key? key}) : super(key: key);

  @override
  _MedAssistAiChatState createState() => _MedAssistAiChatState();
}

class _MedAssistAiChatState extends State<MedAssistAiChat> {
  final TextEditingController _messageController = TextEditingController();
  List<String> _messages = [
    "How can I assist you with your skin problem?",
  ];

  // Function to send the user's message
  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      // Add the user's message to the list
      setState(() {
        _messages.add(_messageController.text);
        _messageController.clear(); // Clear the input field
      });

      // Call your API to get the response
      await _getApiResponse(_messages.last);
    }
  }

  // Function to get the API response
  Future<void> _getApiResponse(String message) async {
    try {
      // API endpoint
      final url = Uri.parse(
          'https://chat-image-139066790453.us-central1.run.app/questions');

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"question": message}), // Send the message as JSON
      );

      if (response.statusCode == 200) {
        // Parse the response if the call is successful
        final responseBody = json.decode(response.body);
        String apiResponse =
            responseBody['answer']; // Adjust based on your response structure

        setState(() {
          _messages.add(apiResponse); // Add API response to the messages list
        });
      } else {
        // Handle error response
        setState(() {
          _messages.add("Error: Unable to fetch response");
        });
      }
    } catch (e) {
      // Handle exceptions
      setState(() {
        _messages.add("Error: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 173, 216, 230),
        centerTitle: true,
        title: const Text(
          'Glova Chat',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the Home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
            );
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: index % 2 == 0
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.blue[100]
                            : Colors.green[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _messages[index],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Chat input box
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Start typing here to chat...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onSubmitted: (value) {
                      _sendMessage(); // Send message on keyboard submit
                    },
                  ),
                ),
                const SizedBox(width: 10),
                // Send button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueGrey),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
