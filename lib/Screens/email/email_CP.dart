import 'dart:convert';
import 'package:flutter/material.dart';
import '../../domain.dart';
import '../login/login.dart';
import 'email_confirmCP.dart';
import 'package:http/http.dart' as http;



class Email_CP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _EmailCP(),
    );
  }
}

class _EmailCP extends StatefulWidget {
  @override
  EmailStateCP createState() => EmailStateCP();
}

class EmailStateCP extends State<_EmailCP> {
  bool emailInput = false;
  bool showWidget = false;
  TextEditingController emailAddress = TextEditingController();
  String message = "";

  void _sendOtp() async {
    String apiUrl = 'http://$domain/api/send/otp';

    String recipientEmail = emailAddress.text;

    // Check if email is empty
    if (recipientEmail.isEmpty) {
      setState(() {
        emailInput = true;
        message = "Email field cannot be empty.";
        showWidget = true;
      });
      return;
    }

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': recipientEmail,
        }),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String otp = data['otp'];
        debugPrint(
            'OTP generated and sent successfully to $recipientEmail. OTP: $otp');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EmailConfirmCP(text: otp, emailAddress: recipientEmail)),
        );
        emailInput = false;
        showWidget = false;
      } else if (response.statusCode == 400) {
        setState(() {
          emailInput = true;
          message = "Email Address Does not Exist";
          showWidget = true;
        });
      } else {
        debugPrint(
            'Failed to generate OTP. Status code: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
        // ),
        body: Container(
          color: Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 1,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/design1/pinkbg.png',
                  width: screenWidth * 0.9, // Set width to screen width
                  height:
                  screenHeight * 1, // Set height to 30% of screen height
                  fit: BoxFit.fill, // Adjust the fit as needed
                ),
              ),
              // Positioned(
              //   child: Container(
              //     width: screenWidth * 1,
              //     height: screenHeight * 1,
              //     padding: EdgeInsets.all(20),
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              Positioned(
                  bottom: 595,
                  left: 70,
                  child: Visibility(
                    visible: showWidget,
                    child: Text(
                      message,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 255, 51, 51),
                        fontWeight: FontWeight.bold, // Font Weight
                        fontFamily: 'Roboto-Black', // System font
                      ),
                    ),
                  )),
              Positioned(
                top: 100,
                left: 25,
                child: Container(
                  width: 25,
                  height: 25,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/design1/arrow_button.png', // Replace this with your image path
                      width: 10, // Adjust image width
                      height: 10, // Adjust image height
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                child: Image.asset(
                  'assets/design1/logo.png',
                  // width: screenWidth * 0.,
                  height: 200
                ),
              ),
              const Positioned(
                top: 200,
                child: Text(
                  'Enter Your Email Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 98, 74, 26),
                    fontWeight: FontWeight.bold, // Font Weight
                    fontFamily: 'Roboto-Black', // System font
                  ),
                ),
              ),
              const Positioned(
                top: 225,
                child: Text.rich(
                  TextSpan(
                    text: 'We will send you a ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Black',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'One Time Passcode ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 153, 133, 93),
                        ),
                      ),
                      TextSpan(
                        text: ' via this email.',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 250,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Email Address',
                      //   style: TextStyle(
                      //     color: Color.fromARGB(255, 156, 153, 147),
                      //     fontSize: 16,
                      //   ),
                      // ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: screenWidth * 0.7,
                        height: 100,
                        child: TextField(
                          controller: emailAddress,
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: Color.fromARGB(255, 240, 240, 240),
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: Colors.black38,
                              // color: Color.fromARGB(255, 156, 153, 147),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 156, 153, 147),
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.black38,
                                // color: Color.fromARGB(255, 198, 198, 198), // Set the focused border color
                                width: 2.0,
                              ),
                            ),
                            // enabledBorder: OutlineInputBorder(
                            //   borderRadius: BorderRadius.circular(10.0),
                            //   borderSide: BorderSide(
                            //     color: emailInput
                            //         ? Color.fromARGB(255, 255, 132, 132)
                            //         : Color.fromARGB(255, 240, 240, 240),
                            //     width: 2.0,
                            //   ),
                            // ),
                            prefixIcon: Icon(
                              Icons.email,
                              size: 20,
                              color: Color.fromARGB(255, 169, 169, 169),
                            ),
                            // contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 145, 136, 121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 400,
                width: screenWidth * 0.7, // Set width to screen width
                child: Stack(
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _sendOtp();
                        },
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 123, 97, 63), // Set the button's background color
                          ),
                          elevation: MaterialStateProperty.all<double>(10), // Remove button elevation
                        ),
                        child: const SizedBox(
                          height: 40,
                          width: 90,
                          child: Center(
                            child: Text(
                              'Send OTP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
      ),
    );
  }
}
