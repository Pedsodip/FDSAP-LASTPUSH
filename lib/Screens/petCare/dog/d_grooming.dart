import 'package:flutter/material.dart';

void main() {
  runApp(DogGroomingPage());
}

class DogGroomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Grooming',
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
                        'assets/design1/doggroom.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Brushing ',
                      'Use a suitable brush for your dog\'s coat type (e.g., slicker brush, bristle brush) to remove loose hair and prevent mats.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Bathing ',
                      'Bathe your dog with dog-specific shampoo when they are visibly dirty or have a noticeable odor.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Nail Trimming ',
                      'Keep your dog\'s nails trimmed to a safe length to prevent discomfort and potential injury.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Ear Cleaning ',
                      'Regularly check and clean your dog\'s ears to prevent infections.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Dental Care ',
                      'Brush your dog\'s teeth regularly with a dog toothbrush and toothpaste to maintain dental hygiene.',
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
