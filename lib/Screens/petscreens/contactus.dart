// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';


int contactnum = 9123456789;
final String PawImage = 'assets/loadingpets.gif';

class ContactUsPage extends StatefulWidget {
  final int userID;

  ContactUsPage({required this.userID});
  
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios), // Hamburger icon
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Image.asset(PawImage),
        Container(
          height: 100,
          width: 100,
          child: Image.asset(PawImage),
        ),
        Text(
          'Email Us\n@',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text('emailus@fufectpawradise.com',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
        SizedBox(height: 30),
        Text(
          'Call Us\n@',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text('(+63) $contactnum',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14)),
      ])),
    );
  }
}