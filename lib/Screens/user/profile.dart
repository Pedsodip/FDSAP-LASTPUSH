// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pawprojui/Screens/petscreens/pet_upload.dart';
import 'package:pawprojui/Screens/petscreens/petsearchall.dart';
import 'package:pawprojui/Screens/products/accessories/acce_upload.dart';
import 'package:pawprojui/Screens/products/feeds/feeds_upload.dart';
import 'package:pawprojui/Screens/user/edit_profile.dart';
import 'package:pawprojui/domain.dart';

class ProfileScreen extends StatefulWidget {
  final int userID;

  ProfileScreen(this.userID);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Variable to keep track of tapped state for each container
  Map<int, bool> isTappedMap = {};
  late List<Map<String, dynamic>> selectedTable = [];
  bool myorder = true;
  bool differentcart = false;

  List<Map<String, dynamic>> dataofUser = []; // Store fetched products
  var client = http.Client();
  Future<void> fetchUserData() async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('http://$domain:8070/byID?id=${widget.userID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            dataofUser = [responseData]; // Wrap responseData in a list
          });
          print(dataofUser);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            dataofUser = List<Map<String, dynamic>>.from(responseData);
          });
          print(dataofUser);
        } else {
          // Handle unexpected response format
          print('Unexpected response format: $responseData');
        }
      } else {
        // Handle error response
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching user data: $error');
    }
  }

  List<Map<String, dynamic>> itemsofuser = []; // Store fetched products
  Future<void> fetchuserItems() async {
    var client = http.Client();
    try {
      final response = await client.get(
          Uri.parse('http://$domain:8070/showcart?user_id=${widget.userID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            itemsofuser = [responseData]; // Wrap responseData in a list
          });
          print(itemsofuser);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            itemsofuser = List<Map<String, dynamic>>.from(responseData);
          });
          print(itemsofuser);
        } else {
          // Handle unexpected response format
          print('Unexpected response format: $responseData');
        }
      } else {
        // Handle error response
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching user data: $error');
    }
  }

  List<Map<String, dynamic>> itemsofuserListing = []; // Store fetched products
  Future<void> fetchuserListing() async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(
          'http://$domain:8070/cart_listing?user_id=${widget.userID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            itemsofuserListing = [responseData]; // Wrap responseData in a list
          });
          print(itemsofuserListing);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            itemsofuserListing = List<Map<String, dynamic>>.from(responseData);
          });
          print(itemsofuserListing);
        } else {
          // Handle unexpected response format
          print('Unexpected response format: $responseData');
        }
      } else {
        // Handle error response
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching user data: $error');
    }
  }

  List<Map<String, dynamic>> itemsofuserWishlist = []; // Store fetched products
  Future<void> fetchuserWishlist() async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(
          'http://$domain:8070/cart_wishlist?user_id=${widget.userID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            itemsofuserWishlist = [responseData]; // Wrap responseData in a list
          });
          print(itemsofuserWishlist);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            itemsofuserWishlist = List<Map<String, dynamic>>.from(responseData);
          });
          print(itemsofuserWishlist);
        } else {
          // Handle unexpected response format
          print('Unexpected response format: $responseData');
        }
      } else {
        // Handle error response
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching user data: $error');
    }
  }

  List<Map<String, dynamic>> itemsofuserHistory = []; // Store fetched products
  Future<void> fetchuserHistory() async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(
          'http://$domain:8070/purchase_history?user_id=${widget.userID}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            itemsofuserHistory = [responseData]; // Wrap responseData in a list
          });
          print(itemsofuserHistory);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            itemsofuserHistory = List<Map<String, dynamic>>.from(responseData);
          });
          print(itemsofuserHistory);
        } else {
          // Handle unexpected response format
          print('Unexpected response format: $responseData');
        }
      } else {
        // Handle error response
        print('Failed to fetch user data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchuserItems();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // Check if user data has been fetched
    if (dataofUser.isEmpty) {
      // If dataofUser is empty, display a loading indicator or any placeholder widget
      return Center(child: CircularProgressIndicator());
    } else {
      // If user data is available, display the user profile
      Map<String, dynamic> userData = dataofUser.first;

      return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: userData['profile_image'] != null
                              ? MemoryImage(
                                  base64Decode(userData['profile_image']!))
                              : const AssetImage('assets/default_profile.png')
                                  as ImageProvider,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${userData['firstname']} ${userData['lastname']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@${userData['username']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 143, 143, 143),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditProfilePage( userID: widget.userID,)),
                                );
                                // Add your onPressed action here
                              },
                              child: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 164, 164, 164),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16), // Adjust as needed
                          Container(
                            width: 100,
                            height: 35,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromARGB(255, 143, 143, 143),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextButton(
                              onPressed: () {
                                MessageBox.show(context, widget.userID);
                              },
                              child: const Text(
                                'Sell Pet',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 164, 164, 164),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${userData['bio']}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'LOCATION',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 209, 166,
                                    97), // Change 'Colors.red' to the color you want
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              '${userData['address']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'BIRTHDAY',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 209, 166,
                                    97), // Change 'Colors.blue' to the color you want
                              ),
                            ),

                            SizedBox(
                                height:
                                    4), // Adjust spacing between the two texts
                            Text(
                              '${userData['dateOfBirth']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            Text(
                              'MEMBER SINCE',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 209, 166,
                                    97), // Change 'Colors.green' to the color you want
                              ),
                            ),

                            SizedBox(
                                height:
                                    4), // Adjust spacing between the two texts
                            Text(
                              '${userData['contact_no']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.5),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await fetchuserItems();
                            setState(() {
                              selectedTable = itemsofuser;
                              myorder = false;
                              differentcart = true;
                            });
                          },
                          child: Text(
                            'My Orders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 146, 146, 146),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        TextButton(
                          onPressed: () async {
                            await fetchuserListing();
                            setState(() {
                              selectedTable = itemsofuserListing;
                              myorder = false;
                              differentcart = true;
                            });
                          },
                          child: Text(
                            'My Lisitng',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 146, 146, 146),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        TextButton(
                          onPressed: () async {
                            await fetchuserWishlist();
                            setState(() {
                              selectedTable = itemsofuserWishlist;
                              myorder = false;
                              differentcart = true;
                            });
                          },
                          child: Text(
                            'Wishlist',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 146, 146, 146),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.1,
                        ),
                        TextButton(
                          onPressed: () async {
                            await fetchuserHistory();
                            setState(() {
                              selectedTable = itemsofuserHistory;
                              myorder = false;
                              differentcart = true;
                            });
                          },
                          child: Text(
                            'Purchase\nHistory',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 146, 146, 146),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (myorder)
                Positioned(
                  bottom: 70,
                  child: Stack(
                    children: <Widget>[
                      if (itemsofuser.isEmpty)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'You don\'t have any pets available for \n  ordering at the moment.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ),
                              SizedBox(height: 15),
                              Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // Adjust this value for the empty state card
                                  side: BorderSide(
                                    color: Color.fromARGB(255, 143, 143, 143),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                    onPressed: () {
                                      // Add your onPressed action here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PetSearchAllPage(
                                                  userID: widget.userID,
                                                )),
                                      );
                                    },
                                    child: Text(
                                      'Buy Pet',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 164, 164, 164),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              children: itemsofuser.map((item) {
                                return SizedBox(
                                  height:
                                      250, // Specify the desired height of the card
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height:
                                                      8), // Add space between text and image
                                              Divider(),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                  'assets/design1/paw1.png',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      'assets/design1/paw.png',
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width:
                                                  12), // Add space between text and other content
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pet ID: ${item['pet_id']}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${item['name']}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${item['breed']}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '₱${item['price']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              if (differentcart)
                Positioned(
                  bottom: 70,
                  child: Stack(
                    children: <Widget>[
                      if (selectedTable.isEmpty)
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 15),
                              Text(
                                'You don\'t have any pets available for ordering at the moment.',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 125, 125, 125),
                                ),
                              ),
                              SizedBox(height: 15),
                              Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 143, 143, 143),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PetSearchAllPage(
                                                userID: widget.userID,
                                              )),
                                    );
                                    // Add your onPressed action here
                                  },
                                  child: Text(
                                    'Buy Pet',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 164, 164, 164),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              children: selectedTable.map((item) {
                                return SizedBox(
                                  height:
                                      250, // Specify the desired height of the card
                                  child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height:
                                                      8), // Add space between text and image
                                              Divider(),
                                              Container(
                                                width: 100,
                                                height: 100,
                                                child: Image.asset(
                                                  'assets/design1/paw1.png',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Image.asset(
                                                      'assets/design1/paw.png',
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width:
                                                  12), // Add space between text and other content
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Pet ID: ${item['pet_id']}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${item['name']}',
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  '${item['breed']}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                '₱${item['price']}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                    ],
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
  static void show(BuildContext context, int userID) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Sell an Item',
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.asset(
                  'assets/design1/paw.png',
                  width: 75,
                  height: 75,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => accUploadPage(userID)),
                    );
                  },
                  child: const Text('Pet Accessories'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => feedUploadPage(userID)),
                    );
                  },
                  child: const Text('Pet Food/s'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetUploadPage(userID)),
                    );
                  },
                  child: const Text('A Pet'),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
