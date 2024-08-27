import 'package:flutter/material.dart';

void main() {
  runApp(DogTrainingPage());
}

class DogTrainingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text(
              'Training and Socialization',
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
                        'assets/design1/dogtrain.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Basic Obedience Training ',
                      'Teach essential commands like sit, stay, come, and leash manners using positive reinforcement techniques.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Behavioral Training ',
                      'Address any behavioral issues (e.g., excessive barking, chewing) through consistent training and positive reinforcement.',
                    ),
                    SizedBox(height: 20.0),
                    _buildRichTextSection(
                      'Socialization ',
                      'Expose your dog to various environments, people, and other dogs from a young age to promote good social behavior.',
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
