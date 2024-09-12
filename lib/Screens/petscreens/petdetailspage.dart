
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawprojui/domain.dart';
import '../map/google_map.dart';
import '../user/profile.dart';
import 'package:http/http.dart' as http;

class PetDetailsScreen extends StatefulWidget { final int petID;
final int userID;
final int ownerID;

// ignore: prefer_const_constructors_in_immutables
PetDetailsScreen({required this.petID, required this.userID, required this.ownerID});

@override
_PetDetailsScreenState createState() => _PetDetailsScreenState();
}

class _PetDetailsScreenState extends State<PetDetailsScreen> {
  bool currentPage = true;


  var client = http.Client(); // Initialize HTTP client

  List<Map<String, dynamic>> dataofpet = []; // Store fetched products

  Future<void> fetchPetinfo() async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('http://$domain/api/pet?id=${widget.petID}'));

      if (response.statusCode == 200) {
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          setState(() {
            dataofpet = [responseData];
          });
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            dataofpet = List<Map<String, dynamic>>.from(responseData);
          });
        } else {
          // Handle unexpected response format
        }
      } else {
        // Handle error response
      }
    } catch (error) {
      // Handle network errors
    }
  }

  Future<void> removeFromDash() async {
    var client = http.Client();
    try {
      final response = await client
          .put(Uri.parse('http://$domain:8070/removeFromDash?id=${widget.petID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            dataofpet = [responseData]; // Wrap responseData in a list
          });
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            dataofpet = List<Map<String, dynamic>>.from(responseData);
          });
        } else {
          // Handle unexpected response format
        }
      } else {
        // Handle error response
      }
    } catch (error) {
      // Handle network errors
    }
  }

  List<Map<String, dynamic>> dataofUser = []; // Store fetched product
  Future<void> fetchUserData() async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('http://$domain/api/user?id=${widget.ownerID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);
        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            dataofUser = [responseData]; // Wrap responseData in a list

          });
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            dataofUser = List<Map<String, dynamic>>.from(responseData);

          });
        } else {
          // Handle unexpected response format
        }
      } else {
        // Handle error response
      }
    } catch (error) {
      // Handle network errors
    }
  }

  Future<void>  _wishlist(String nameOfPet, String selectedbreed, String selectedtype,String gender, String bday,String weight, String price) async {
    String dateUpload = DateTime.now().toString();
    var url = Uri.parse('http://$domain:8070/addToWish');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": widget.userID,
        "pet_id": widget.petID,
        "date_uploaded": dateUpload,
        "name": nameOfPet,
        "type": selectedtype,
        "breed": selectedbreed,
        "gender": gender,
        "date_of_birth": bday,
        "weight": weight,
        "price":  price ,
        "image": "test"
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        String message = jsonResponse['message'];
        print(message);
      });
    } else if (response.statusCode == 409) {
      // Email or username already exists
      setState(() {

      });
    } else {
      setState(() {
        debugPrint("ERROR" );
      });
    }
  }

  Future<void> _TakeHomePet(String nameOfPet, String selectedbreed, String selectedtype,String gender, String bday,String weight, String price) async {
    String dateUpload = DateTime.now().toString();
    var url = Uri.parse('http://$domain:8070/addtocart');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": widget.userID,
        "pet_id": widget.petID,
        "date_uploaded": dateUpload,
        "name": nameOfPet,
        "type": selectedtype,
        "breed": selectedbreed,
        "gender": gender,
        "date_of_birth": bday,
        "weight": weight,
        "price":  price ,
        "image": "test"
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      setState(() {
        String message = jsonResponse['message'];
        print(message);
        removeFromDash();
        Navigator.pop(context);
      });
    } else if (response.statusCode == 409) {
      // Email or username already exists
      setState(() {

      });
    } else {
      setState(() {
        debugPrint("ERROR" );
      });
    }
  }
  final List<String> userPetImages = [
    'assets/dogs/dog001.jpg',
    'assets/dogs/dog002.jpeg'
  ];

  final String furpawImage = 'assets/design1/furpaw.png';

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchPetinfo();
    fetchUserData();
  }

  @override
  void dispose() {
    // Dispose the page controller
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if user data has been fetched
    if (dataofpet.isEmpty) {
      // If dataofUser is empty, display a loading indicator or any placeholder widget
      return Center(child: CircularProgressIndicator());
    } else {
      // If user data is available, display the user profile
      Map<String, dynamic> petdata = dataofpet.first;
      Map<String, dynamic> userdata = dataofUser.first;
      // Map<String, dynamic> userData = dataofUser.first;
      String petGender = '${petdata['petname']}';
      return Scaffold(
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'assets/design1/banner.png',
              height: 200,
            ),
          ),
          centerTitle: true,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageController, // Assign page controller
                      itemCount:1,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                10), // Adjust the radius as needed
                            child:Image.network(
                              '${petdata['image_product']}',
                              width: double.infinity,
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          1,
                              (index) => Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage == index
                                  ? Colors.blue
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 4,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  width: double.infinity,
                  height: 700,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Container(
                          height: 225,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0, right: 40.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(height: 5),
                                        Text(
                                          '₱${petdata['cost']}',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    10.0), // Padding for content
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${petdata['petname']}',
                                      style: TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '${petdata['breed']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          size: 18,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MapScreen(
                                                      Loc: LatLng(
                                                          14.068900, 121.32903))),
                                            );
                                          },
                                          child: Text(
                                            '${petdata['pet_Loc']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 1,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                petGender != "Male"
                                                    ? Icon(
                                                  Icons.female,
                                                  size: 25,
                                                )
                                                    : Icon(Icons.male),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${petdata['pet_gender']}',
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.timelapse,
                                                  size: 23,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${petdata['pet_age']}Y/O',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 70,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.scale_outlined,
                                                  size: 23,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${petdata['pet_weight']}KG',
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_month_outlined,
                                                  size: 23,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${petdata['pet_bday']}',
                                                  style: TextStyle(fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10.0), // Adjust as needed
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ProfileScreen(
                                              0,
                                            )));
                                  },
                                  child: Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                          ui.Color.fromARGB(255, 235, 175, 119),
                                          width: 2,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: NetworkImage(userdata['profile_picture'])
                                        // AssetImage(
                                        //       'assets/design1/paw.png',
                                        // ),
                                      ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${userdata['firstname']+' '+userdata['lastname']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                                Text(
                                  'Pet Owner',
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(width: 25),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, top: 1.0), // Adjust as needed
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 120.0,
                                    height: 40.0,
                                    child: FloatingActionButton(
                                      onPressed: () {
                                        MessageBox.show(context, userdata['contact'], userdata['email']);
                                      },
                                      backgroundColor:
                                      ui.Color.fromARGB(255, 255, 255, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(
                                          color: const ui.Color.fromARGB(
                                              255, 141, 141, 141),
                                        ), // Add color to border
                                      ),
                                      elevation: 0, // Remove shadow
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "Contact",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: ui.Color.fromARGB(
                                                  255, 141, 141, 141),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: ui.Color.fromARGB(
                                  0, 173, 144, 144)), // Border color
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              '${petdata['description']}',

                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.pets,
                            ),
                            iconSize: 45,
                            color: ui.Color.fromARGB(255, 143, 142, 142),
                            onPressed: () {
                              _wishlist(petdata['petname'].toString(), petdata['breed'].toString(), petdata['category'].toString(), petdata['pet_gender'].toString(), petdata['pet_bday'].toString(), petdata['pet_weight'].toString(), petdata['cost'].toString());

                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(),
                          ElevatedButton(
                            onPressed: () {
                              // void _TakeHomePet(String nameOfPet, String selectedbreed, String selectedtype,String gender, String bday,String weight, String price) async {
                              _TakeHomePet(petdata['petname'].toString(), petdata['breed'].toString(), petdata['category'].toString(), petdata['pet_gender'].toString(), petdata['pet_bday'].toString(), petdata['pet_weight'].toString(), petdata['cost'].toString());

                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              textStyle: TextStyle(fontSize: 16),
                              fixedSize: Size(250, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Adjust the radius as needed
                                side: BorderSide(
                                  color: ui.Color.fromARGB(
                                      255, 213, 213, 213), // Border color
                                ),
                              ), // Set your desired background color here
                            ),
                            child: Text(
                              'Take Me Home',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}



class MessageBox {
  static void show(BuildContext context, String ContactNO, String EmailAdd) {
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
                  SizedBox(width: 20),
                  Text(
                    "Owners Contact Info",
                    style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 98, 74, 26),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    ContactNO,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(
                          255, 0, 0, 0), // Change text color
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    EmailAdd,
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color.fromARGB(
                          255, 0, 0, 0), // Change text color
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 90, 90, 90),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}