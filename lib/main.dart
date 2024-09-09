// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:pawprojui/Screens/dashboard/mydashboard.dart';
import 'package:pawprojui/Screens/login/loginpage.dart';
import 'package:pawprojui/Screens/petscreens/contactus.dart';
import 'package:pawprojui/Screens/petscreens/petaccessories.dart';
import 'package:pawprojui/Screens/petscreens/petfoods.dart';
import 'package:pawprojui/Screens/petscreens/petsearchall.dart';
import 'package:pawprojui/Screens/products/feeds/feeds_upload.dart';
import 'package:pawprojui/Screens/user/edit_profile.dart';
import 'Screens/login/login.dart';
import 'Screens/petCare/petcare.dart';
import 'Screens/petscreens/petdetailspage.dart';
import 'Screens/products/accessories/acce_upload.dart';
// import 'Screens/addtocart/addtocartpage.dart';

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
  static const String loginscreen = '/login';
  static const String petdetail = '/pet_details';
  // static const String dashBor = '/dashboard';

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
      loginscreen: (context) => LoginPage(),
     // dashboardscreen:(context)=> MyDashboard(),
      //petdetail: (context) => PetDetailsScreen(),
      //  dashBor:(context) => MyDashboard(),
      petCare: (context) => PetCarePage(),
      // petAll: (context) => PetSearchAllPage(),
      //petFeed: (context) => PetsFeedsPage(),
      //contact: (context) => ContactUsPage(),
      // pupLoad: (context) => EditProfilePage(),
      //feedUp: (context) => feedUploadPage(),
       //accUp:(context) => PetAccessoriesPage(userID: 19,),
    };
  }
}
