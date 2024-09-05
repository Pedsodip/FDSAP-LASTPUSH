// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//import 'package:pawprojui/Screens/petscreens/petaccessories.dart';


class accUploadPage extends StatefulWidget {
  final int userID;

  accUploadPage(this.userID);

  @override
  State<accUploadPage> createState() => _accUploadPageState();
}

class _accUploadPageState extends State<accUploadPage> {
  Map<String, List<String>> feedType = {
      'Cat': [
      'Kitten',
      'Adult',
    ],
      'Dog': [
      'Puppy',
      'Adult',
    ],
  };

  bool showTextFieldBorderPI = false;
  bool showTextFieldBorderN = false;
  bool showTextFieldBorderB = false;
  bool showTextFieldBorderDOB = false;
  bool showTextFieldBorderW = false;
  bool showTextFieldBorderP = false;
  bool showTextFieldBorderT = false;

  String message = "";
  bool showWidget = false;

  bool showPrimaryFields = true;
  bool showSecondaryFields = false;

  bool isButtonVisiblenext = true;
  bool isButtonVisiblesignup = false;
  bool enablepassword = true;
  bool enablepassword2 = true;

  String selectedtype = 'Cat';
  String selectedbreed = 'Persian';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var feedID;
    var feedName;
    var amountAv;
    var feedDesc;

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
                'assets/design1/brown.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                child: SingleChildScrollView(
                  child: Container(
                    width: screenWidth * 0.87,
                    height: screenHeight * 0.90,
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
              // if (isButtonVisiblenext)
              Positioned(
                top: 50,
                left: screenWidth * 0.1,
                child: Container(
                  width: 25,
                  height: 25,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      ;
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
                top: 110,
                child: Text(
                  'Tailored Accessories for Your Furry Friends!',
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
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: showPrimaryFields,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Text(
                              //   'Name',
                              //   style: TextStyle(
                              //     color: Color.fromARGB(255, 156, 153, 147),
                              //     fontSize: 16,
                              //   ),
                              // ),
                              // SizedBox(height: 3,),
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: TextFormField(
                                  controller: feedID,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 240, 240, 240),
                                    labelText: 'Name',
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 156, 153, 147),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 198, 198, 198),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: showTextFieldBorderPI
                                            ? Color.fromARGB(255, 255, 132, 132)
                                            : Color.fromARGB(
                                                255, 240, 240, 240),
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 135, 132, 127),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      showTextFieldBorderPI =
                                          false; // Update the border color state
                                    });
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
                                // const Text(
                                //   'Type',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 156, 153, 147),
                                //     fontSize: 16,
                                //   ),
                                // ),
                                // SizedBox(height: 3),
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextFormField(
                                    controller: feedName,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 240, 240, 240),
                                      labelText: 'Type',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderN
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 198, 198, 198),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderN
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Color.fromARGB(
                                                  255, 240, 240, 240),
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 135, 132, 127),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showTextFieldBorderN =
                                            false; // Update the border color state
                                      });
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          visible: showPrimaryFields,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Text(
                                //   'Description',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 156, 153, 147),
                                //     fontSize: 16,
                                //   ),
                                // ),
                                // SizedBox(height: 3),
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextFormField(
                                    controller: feedName,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(255, 240, 240, 240),
                                      labelText: 'Description',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderN
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Colors.transparent,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 198, 198, 198),
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderN
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Color.fromARGB(
                                                  255, 240, 240, 240),
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                    ),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 135, 132, 127),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showTextFieldBorderN =
                                            false; // Update the border color state
                                      });
                                    },
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          visible: showPrimaryFields,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: showPrimaryFields,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Text(
                              //   'Size',
                              //   style: TextStyle(
                              //     color: Color.fromARGB(255, 156, 153, 147),
                              //     fontSize: 16,
                              //   ),
                              // ),
                              // SizedBox(height: 3),
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: TextFormField(
                                  controller: amountAv,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                                    labelText: 'Size',
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 156, 153, 147),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 156, 153, 147),
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 198, 198, 198),
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: showTextFieldBorderW
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Color.fromARGB(
                                                  255, 240, 240, 240),
                                          width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 135, 132, 127),
                                  ),
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
                              // const Text(
                              //   'Quantity',
                              //   style: TextStyle(
                              //     color: Color.fromARGB(255, 156, 153, 147),
                              //     fontSize: 16,
                              //   ),
                              // ),
                              // SizedBox(height: 3),
                              Container(
                                width: screenWidth * 0.7,
                                height: 100,
                                child: TextFormField(
                                  controller: feedDesc,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(255, 240, 240, 240),
                                    labelText: 'Quantity',
                                    labelStyle: const TextStyle(
                                      color: Color.fromARGB(255, 156, 153, 147),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 156, 153, 147),
                                          width: 2.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 198, 198, 198),
                                          width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                          color: showTextFieldBorderP
                                              ? Color.fromARGB(
                                                  255, 255, 132, 132)
                                              : Color.fromARGB(
                                                  255, 240, 240, 240),
                                          width: 2.0),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 135, 132, 127),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isButtonVisiblenext)
                          Positioned(
                            bottom: 60,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0), // Add horizontal padding
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.7, // Use MediaQuery to get screen width
                                child: ElevatedButton(
                                  onPressed: () {
                                     // _checkinput();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 110, 77, 34),
                                    ),
                                    elevation:
                                        MaterialStateProperty.all<double>(20),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Next',
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
                        Positioned(
                            bottom: 300,
                            left: 70,
                            child: Visibility(
                              visible: showWidget,
                              child: Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 255, 51, 51),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Roboto-Black',
                                ),
                              ),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
