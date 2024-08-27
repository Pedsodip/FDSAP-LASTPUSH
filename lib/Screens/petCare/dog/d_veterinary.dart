import 'package:flutter/material.dart';

void main() {
  runApp(DogVeterinaryPage());
}

class DogVeterinaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Veterinary Care',
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
                        'assets/design1/dogvet.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildRichTextSection(
                      'Routine Check-ups ',
                      'Schedule annual or bi-annual visits to the veterinarian for health assessments.',
                    ),
                    SizedBox(height: 16),
                    _buildRichTextSection(
                      'Vaccinations ',
                      'Ensure your dog is up-to-date on core vaccinations and receive boosters as recommended by your vet.',
                    ),
                    SizedBox(height: 16),
                    _buildRichTextSection(
                      'Parasite Control ',
                      'Administer preventive medications for heartworm, fleas, ticks, and other parasites.',
                    ),
                    SizedBox(height: 16),
                    _buildRichTextSection(
                      'Health Monitoring ',
                      'Keep track of your dog\'s weight, appetite, and overall behavior for any signs of illness.',
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
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
