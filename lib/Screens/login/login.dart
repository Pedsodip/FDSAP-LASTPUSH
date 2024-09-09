import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawprojui/Screens/dashboard/mydashboard.dart';
import 'package:pawprojui/Screens/registration/register.dart';
import '../../domain.dart';
// import '../email/email.dart';
import '../email/email_CP.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _Login(), // Set MyHomePage as the initial route
    );
  }
}

class _Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<_Login> {
  TextEditingController usernameCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  bool isChecked = false;
  bool showWidget = false;
  bool showTextFieldBorder = false;
  String message = '';
  List<dynamic> dataofuser = [];
  late int userID;

  bool enablepassword = true;

  // Future<void> login(String email, String password) async {
  //   String email = usernameCon.text;
  //   String password = passwordCon.text;
  //
  //   // Validate name and password input
  //   if (email.isEmpty || password.isEmpty) {
  //     setState(() {
  //       showWidget = true;
  //       showTextFieldBorder = true;
  //       message = 'Please enter your username and password.';
  //
  //       Timer(const Duration(seconds: 5), () {
  //         setState(() {
  //           showWidget = false;
  //           showTextFieldBorder = false;
  //         });
  //       });
  //     });
  //     return;
  //   }
  //
  //   void fetchItems() async {
  //     String email = usernameCon.text;
  //     String password = passwordCon.text;
  //     final response = await http.get(Uri.parse(
  //         'http://$domain:8070/api/users/all?email_or_username=$email&password=$password'));
  //     if (response.statusCode == 200) {
  //       setState(() {
  //         List<dynamic> dataList = jsonDecode(response.body) as List;
  //         if (dataList.isNotEmpty) {
  //           // Extract the first item from the list (assuming there's only one)
  //           Map<String, dynamic> userData = dataList.first;
  //
  //           // Access the "firstname" value
  //           int userID = userData['id'] ?? '';
  //           debugPrint('userid: $userID');
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MyDashboard(
  //                 userID: userID,
  //               ),
  //             ),
  //           );
  //         } else {
  //           // Handle case when the list is empty
  //           debugPrint('No data found');
  //         }
  //       });
  //     } else {
  //       throw Exception('Failed to load items');
  //     }
  //   }
  //
  //   // Make GET request to API
  //   final url = Uri.parse(
  //       'http://$domain:8070/api/users?email_or_username=$email&password=$password');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Access-Control-Allow-Origin":
  //           "*", // Ensure this matches CORS settings on server
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     var jsonResponse = jsonDecode(response.body);
  //     if (jsonResponse.containsKey('error')) {
  //       setState(() {
  //         debugPrint(jsonResponse['error']);
  //       });
  //     } else {
  //       setState(() {
  //         fetchItems();
  //       });
  //     }
  //   } else {
  //     setState(() {
  //       debugPrint("Login failed");
  //       showWidget = true;
  //       showTextFieldBorder = true;
  //       message = 'Incorrect Username or Password';
  //       usernameCon.clear();
  //       passwordCon.clear();
  //
  //       Timer(const Duration(seconds: 5), () {
  //         setState(() {
  //           showWidget = false;
  //           showTextFieldBorder = false;
  //         });
  //       });
  //     });
  //   }
  // }


  List<dynamic> getDatas() {
    return dataofuser;
  }

  Future<void> login() async {
    String email = usernameCon.text;
    String password = passwordCon.text;

    final Map<String, dynamic> requestBody = {
      "username": email,
      "password": password,
    };
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestBody),
    );
    print(response.statusCode);
    final jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      print(jsonData);
      userID = jsonData['Data']['id'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyDashboard(
            userID: userID,
          ),
        ),
      );
    } else {
      throw Exception('Failed to load items');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        // ),
        body: Container(
          color: const Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Image.asset(
              //   'assets/design1/brown.png',
              //   width: double.infinity,
              //   height: double.infinity,
              //   fit: BoxFit.cover,
              // ),
              Positioned(
                top: 1,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/design1/logbg.png',
                  width: screenWidth * 0.9, // Set width to screen width
                  height:
                      screenHeight * 1, // Set height to 30% of screen height
                  fit: BoxFit.fill, // Adjust the fit as needed
                ),
              ),
              // Positioned(
              //   bottom: 50,
              //   child: Image.asset(
              //     'assets/design1/white_login.png',
              //     width: screenWidth * 0.83, // Set width to screen width
              //     height: 500, // Set height to 30% of screen height
              //     fit: BoxFit.fill, // Adjust the fit as needed
              //   ),
              // ),
              // Positioned(
              //   top: 25,
              //   left: -5,
              //   child: Image.asset(
              //     'assets/design1/design1.png',
              //     width: 130,
              //     height: 130,
              //   ),
              // ),
              // Positioned(
              //     top: -5,
              //     right: -15,
              //     child: Image.asset(
              //       'assets/design1/design2.png',
              //       width: 130,
              //       height: 130,
              //     )),
              // Positioned(
              //   bottom: screenHeight * 0.73,
              //   child: Image.asset(
              //     'assets/design1/paw.png',
              //     width: 90,
              //     height: 90,
              //   ),
              // ),
              Positioned(
                top: 100,
                child: Image.asset(
                  'assets/design1/loginlogo.png',
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.6,
                ),
              ),
              // Positioned(
              //   left: -22,
              //   top: 150,
              //   child: Image.asset(
              //     'assets/design1/design3.png',
              //     width: 140,
              //     height: 140,
              //   ),
              // ),
              // Positioned(
              //   right: -5,
              //   top: 230,
              //   child: Image.asset(
              //     'assets/design1/design5.png',
              //     width: 120,
              //     height: 120,
              //   ),
              // ),
              Positioned(
                bottom: screenHeight * 0.23,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 3),
                      SizedBox(
                        width: screenWidth * 0.7,
                        height: 50,
                        child: TextFormField(
                          controller: usernameCon,
                          decoration: InputDecoration(
                            // filled: true,
                            // fillColor: const Color.fromARGB(255, 235, 235, 235),
                            labelText: "Email / Username", // This will act as placeholder text
                            labelStyle: const TextStyle(
                              color: Colors.grey
                              //color: Color.fromARGB(255, 156, 153, 147),
                            ),

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.brown,
                               // color: Color.fromARGB(255, 243, 243, 243), // Set border color same as fill color
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 198, 198, 198),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: showTextFieldBorder
                                    ? const Color.fromARGB(255, 255, 132, 132)
                                    : const Color.fromARGB(255, 235, 235, 235),
                                width: 2.0,
                              ),
                            ),
                            prefixIcon: const Icon(Icons.person,
                                size: 20, color: Color.fromARGB(255, 156, 153, 147)),
                            //contentPadding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 147, 132, 86)),
                        ),
                      ),

                       const SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const Text(
                            //   'Password',
                            //   style: TextStyle(
                            //     color: Color.fromARGB(255, 145, 136, 121),
                            //     fontSize: 15,
                            //   ),
                            // ),
                            const SizedBox(height: 3),
                            SizedBox(
                              width: screenWidth * 0.7,
                              height: 50,
                              child: TextField(
                                controller: passwordCon,
                                obscureText: enablepassword,
                                decoration: InputDecoration(
                                  labelText: "Password", // Label that will move to upper box
                                  // filled: true,
                                  // fillColor: const Color.fromARGB(255, 235, 235, 235),
                                  labelStyle: const TextStyle(
                                    color: Colors.grey
                                    //color: Color.fromARGB(255, 156, 153, 147),
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
                                      color: showTextFieldBorder
                                          ? const Color.fromARGB(
                                              255, 255, 132, 132)
                                          : const Color.fromARGB(
                                              255, 235, 235, 235),
                                      width: 2.0,
                                    ),
                                  ),
                                  prefixIcon: const Icon(Icons.lock,
                                      size: 20,
                                      color:
                                          Color.fromARGB(255, 156, 153, 147)),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      enablepassword ? Icons.visibility : Icons.visibility_off,
                                      color: const Color.fromARGB(255, 156, 153, 147),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        enablepassword = !enablepassword;
                                      });
                                    },
                                  ),
                                  // contentPadding:
                                  //     const EdgeInsets.symmetric(vertical: 10),
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                height: 45,
                width: screenWidth * 0.7,
                child: Padding(
                  padding: const EdgeInsets.all(
                      3.0), // Add padding to the left and right
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        login();
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 110, 77,
                            34), // Set the button's background color
                      ),
                      elevation: MaterialStateProperty.all<double>(0), // Remove button elevation
                    ),
                    child: const SizedBox(
                      width:
                          double.infinity, // Set width to fill available space
                      height: 50,
                      child: Center(
                        child: Text(
                          'Login',
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
                bottom: 55,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Do you have an account?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 117, 106, 86),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterPage()),
                          // MaterialPageRoute(builder: (context) => Email()),
                        );
                      },
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.2,
                right: screenWidth * 0.14,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Email_CP()),
                    );
                  },
                  child: const Text(
                    'Forget password?',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.blue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.198,
                left: screenWidth * 0.13,
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
                      activeColor: const Color.fromARGB(255, 153, 133, 93),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.215,
                left: screenWidth * 0.22,
                child: const Row(
                  children: [
                    Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 153, 133, 93),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 200,
                left: 74,
                child: Visibility(
                  visible: showWidget,
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color.fromARGB(255, 255, 5, 5),
                      fontWeight: FontWeight.bold, // Font Weight
                      fontFamily: 'Roboto-Black', // System font
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
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
