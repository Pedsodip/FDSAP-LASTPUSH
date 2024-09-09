import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  @override
  Widget build(BuildContext context) {
    return  Material(
      child: Stack(
        children: [
          Image.asset(
            'assets/design1/brown.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/design1/paw.png',
                    width: 120,
                    height: 120,
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: -5),
            child: Center(
              child: Image.asset(
                'assets/design1/furpect_paw.png',
                width: 300,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
