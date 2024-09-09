// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'login.dart'; // Import the SecondPage.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(), // Set MyHomePage as the initial route
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define button background image height
    double buttonHeight = screenHeight * 0.2;

    // Calculate font size based on screen width

    // Define padding
    EdgeInsets buttonPadding = EdgeInsets.symmetric(
      vertical: screenHeight * 0.015,
      horizontal: screenWidth * 0.025,
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/design1/pinkbg.png'),
            fit: BoxFit.cover
          )
        ),
        // color: Colors.white,
        // color: const Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Make children stretch horizontally
              children: [
                Container(
                  width: screenWidth, // Match the screen width
                  height: screenHeight, // Match the screen height
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Positioned(
                      //   top: screenHeight * 0.08,
                      //   child: Image.asset(
                      //     'assets/design1/paw.png',
                      //     width: screenWidth * 0.2,
                      //     height: screenHeight * 0.11,
                      //   ),
                      // ),
                      Positioned(
                        top: 1,
                        child: Image.asset(
                          'assets/design1/introdog.png',
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.9,
                        ),
                      ),
                    ],
                  ),
                ),
                // Add more children to the Column if needed
              ],
            ),
            // Positioned(
            //   top: screenHeight *
            //       0.30, // Adjusted top position to move the widget downward
            //   child: Image.asset(
            //     'assets/design1/dog_start.png',
            //     width: screenWidth * 0.5,
            //     height: screenHeight * 0.35,
            //   ),
            // ),
            // Positioned(
            //   bottom: screenHeight * 0.4,
            //   right: screenWidth * 0.05,
            //   child: Image.asset(
            //     'assets/design1/pawprinttwo.png',
            //     width: screenWidth * 0.2,
            //     height: screenHeight * 0.12,
            //   ),
            // ),
            // Positioned(
            //   bottom: screenHeight * 0.35,
            //   left: screenWidth * 0.05,
            //   child: Image.asset(
            //     'assets/design1/pawprintone.png',
            //     width: screenWidth * 0.2,
            //     height: screenHeight * 0.12,
            //   ),
            // ),
            Positioned(
              bottom: screenHeight * 0.25,
              child: const Text(
                "Find Your Furfect Match!",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 84, 71, 33)
                    // Add more styles as needed
                    ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.1,
              child: Stack(
                children: [
                  Container(
                    width: screenWidth * 0.4,
                    height: buttonHeight * 0.3, // Set height here
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/design1/button_bg.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      child: Text(
                        'GET STARTED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenHeight * 0.02,
                          fontWeight: FontWeight.w700, // Fixed font size
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
