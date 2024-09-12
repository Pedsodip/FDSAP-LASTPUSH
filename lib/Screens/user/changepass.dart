import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../domain.dart';
import '../email/email_CP.dart';
import '../login/login.dart';

class Changepass extends StatefulWidget {
  final String emailAddress;

  const Changepass({required this.emailAddress});
  @override
  ChangepassState createState() => ChangepassState();
}

class ChangepassState extends State<Changepass> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  String message = "";
  bool passinput = false;
  bool passinput2 = false;
  bool showWidget = false;
  bool enablepassword = true;
  bool enablepassword2 = true;

  void _updateUser() async {
    String pass = password.text;
    String confirmpass = confirmpassword.text;
    String email = widget.emailAddress;

    // Validate name input
    if (pass.isEmpty) {
      setState(() {
        message = 'Please enter a new password';
        showWidget = true;
        passinput = true;
        passinput2 = false;
      });
      return;
    }
    if (confirmpass.isEmpty) {
      setState(() {
        message = 'Please confirm your password';
        showWidget = true;
        passinput2 = true;
        passinput = false;
      });
      return;
    }
    if (pass != confirmpass) {
      setState(() {
        message = 'Password does not match';
        showWidget = true;
        passinput = true;
        passinput2 = true;
      });
      return;
    }

    // Make PUT request to API
    var url = Uri.parse('http://$domain/user/reset/password');
    var response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        "Access-Control-Allow-Origin":
            "*", // Ensure this matches CORS settings on server
      },
      body: jsonEncode({"email": email, "password": confirmpass}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        message = jsonResponse['message'];
        showWidget = false;
        passinput = false;
        passinput2 = false;
        password.clear();
        confirmpassword.clear();
        MessageBox.show(
            context, "Congatulations", "Password Changed Successful!");
      });
    } else {
      setState(() {
        message = 'Error changing user pass';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 207, 184, 153),
        ),
        body: Container(
          color: const Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/design/brown.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: Container(
                  width: screenWidth * 0.87,
                  height: screenHeight * 0.86,
                  padding: EdgeInsets.all(20),
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
                top: 50,
                left: screenWidth * 0.1,
                child: Container(
                  width: 25,
                  height: 25,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Email_CP()),
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
                  'Change Password',
                  style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 98, 74, 26),
                    fontWeight: FontWeight.w900, // Font Weight
                    fontFamily: 'Roboto-Black', // System font
                  ),
                ),
              ),
              Positioned(
                top: 180,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'New Password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Container(
                        width: screenWidth * 0.7,
                        height: 50,
                        child: TextField(
                          controller: password,
                          obscureText: enablepassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 240, 240, 240),
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
                                color: passinput
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: Color.fromARGB(255, 169, 169, 169),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            suffixIcon: IconButton(
                              icon: Icon(
                                enablepassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromARGB(255, 169, 169, 169),
                              ),
                              onPressed: () {
                                setState(() {
                                  enablepassword = !enablepassword;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 156, 153, 147),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 270,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Confirm Password',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 3),
                      Container(
                        width: screenWidth * 0.7,
                        height: 50,
                        child: TextField(
                          controller: confirmpassword,
                          obscureText: enablepassword2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(255, 240, 240, 240),
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
                                color: passinput2
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 20,
                              color: Color.fromARGB(255, 169, 169, 169),
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            suffixIcon: IconButton(
                              icon: Icon(
                                enablepassword2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: const Color.fromARGB(255, 169, 169, 169),
                              ),
                              onPressed: () {
                                setState(() {
                                  enablepassword2 = !enablepassword2;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 156, 153, 147),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 560,
                          width: 305,
                          child: Visibility(
                            visible: showWidget,
                            child: Text(
                              message,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 255, 84, 84),
                                fontWeight: FontWeight.bold, // Font Weight
                                fontFamily: 'Roboto-Black', // System font
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 415,
                width: screenWidth * 0.7,
                child: Padding(
                  padding:
                      EdgeInsets.all(3.0), // Add padding to the left and right
                  child: ElevatedButton(
                    onPressed: () {
                      _updateUser();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 123, 97,
                            63), // Set the button's background color
                      ),
                      elevation: MaterialStateProperty.all<double>(
                          0), // Remove button elevation
                    ),
                    child: const SizedBox(
                      width:
                          double.infinity, // Set width to fill available space
                      height: 50,
                      child: Center(
                        child: Text(
                          'Change Password',
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
                    'assets/design/paw_result.png',
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: const Text(
                  'Back to Log in',
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
