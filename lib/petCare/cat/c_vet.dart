import 'package:flutter/material.dart';

void main() {
  runApp(CatVetPage());
}

class CatVetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Veterinary Care',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
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
              color: const Color.fromARGB(255, 249, 249, 249),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/design1/catvet.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Routine Check-ups ',
                      'Schedule regular veterinary visits for wellness exams, vaccinations, and preventive care.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Vaccinations ',
                      'Keep your cat up-to-date on core vaccinations and receive boosters as recommended by your vet.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Parasite Control ',
                      'Administer flea, tick, and heartworm preventives as prescribed by your veterinarian.',
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
