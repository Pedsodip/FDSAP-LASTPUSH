import 'package:flutter/material.dart';

void main() {
  runApp(DogMonitorPage());
}

class DogMonitorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Monitor Health Changes',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 15),
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 1,
              color: Color.fromARGB(255, 249, 249, 249),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/design1/dogmonitor.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Be Observant ',
                      'Watch for changes in your dog\'s appetite, energy levels, coat condition, and bathroom habits.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Consult Your Vet ',
                      'Contact your veterinarian promptly if you notice any signs of illness or discomfort.',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRichTextSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.0), // Adjust spacing between title and content
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            height: 1.5, // Adjust line height for content
          ),
        ),
      ],
    );
  }
}
