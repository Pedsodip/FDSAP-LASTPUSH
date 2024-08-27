import 'package:flutter/material.dart';

void main() {
  runApp(CatGroomingPage());
}

class CatGroomingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Text(
              'Grooming',
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
                        'assets/design1/catgroom.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Brushing ',
                      'Depending on your cat\'s coat type, brush them regularly to prevent matting and reduce shedding.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Nail Trimming ',
                      'Trim your cat\'s nails every 1-2 weeks to prevent overgrowth and minimize scratching damage.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Ear Cleaning ',
                      'Check and clean your cat\'s ears as needed to remove dirt and prevent ear infections.',
                    ),
                    const SizedBox(height: 20),
                    _buildRichTextSection(
                      'Dental Care ',
                      'Brush your cat\'s teeth regularly using a cat-specific toothbrush and toothpaste to prevent dental issues.',
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
