
import 'dart:convert';
import 'dart:io' show File, Platform;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class accUploadPage extends StatefulWidget {
  final int userID;

  accUploadPage(this.userID);

  @override
  State<accUploadPage> createState() => _accUploadPageState();
}

class _accUploadPageState extends State<accUploadPage> {

  TextEditingController name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController size = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController cost = TextEditingController();

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

  File? image;
  final picker = ImagePicker();
  String? _fileName;
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Store the file object
        _fileName = pickedFile.name; // Store the file name
      });
    }
  }

  void clearFields(){
    setState(() {
      name.clear();
      type.clear();
      desc.clear();
      size.clear();
      quantity.clear();
      cost.clear();
    });
  }

  Future<void> _uploadAcc() async {
    int idOfUser = widget.userID;
    String _name = name.text;
    String _type = type.text;
    String description = desc.text;
    String _size = size.text;
    int quan = int.parse(quantity.text);
    int price = int.parse(cost.text);
    var url = Uri.parse('http://10.0.2.2:8080/api/add/accessory');

    var request = http.MultipartRequest('POST', url);

    // Add the form fields
    request.fields['UserID'] = idOfUser.toString();
    request.fields['Name'] = _name;
    request.fields['Description'] = description;
    request.fields['Type'] = _type;
    request.fields['Size'] = _size;
    request.fields['Cost'] = price.toString();
    request.fields['Quantity'] = quan.toString();


    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path,
        filename: _fileName,
      ));
    }
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      clearFields();
      show(context,'Acessory added successfully!');
      print('Acessory added successfully: $jsonResponse');
    } else {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      var errorMessage = jsonDecode(jsonResponse.body)['Message'];
      show(context, errorMessage);
      print('Failed to add Acessory: $jsonResponse');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    height: screenHeight * 0.87,
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

              // TextFields
              Positioned(
                top: 100,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      // name
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: name,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: type,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Type',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: desc,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: size,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Size',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: cost,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: screenWidth * 0.7,
                        height: 40,
                        child: TextField(
                          controller: quantity,
                          cursorHeight: 20,
                          decoration: InputDecoration(
                            labelText: 'Quantity',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                // color: Color.fromARGB(255, 156, 153, 147),
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
                                color: showTextFieldBorderN
                                    ? Color.fromARGB(255, 255, 132, 132)
                                    : Color.fromARGB(255, 240, 240, 240),
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
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:
                            _pickImage, // Call image picker when tapped
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color:
                                const Color.fromARGB(255, 240, 240, 240),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Center the selected image or icon
                                  Center(
                                    child: const Icon(
                                      Icons.camera_alt,
                                      color:
                                      Color.fromARGB(255, 135, 132, 127),
                                      size: 30,
                                    ),
                                  ),

                                  // Position the "Add" icon on the bottom right corner
                                  Positioned(
                                    bottom: 5.0, // Adjust spacing as needed
                                    right: 5.0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2.0),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green,
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 2.0, // Space between icon and filename
                          ),

                          // Display filename to the right of the gesture detector
                          if (_fileName != null)
                            SizedBox(
                              width: 150,
                              child: Text(
                                _fileName!,
                                overflow:
                                TextOverflow.ellipsis, // Prevent overflow
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign
                                    .right, // Align text to the right
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // submit button
              Positioned(
                bottom: 20,
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
                            // _checkinput();
                            _uploadAcc();
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
                            height: 35,
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

void show(BuildContext context, String title) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                SizedBox(height: 20, width: 30),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: const Color.fromARGB(255, 98, 74, 26),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                // Text (foreground) color
                backgroundColor: Color.fromARGB(255, 110, 77, 34),
                side: BorderSide(
                    color: const Color.fromARGB(255, 90, 90, 90),
                    width: 1), // Border color and width
              ),
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      );
    },
  );
}
