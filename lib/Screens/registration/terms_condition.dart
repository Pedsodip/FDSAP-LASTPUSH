import 'package:flutter/material.dart';
import 'privacy_policy.dart';
import 'terms_of_use.dart';

class PolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Positioned(
              top: 40,
              right: screenWidth * 0.02, // Adjust the right position as needed
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Align children to the right
                children: [
                  SizedBox(
                      width: screenWidth *
                          0.33), // Add some space between the images
                  Image.asset(
                    'assets/design1/furpect_paw.png', // Replace with your image path
                    width: screenWidth * 0.25,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Privacy Policy and Terms of Use",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                privacyPolicyText,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                termsOfUseText,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
