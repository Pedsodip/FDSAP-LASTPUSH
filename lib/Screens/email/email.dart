import 'dart:convert';
import 'package:flutter/material.dart';
import '../../domain.dart';
import '../login/login.dart';
import "email_confirm.dart";
import 'package:http/http.dart' as http;

void main() {
  runApp(Email());
}

class Email extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Email(),
    );
  }
}

class _Email extends StatefulWidget {
  @override
  EmailState createState() => EmailState();
}

class EmailState extends State<_Email> {
  bool emailInput = false;
  bool showWidget = false;
  TextEditingController emailAddress = TextEditingController();
  String message = "";

  void _sendOtp() async {
    String apiUrl = 'http://$domain:8070/api/generate-otp';

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
                  EmailConfirm(text: otp, emailAddress: recipientEmail)),
        );
        emailInput = false;
        showWidget = false;
      } else if (response.statusCode == 400) {
        debugPrint('Failed to generate OTP. Email is already taken.');
        var errorMessage = jsonDecode(response.body)['error'];
        debugPrint('Error Message: $errorMessage');
        setState(() {
          emailInput = true;
          message = "Email is Already Taken";
          showWidget = true;
        });
      } else {
        debugPrint(
            'Failed to generate OTP. Status code: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        MessageBox.show(
            context, "Email Invalid", "Try A different Email Address.");
        emailAddress.clear();
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
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 207, 184, 153),
        ),
        body: Container(
          color: const Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/design1/brown.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: Container(
                  width: screenWidth * 0.87,
                  height: screenHeight * 0.86,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),
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
                top: 50,
                left: screenWidth * 0.1,
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
                top: 30,
                child: Image.asset(
                  'assets/design1/furpaw.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const Positioned(
                top: 130,
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
                top: 160,
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
                        text: 'One Time Passcode',
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
                top: 190,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Address',
                        style: TextStyle(
                          color: Color.fromARGB(255, 156, 153, 147),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        width: screenWidth * 0.7,
                        height: 100,
                        child: TextField(
                          controller: emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 235, 235, 235),
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 156, 153, 147),
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
                                color: Color.fromARGB(255, 198, 198,
                                    198), // Set the focused border color
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: emailInput
                                    ? const Color.fromARGB(255, 255, 132, 132)
                                    : const Color.fromARGB(255, 235, 235, 235),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.email,
                                size: 20,
                                color: Color.fromARGB(255, 156, 153, 147)),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 145, 136, 121),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 320,
                width: screenWidth * 0.7, // Set width to screen width
                child: Stack(
                  children: [
                    ElevatedButton(
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
                          const Color.fromARGB(255, 110, 77,
                              34), // Set the button's background color
                        ),
                        elevation: MaterialStateProperty.all<double>(
                            0), // Remove button elevation
                      ),
                      child: const SizedBox(
                        height: 50,
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

class MessageBox {
  static void show(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: null,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/design1/paw_result.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 98, 74, 26),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 0, 0), // Change text color
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: Color.fromARGB(255, 90, 90, 90),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
