import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain.dart';
import '../user/changepass.dart';
import 'email_CP.dart';

class EmailConfirmCP extends StatefulWidget {
  final String text;
  final String emailAddress;

  EmailConfirmCP({required this.text, required this.emailAddress});

  @override
  _EmailConfirmStateCP createState() => _EmailConfirmStateCP();
}

class _EmailConfirmStateCP extends State<EmailConfirmCP> {
  int _counter = 180;
  bool _isCounting = false;
  late Timer _otpTimer;
  bool isOtpExpired = false;
  bool showWidget = false;
  bool inputOTP = false;
  String message = '';
  late String OTPtoCheck;
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> focuscontroller;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (index) => TextEditingController());
    focuscontroller = List.generate(6, (index) => FocusNode());
    OTPtoCheck = widget.text;
    _startCountdown();
    startOtpTimer();
  }

  void startOtpTimer() {
    const duration = Duration(seconds: 180); // 3 minutes for expiration
    _otpTimer = Timer(duration, () {
      setState(() {
        isOtpExpired = true;
      });
    });
  }

  void resetOtpTimer() {
    _otpTimer.cancel(); // Cancel the previous timer
    setState(() {
      isOtpExpired = false;
    });
    startOtpTimer(); // Start a new timer
  }

  void _resentOTP() async {
    _startCountdown();
    startOtpTimer();
    setState(() {
      inputOTP = false;
      showWidget = false;
    });

    String apiUrl = 'http://$domain/api/send/otp';

    String recipientEmail = widget.emailAddress;

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
        resetOtpTimer();
        OTPtoCheck = otp;
      } else {
        debugPrint(
            'Failed to generate OTP. Status code: ${response.statusCode}');
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _checkOTP() async {
    String trueOTP = OTPtoCheck;
    if (isOtpExpired) {
      setState(() {
        inputOTP = true;
        message = 'OTP expired request another.';
        showWidget = true;
      });
      return;
    }

    String enteredOTP =
        _otpControllers.map((controller) => controller.text).join();

    if (enteredOTP.isEmpty) {
      setState(() {
        inputOTP = true;
        message = 'Please enter your OTP.';
        showWidget = true;
      });
      return;
    }

    if (enteredOTP == trueOTP) {
      setState(() {
        inputOTP = false;
        showWidget = false;
        debugPrint('OTP Match');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  Changepass(emailAddress: widget.emailAddress)),
        );
        resetOtpTimer();
        // Clear entered OTP
        _otpControllers.forEach((controller) {
          controller.clear();
        });
      });
    } else {
      setState(() {
        inputOTP = true;
        message = 'Wrong OTP entered';
        showWidget = true;
      });
      debugPrint('$enteredOTP != $trueOTP');
    }
  }

  void _startCountdown() {
    if (!_isCounting) {
      setState(() {
        _isCounting = true;
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          } else {
            _isCounting = false;
            timer.cancel();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _otpControllers.forEach((controller) {
      controller.dispose();
    });
    _otpTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _counter ~/ 60;
    int seconds = _counter % 60;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    String emailtext = widget.emailAddress;
    int maxlength = 1;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 207, 184, 153),
        ),
        body: Container(
          color: const Color.fromARGB(255, 207, 184, 153),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
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
                  top: 293,
                  left: 55,
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
                  'Enter Your Verification Code',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 98, 74, 26),
                    fontWeight: FontWeight.bold, // Font Weight
                    fontFamily: 'Roboto-Black', // System font
                  ),
                ),
              ),
              Positioned(
                top: 170,
                child: Text.rich(
                  TextSpan(
                    text: 'Enter the Verification Code ',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 90, 90, 90),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto-Black',
                    ),
                    children: <TextSpan>[
                      const TextSpan(
                        text: 'we sent to \n',
                      ),
                      TextSpan(
                        text: '$emailtext',
                        style: const TextStyle(
                          color: Color.fromARGB(255, 153, 133, 93),
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                top: 220,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      6,
                      (index) => SizedBox(
                        width: screenWidth * 0.13,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: _otpControllers[index],
                              focusNode: focuscontroller[index],
                              onChanged: (value) {
                                if (value.isNotEmpty && index < 5) {
                                  FocusScope.of(context)
                                      .requestFocus(focuscontroller[index + 1]);
                                } else if (value.isEmpty && index > 0) {
                                  FocusScope.of(context)
                                      .requestFocus(focuscontroller[index - 1]);
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 240, 240, 240),
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 156, 153, 147)),
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
                                    color: inputOTP
                                        ? Color.fromARGB(255, 255, 132, 132)
                                        : Color.fromARGB(255, 240, 240, 240),
                                    width: 2.0,
                                  ),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 135, 132, 127),
                                  fontWeight: FontWeight.w700),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(maxlength),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.386, // Adjust top position as needed
                left: MediaQuery.of(context).size.width *
                    0.13, // Adjust left position as needed
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Didn’t get it?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 155, 133, 93),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _resentOTP();
                      },
                      child: const Text(
                        'Resend OTP',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 96, 80, 48),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 330,
                width: screenWidth * 0.75,
                child: Stack(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _checkOTP();
                      },
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        height: 50,
                        child: Center(
                          child: Text(
                            'Verify OTP',
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
              Positioned(
                top: MediaQuery.of(context).size.height *
                    0.399, // Adjust top position as needed
                left: MediaQuery.of(context).size.width *
                    0.810, // Adjust right position as needed
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$minutes:${seconds < 10 ? '0$seconds' : seconds}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 155, 133, 93),
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
