// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, duplicate_import, prefer_const_literals_to_create_immutables, unused_import, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pawprojui/domain.dart';
import 'dart:convert';

import '../email/email.dart';



class EditProfilePage extends StatefulWidget {
  final int userID;

  EditProfilePage({required this.userID});
  @override
  PetUploadState createState() => PetUploadState();
}

class PetUploadState extends State<EditProfilePage> {
  bool isChecked = false;
  int maxLength = 11;
 
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController bio = TextEditingController();
  
  bool isButtonVisiblenext = true;
  bool showPrimaryFields = true;

  void _return_email() {
    Navigator.pop(context);
  }

  Future<void> updateUser(int id, Map<String, dynamic> updateData) async {
  final url = ('http://$domain:8070/api/users/update?id=${widget.userID}'); // Replace with your backend URL
  final headers = <String, String>{
    'Content-Type': 'application/json',
  };

  try {
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(updateData),
    );

    if (response.statusCode == 200) {
      print('User information updated successfully');
    } else {
      print('Failed to update user information: ${response.body}');
    }
  } catch (e) {
    print('Error updating user: $e');
  }
}

void main() {
  final updateUserReq = {
    'id': widget.userID,
    'firstname': fname.text, 
    'lastname':lname.text ,
    'address': address.text,
    'contact_no': contact.text,
    'username': username.text,
    "bio": bio.text
  };

  updateUser(widget.userID, updateUserReq);
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
          color: Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/brown.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: SingleChildScrollView(
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
              ),
              if (isButtonVisiblenext)
                Positioned(
                  top: 50,
                  left: screenWidth * 0.1,
                  child: Container(
                    width: 80, // Adjust the width of the back button container
                    height:
                        40, // Adjust the height of the back button container
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pop(); // Navigate back to the previous screen
                      },
                      borderRadius: BorderRadius.circular(10.0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back, // Use the back arrow icon
                          size: 24, // Set the size of the icon
                          color: Colors.black, // Set the color of the icon
                        ),
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
                top: 110,
                child: Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 153, 133, 93),
                    fontWeight: FontWeight.bold, // Font Weight
                    fontFamily: 'Roboto-Black', // System font
                  ),
                ),
              ),
              Positioned(
                top: 110,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: fname,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                                 

                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color:
                                           Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderPI =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: lname,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                                
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderPI =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Address',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: address,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                                   // Add hint text here
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 156, 153,
                                        147), // Specify the color here
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color:  Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderPI =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact No.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: contact,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                                 
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderC =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Username',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: username,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color:  Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderPI =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Visibility(
                        visible: showPrimaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Bio',
                              style: TextStyle(
                                color: Color.fromARGB(255, 156, 153, 147),
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: bio,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147),
                                  ),
                               
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 224, 224, 224),
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 230, 230, 230),
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  suffixIcon: Icon(
                                    // Add the icon here
                                    Icons.edit, // Change the icon as needed
                                    color: Colors
                                        .grey, // Adjust the icon color as needed
                                  ),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onTap: () {
                                  // setState(() {
                                  //   showTextFieldBorderPI =
                                  //       false; // Update the border color state
                                  // });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              if (isButtonVisiblenext)
                Positioned(
                  bottom: 60,
                  height: 60,
                  width: screenWidth * 0.7,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment
                            .center, // Center the button within the Stack
                        child: Padding(
                          padding: const EdgeInsets.all(
                              3.0), // Add padding to the button
                          child: ElevatedButton(
                            onPressed: () {
                              main();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 110, 77,
                                    34), // Set the button's background color
                              ),
                              elevation: MaterialStateProperty.all<double>(
                                  0), // Remove button elevation
                            ),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Submit',
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
          
            ],
          ),
        ),
      ),
    );
  }
}
