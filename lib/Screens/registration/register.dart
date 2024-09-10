// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, duplicate_import
import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../../domain.dart';
import '../login/login.dart';
import 'terms_condition.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../email/email.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<RegisterPage> {
  bool isChecked = false;
  int maxLength = 11;
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController addresss = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool showTextFieldBorderFN = false;
  bool showTextFieldBorderLN = false;
  bool showTextFieldBorderADD = false;
  bool showTextFieldBorderDOB = false;
  bool showTextFieldBorderCN = false;
  bool showTextFieldBorderG = false;
  bool showTextFieldBorderMAIL = false;
  bool showTextFieldBorderUN = false;
  bool showTextFieldBorderPASS = false;
  bool showTextFieldBorderCPASS = false;
  bool enablepassword = true;
  // bool showTextFieldBorderPASS = false;
  String? passwordError;

  String message = "";
  bool showWidget = false;

  bool showPrimaryFields = true;
  bool showSecondaryFields = false;

  bool isButtonVisiblesignup = false;
  bool isButtonVisiblenext = true;
  // bool enablepassword = true;
  bool enablepassword2 = true;

  get gender => null;
  String selectedgender = '';
  String enteredOtp = '';

  void _sendOtp(BuildContext context) async {
    String apiUrl = 'http://$domain/api/send/otp';
    String recipientEmail = email.text;

    if (recipientEmail.isEmpty) {
      return
        // _showOtpDialog(context, recipientEmail);
        MessageBox.show(context, "Email Not Found!");
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

        // Show OTP dialog
        _showOtpDialog(context, recipientEmail);
      } else if (response.statusCode == 400) {
        var errorMessage = jsonDecode(response.body)['error'];
        debugPrint('Error Message: $errorMessage');
        // Optionally show error message dialog
      } else {
        debugPrint(
            'Failed to generate OTP. Status code: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
        // Use `showDialog` or another method to display error
        MessageBox.show(context, "Email Invalid");
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

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

  void _checkinput() {
    setState(() {
      bool anyEmpty = false;

      if (firstname.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderFN = true;
      } else {
        showTextFieldBorderFN = false;
      }

      if (lastname.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderLN = true;
      } else {
        showTextFieldBorderLN = false;
      }

      if (addresss.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderADD = true;
      } else {
        showTextFieldBorderADD = false;
      }

      if (contact.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderCN = true;
      } else {
        showTextFieldBorderCN = false;
      }

      if (anyEmpty) {
        message = 'Please fill out all empty fields.';
        showWidget = true;
        return;
      }
      if (contact.text.length != 11) {
        showTextFieldBorderCN = true;
        message = 'Invalid Contact Number.';
        showWidget = true;
        return;
      }

      showWidget = false;
      showSecondaryFields = true;
      showPrimaryFields = false;
      isButtonVisiblenext = false;
      isButtonVisiblesignup = true;
    });
  }

  Future<void> _adduser() async {

      String fname = firstname.text;
      String lname = lastname.text;
      String add = addresss.text;
      String dOB = dateofbirth.text;
      String cont = contact.text;
      String sex = selectedgender;
      String mail = email.text;
      String uname = username.text;
      String pass = password.text;

    var url = Uri.parse('http://$domain/api/Register');

    var request = http.MultipartRequest('POST', url);

    // Add the form fields
    request.fields['Firstname'] = fname;
    request.fields['Lastname'] = lname;
    request.fields['Address'] = add;
    request.fields['DateOfBirth'] = dOB;
    request.fields['Contact'] = cont;
    request.fields['Gender'] = sex;
    request.fields['Email'] = mail;
    request.fields['Username'] = uname;
    request.fields['Password'] = pass;
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
      print('User added successfully: $jsonResponse');
      // Show "Congratulations!" message
      successAdded(context, "Congratulations!");

    } else {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      var errorMessage = jsonDecode(jsonResponse.body)['Message'];
      MessageBox.show(context, errorMessage);
      print('Failed to add pet: $jsonResponse');
    }
  }

  void _showOtpDialog(BuildContext context, String email) {
    TextEditingController otpController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: Center(child: const Text('Enter Your OTP')),
          content: TextField(
            maxLength: 6,
            textAlign: TextAlign.center,
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(counterText: ''),
          ),
          actions: <Widget>[
            Center(
              child:
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // Text (foreground) color
                  backgroundColor: Color.fromARGB(255, 110, 77, 34),
                  side: BorderSide(
                      color: const Color.fromARGB(255, 90, 90, 90),
                      width: 1), // Border color and width
                ),
                onPressed: () {
                  _validateOtp(context, email, otpController.text);
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text("Submit",style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _validateOtp(BuildContext context, String email, String otp) async {
    String apiUrl =
        'http://$domain/api/validate/otp'; // Update with your actual API

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'otp': otp,
        }),
      );
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body)['Message'];
        debugPrint('OTP validation successful: $message');
        // MessageBox.show(context, message);
        // _showSuccessDialog(context);
        await _adduser();

      } else {
        debugPrint('Failed to validate OTP: ${response.statusCode}');
        var errorMessage = jsonDecode(response.body)['Message'];

        MessageBox.show(context, errorMessage);
        // Pass the actual context instead of BuildContext type
        // _showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  bool validatePassword(String password) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }


  // void _return() {
  //   setState(() {
  //     showSecondaryFields = false;
  //     showPrimaryFields = true;
  //     isButtonVisiblenext = true;
  //     isButtonVisiblesignup = false;
  //   });
  // }

  // void _return_email() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => Email()),
  //   );
  // }

  // void _insertUser() async {
  //   // String email = widget.email;
  //   String fname = firstname.text;
  //   String lname = lastname.text;
  //   String add = addresss.text;
  //   String cont = contact.text;
  //   String sex = selectedgender;
  //   String date = dateofbirth.text;
  //   // String emailadd = email;
  //   String uname = username.text;
  //   String pass = password.text;
  //   String cpass = confirmpassword.text;
  //   String profile =
  //       'https://th.bing.com/th/id/OIP.eCrcK2BiqwBGE1naWwK3UwHaHa?rs=1&pid=ImgDetMain';
  //   String bio = "Hi I'am $uname ";
  //   bool anyEmpty = false;
  //
  //   if (username.text.isEmpty) {
  //     anyEmpty = true;
  //     showTextFieldBorderUN = true;
  //   } else {
  //     showTextFieldBorderUN = false;
  //   }
  //
  //   if (password.text.isEmpty) {
  //     anyEmpty = true;
  //     showTextFieldBorderPASS = true;
  //   } else {
  //     showTextFieldBorderPASS = false;
  //   }
  //
  //   if (confirmpassword.text.isEmpty) {
  //     anyEmpty = true;
  //     showTextFieldBorderCPASS = true;
  //   } else {
  //     showTextFieldBorderCPASS = false;
  //   }
  //
  //   if (anyEmpty) {
  //     setState(() {
  //       message = 'Please fill out all empty fields.';
  //       showWidget = true;
  //     });
  //
  //     return;
  //   }
  //
  //   if (pass != cpass) {
  //     setState(() {
  //       message = 'Password Do not Match';
  //       showTextFieldBorderPASS = true;
  //       showTextFieldBorderCPASS = true;
  //       showWidget = true;
  //     });
  //     return;
  //   }
  //   if (sex == '') {
  //     sex = 'N/A';
  //   }
  //
  //   if (dateofbirth.text.isEmpty) {
  //     date = 'N/A';
  //   }
  //
  //   var url = Uri.parse('http://$domain:8070/api/users');
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //     },
  //     body: jsonEncode(<String, String>{
  //       "firstname": fname,
  //       "lastname": lname,
  //       "address": add,
  //       "dateofbirth": date,
  //       "contact_no": cont,
  //       "gender": sex,
  //       // "email": emailadd,
  //       "username": uname,
  //       "password": pass,
  //       "profile_picture": profile,
  //       "bio": bio
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     setState(() {
  //       message = jsonResponse['message'];
  //       MessageBox.show(context, "Congratulations!",
  //           "You're officially part of our furry family!");
  //     });
  //   } else if (response.statusCode == 409) {
  //     // Email or username already exists
  //     setState(() {
  //       message = 'Email already exists or in use';
  //       showWidget = true;
  //       showTextFieldBorderMAIL = true;
  //     });
  //   } else {
  //     setState(() {
  //       debugPrint("ERROR");
  //       debugPrint(selectedgender);
  //       debugPrint(response.body);
  //       debugPrint(response.statusCode.toString());
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // email.text = widget.email;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 207, 184, 153),
        // ),
        body: Container(
          color: Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/design1/brownbg.png',
                width: screenWidth * 1,
                height: screenHeight * 1,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 90,
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
              if (isButtonVisiblenext)
                // back icon
                Positioned(
                  top: 110,
                  left: screenWidth * 0.1,
                  child: Container(
                    width: 25,
                    height: 25,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                            // MaterialPageRoute(builder: (context) => Email()),
                          );
                        });
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
                top: 90,
                child: Image.asset(
                  'assets/design1/banner.png',
                  width: 100,
                  height: 100,
                ),
              ),
              // create account text
              const Positioned(
                top: 190,
                child: Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 153, 133, 93),
                    fontWeight: FontWeight.bold, // Font Weight
                    fontFamily: 'Roboto-Black', // System font
                  ),
                ),
              ),
              // TextFields
              Positioned(
                top: 200,
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
                                // const Text(
                                //   'First Name',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 156, 153, 147),
                                //     fontSize: 16,
                                //   ),
                                // ),
                                SizedBox(height: 3),
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextField(
                                    controller: firstname,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Color.fromARGB(255, 240, 240, 240),
                                      labelText: 'First Name',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 156, 153, 147),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 198, 198,
                                              198), // Set the focused border color
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderFN
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
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 135, 132, 127),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showTextFieldBorderFN =
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
                                //   'Last Name',
                                //   style: TextStyle(
                                //     color: Color.fromARGB(255, 156, 153, 147),
                                //     fontSize: 16,
                                //   ),
                                // ),
                                SizedBox(height: 3),
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextField(
                                    controller: lastname,
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Color.fromARGB(255, 240, 240, 240),
                                      labelText: 'Last Name',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderLN
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
                                          color: Color.fromARGB(255, 198, 198,
                                              198), // Set the focused border color
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderLN
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
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 135, 132, 127),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showTextFieldBorderLN =
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
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextField(
                                    controller: addresss,
                                    decoration: InputDecoration(
                                      labelText: 'Address',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 156, 153, 147),
                                            width: 2.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 198, 198, 198),
                                            width: 2.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                            color: showTextFieldBorderADD
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
                              ]),
                        ),
                        SizedBox(height: 15),
                        Visibility(
                          visible: showPrimaryFields,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 3),
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    value: gender,
                                    decoration: InputDecoration(
                                      labelText: 'Gender',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 169, 169, 169),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 156, 153, 147),
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
                                          color: showTextFieldBorderG
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
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedgender = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Male',
                                      'Female',
                                      'Others',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
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
                                Container(
                                  width: screenWidth * 0.7,
                                  height: 50,
                                  child: TextField(
                                    controller: contact,
                                    decoration: InputDecoration(
                                      labelText: 'Contact Number',
                                      labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 156, 153, 147),
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Color.fromARGB(255, 198, 198,
                                              198), // Set the focused border color same as enabled border
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: showTextFieldBorderCN
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
                                    keyboardType: TextInputType
                                        .number, // Set the keyboard type to only allow numbers
                                    inputFormatters: <TextInputFormatter>[
                                      LengthLimitingTextInputFormatter(
                                          11), // Restrict the input length to 11 characters
                                      FilteringTextInputFormatter
                                          .digitsOnly // Restrict input to only digits
                                    ],
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
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        readOnly: true,
                                        controller: dateofbirth,
                                        decoration: InputDecoration(
                                          labelText: 'Date of Birth',
                                          labelStyle: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 156, 153, 147),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 198, 198, 198),
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
                                              color: showTextFieldBorderDOB
                                                  ? Color.fromARGB(
                                                      255, 255, 132, 132)
                                                  : Color.fromARGB(
                                                      255, 240, 240, 240),
                                              width: 2.0,
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal:
                                                  20), // Padding between text field and icon
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              ///
                                              showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1950),
                                                lastDate: DateTime.now(),
                                              ).then((selectedDate) {
                                                if (selectedDate != null) {
                                                  //handler
                                                  dateofbirth.text =
                                                      DateFormat('yyyy/MM/dd')
                                                          .format(selectedDate);
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.calendar_today,
                                              color: const Color.fromARGB(
                                                  255, 169, 169, 169),
                                            ),
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 135, 132, 127),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
              if (isButtonVisiblesignup)
                Positioned(
                  top: 110,
                  left: screenWidth * 0.1,
                  child: Container(
                    width: 25,
                    height: 25,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
                            // MaterialPageRoute(builder: (context) => Email()),
                          );
                        });
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
                top: 200,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Visibility(
                        visible: showSecondaryFields,
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
                              SizedBox(height: 3),
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: TextField(
                                  controller: email,
                                  enabled: true,
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
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: showTextFieldBorderMAIL
                                            ? Color.fromARGB(255, 255, 132, 132)
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
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: showSecondaryFields,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const Text(
                              //   'Username',
                              //   style: TextStyle(
                              //     color: Color.fromARGB(255, 156, 153, 147),
                              //     fontSize: 16,
                              //   ),
                              // ),
                              SizedBox(height: 3),
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: TextField(
                                  controller: username,
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Color.fromARGB(255, 240, 240, 240),
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
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
                                        color: Colors.black38,
                                        // color: Color.fromARGB(255, 198, 198, 198), // Set the focused border color
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: showTextFieldBorderUN
                                            ? Color.fromARGB(255, 255, 132, 132)
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
                                ),
                              ),
                            ]),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: showSecondaryFields,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 3),
                            Container(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: password,
                                obscureText: enablepassword,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
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
                                      color: Colors.black38,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: showTextFieldBorderPASS
                                          ? Color.fromARGB(255, 255, 132, 132)
                                          : Color.fromARGB(255, 240, 240, 240),
                                      width: 2.0,
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      enablepassword ? Icons.visibility : Icons.visibility_off,
                                      color: Color.fromARGB(255, 156, 153, 147),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        enablepassword = !enablepassword;
                                      });
                                    },
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  errorText: passwordError, // Display error text if validation fails
                                ),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    // Validate password on input change
                                    if (validatePassword(value)) {
                                      passwordError = null; // No error if valid
                                      showTextFieldBorderPASS = false;
                                    } else {
                                      passwordError =
                                      'Password must contain number, special character, and be alphanumeric.';
                                      showTextFieldBorderPASS = true;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Visibility(
                        visible: showSecondaryFields,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 3),
                              Container(
                                width: screenWidth * 0.7,
                                height: 50,
                                child: TextField(
                                  controller: confirmpassword,
                                  obscureText: enablepassword2,
                                  decoration: InputDecoration(
                                    // filled: true,
                                    // fillColor: Color.fromARGB(255, 240, 240, 240),
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(
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
                                        color: Colors.black38,
                                        // color: Color.fromARGB(255, 198, 198, 198), // Set the focused border color
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: showTextFieldBorderCPASS
                                            ? Color.fromARGB(255, 255, 132, 132)
                                            : Color.fromARGB(
                                                255, 240, 240, 240),
                                        width: 2.0,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        enablepassword2
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Color.fromARGB(255, 156, 153, 147),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          enablepassword2 = !enablepassword2;
                                        });
                                      },
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
                            ]),
                      ),
                      SizedBox(height: 20),
                      Visibility(
                        visible: showSecondaryFields,
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
              ),
              // policy checkbox
              if (isButtonVisiblesignup)
                Positioned(
                  bottom: 120,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        onChanged: (bool? value) {
                          // Handle checkbox state changes
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        activeColor: Color.fromARGB(255, 153, 133, 93),
                      ),
                      const Text(
                        'I accept ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 153, 133, 93),
                            fontWeight: FontWeight.w700),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PolicyScreen()),
                          );
                        },
                        child: Text(
                          'Privacy Policy & Terms of Us',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.blue,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ),
              // Next Button
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
                              _checkinput();
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
                              width: screenWidth * .7,
                              height: 40,
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
                    ],
                  ),
                ),
              if (isButtonVisiblesignup)
                // sendOTP button
                Positioned(
                  bottom: 70,
                  child: Stack(
                    children: [
                      ElevatedButton(
                        onPressed: isChecked
                            ? () =>
                                _sendOtp(context) // Wrap _sendOtp in a closure
                            : null,
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Color.fromARGB(
                                    255, 200, 200, 200); // Disabled color
                              }
                              return Color.fromARGB(
                                  255, 110, 77, 34); // Enabled color
                            },
                          ),
                          elevation: MaterialStateProperty.all<double>(
                              0), // Remove button elevation
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.5, // Set width to screen width
                          height: 30,
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
                      )
                    ],
                  ),
                ),
              Positioned(
                  bottom: 190,
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
        ),
      ),
    );
  }
}

class MessageBox {
  static void show(BuildContext context, String title) {
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
                  // SizedBox(width: 30),
                  // Text(
                  //   message,
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //     color: const Color.fromARGB(
                  //         255, 0, 0, 0), // Change text color
                  //   ),
                  // ),
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
}

void successAdded(BuildContext context, String title) {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage(),),
                );
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




