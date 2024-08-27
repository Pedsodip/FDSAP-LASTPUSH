// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pawprojui/Screens/petscreens/contactus.dart';
import 'package:pawprojui/Screens/petscreens/petfoods.dart';
import 'package:pawprojui/Screens/petscreens/petsearchall.dart';
import 'package:pawprojui/Screens/products/feeds/feeds_upload.dart';
import 'package:pawprojui/Screens/user/edit_profile.dart';
import 'Screens/login/login.dart';
import 'Screens/petCare/petcare.dart';
import 'Screens/petscreens/petdetailspage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: DefineRoutes.define(),
    );
  }
}

class DefineRoutes {
  static const String loginscreeb = '/login';
  static const String petdetail = '/pet_details';
  // static const String dashBor = '/mydbo';
  static const String petCare = '/care';
  static const String petAll = '/seall';
  static const String petFeed = '/feed';
  static const String contact = '/cont';
  static const String pupLoad = '/pupload';
  static const String feedUp = '/feupload';
  static const String accUp = '/accupload';

  static Map<String, WidgetBuilder> define() {
    return {
      loginscreeb: (context) => LoginPage(),
      //petdetail: (context) => PetDetailsScreen(),
      // dashBor:(context) => MyDashboard(sample),
      petCare: (context) => PetCarePage(),
      // petAll: (context) => PetSearchAllPage(),
      //petFeed: (context) => PetsFeedsPage(),
      //contact: (context) => ContactUsPage(),
      // pupLoad: (context) => EditProfilePage(),
      //feedUp: (context) => feedUploadPage(),
      // accUp:(context) =>
    };
  }
}
