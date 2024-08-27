import 'package:flutter/material.dart';

void main() {
  runApp(DogDietPage());
}

class DogDietPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Nutritional Diet',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 15),
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
                        'assets/design1/dogtreat.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Consult with a Vet ',
                      'Talk to your veterinarian about the best diet for your dog based on their age, breed, weight, and health conditions.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Choose High-Quality Dog Food ',
                      'Select a commercial dog food that meets the Association of American Feed Control Officials (AAFCO) standards.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Follow Feeding Guidelines ',
                      'Feed your dog according to recommended portions based on their size and activity level.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Provide Fresh Water ',
                      'Always keep a bowl of clean, fresh water available for your dog.',
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
