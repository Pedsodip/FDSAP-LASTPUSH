// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pawprojui/Screens/login/login.dart';
import 'package:pawprojui/Screens/map/petclinicsmaps.dart';
import 'package:pawprojui/Screens/petCare/petcare.dart';
import 'package:pawprojui/Screens/petscreens/contactus.dart';
import 'package:pawprojui/Screens/petscreens/pet_upload.dart';
import 'package:pawprojui/Screens/petscreens/petaccessories.dart';
import 'package:pawprojui/Screens/petscreens/petdetailspage.dart';
import 'package:pawprojui/Screens/petscreens/petfoods.dart';
//import 'package:pawprojui/Screens/petscreens/petsearchall.dart';
import 'package:pawprojui/Screens/products/accessories/acce_upload.dart';
import 'package:pawprojui/Screens/products/feeds/feeds_upload.dart';
import 'package:pawprojui/Screens/user/profile.dart';
import 'package:pawprojui/domain.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;

import '../petscreens/petsearchall.dart';

class MyDashboard extends StatefulWidget {
  final int userID;

  MyDashboard({required this.userID});

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchAllProducts();
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        currentAdIndex = (currentAdIndex + 1) % ads.length;
      });
    });
  }

  var client = http.Client(); // Initialize HTTP client

  List<Map<String, dynamic>> dataofUser = []; // Store fetched products
  List<Map<String, dynamic>> products = []; // Store fetched products

  Future<void> fetchUserData() async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('http://$domain/api/user?id=${widget.userID}'));

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

  Future<void> fetchAllProducts() async {
    try {
      final response =
          await client.get(Uri.parse('http://$domain/api/all/pet'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        List<dynamic> allProducts = jsonDecode(response.body);
        setState(() {
          // Update the state with fetched products
          products = List<Map<String, dynamic>>.from(allProducts);
        });
      } else {
        // Handle error response
        print('Failed to fetch products: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Error fetching products: $error');
    }
  }

  final String petImage = 'assets/dogs/dog001.jpg';
  int petAge = 7;
  //list ng ADS
  List<String> ads = [
    'assets/ads/ad5.png',
    'assets/ads/ad6.png',
    'assets/ads/ad7.png',
  ];
  List<String> adsLink = [
    'https://animalfoundation.com/whats-going-on/blog/basic-necessities-proper-pet-care',
    'https://www.avma.org/resources-tools/pet-owners/petcare',
    'https://www.petexpress.com.ph/',
  ];
  int currentAdIndex = 0;

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Check if user data has been fetched
    if (dataofUser.isEmpty) {
      // If dataofUser is empty, display a loading indicator or any placeholder widget
      return Center(child: CircularProgressIndicator());
      // return Center(
      //   child: Text(
      //     'No Data Available',
      //   ),
      // );
    } else {
      Map<String, dynamic> userData = dataofUser.first;

      if (products.isEmpty) {
        // If dataofUser is empty, display a loading indicator or any placeholder widget
        // return Center(child: CircularProgressIndicator());
        return Center(
          child: Text(
            'No Data Available',
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset(
                  'assets/design1/load001txt.png',
                  height: 100,
                  width: 200,
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10), // Adjust the value as needed
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  iconSize: 30,
                  onPressed: () {
                    // Handle notification button press
                  },
                ),
              ),
            ],
          ),
          //Hamburger Menu Function
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 248, 237, 222),
                  ),
                  margin: EdgeInsets.only(bottom: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(
                                widget.userID)), // Pass datas here
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: userData['profile_picture'] == null
                              ? const NetworkImage(
                                  'https://raw.githubusercontent.com/Valenzuela08/ImageStorage/main/images/default_profile.png')
                              : NetworkImage(userData['profile_picture']),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50),
                              child: Text(
                                '${userData['firstname']} ${userData['lastname']}',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.sell),
                  title: const Text(
                    'Sell an Item',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    MessageBox.show(context, widget.userID);
                  },
                ),
                const Divider(),
                //Go to Accessories Page
                ListTile(
                  leading: const Icon(Icons.health_and_safety),
                  title: const Text(
                    'Accessories',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PetAccessoriesPage(
                                  userID: widget.userID,
                                )));
                  },
                ),
                const Divider(),
                //Go to Pet Food Page
                ListTile(
                  leading: const Icon(Icons.food_bank_rounded),
                  title: const Text(
                    'Pet Food',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PetsFeedsPage(
                                  userID: widget.userID,
                                )));
                  },
                ),
                const Divider(),
                //Go to Maps/Clinics locations
                ListTile(
                  leading: const Icon(Icons.health_and_safety),
                  title: const Text(
                    'Pet Clinics',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapsPetClinics(),
                      ),
                    );
                  },
                ),

                const Divider(),
                //Go to Maps/Clinics locations
                ListTile(
                  leading: const Icon(Icons.health_and_safety),
                  title: const Text(
                    'Pet Care',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PetCarePage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                //Go to  Contact Us Page
                ListTile(
                  leading: const Icon(Icons.contacts),
                  title: const Text(
                    'Contact Us',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsPage(
                          userID: widget.userID,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(),
                //Logout confrimation(y/n)
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
          //pagebody contents here
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: Column(
                    children: [
                      //Searchbox function here
                      Container(
                        padding: const EdgeInsets.only(
                          top: 0,
                        ), // Adjust top padding as needed

                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: PopupMenuButton(
                              icon: const Icon(Icons.filter_list),
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    child: Text('Cats'),
                                    value: 'Filter1',
                                  ),
                                  const PopupMenuItem(
                                    value: 'Filter2',
                                    child: Text('Dog'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Filter3',
                                    child: Text('Pet Accessories'),
                                  ),
                                  const PopupMenuItem(
                                    child: Text('Pet Food'),
                                    value: 'Filter4',
                                  ),
                                  //
                                ];
                              },
                              onSelected: (value) {
                                ///
                                print('Selected Filter: $value');
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .blue, // Change this color to the desired color
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),
                      SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            // Navigate to the specified URL when the image is tapped
                            launch(adsLink[
                                currentAdIndex]); // Ensure you import 'package:url_launcher/url_launcher.dart'
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              ads[currentAdIndex],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),
                      const Divider(),
                      //featured pets contents here(Title)
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          SizedBox(height: 5),
                          Text(
                            'FEATURED PETS',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 101, 101, 101),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Handle tap for this specific container
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PetDetailsScreen(
                                      petID: products[
                                      index % products.length]['id'],
                                      userID: widget.userID,
                                      ownerID: products[
                                      index % products.length]['user_id'],
                                    ),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    2.0), // Adjust padding as needed
                                child: Container(
                                  width: 140,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 248, 237, 222),
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color.fromARGB(
                                                255, 218, 214, 214)
                                            .withOpacity(0.2),
                                        spreadRadius: 5,
                                        blurRadius: 20,
                                        offset: const Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          '${products[index % products.length]['image_product']}'),
                                      // AssetImage(
                                      //   'assets/design1/paw1.png',
                                      // ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 70,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color:
                                              Color.fromARGB(148, 58, 58, 58),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 5),
                                                  Text(
                                                    '${products[index % products.length]['petname']}',
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${products[index % products.length]['breed']}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 15),
                                              child: Text(
                                                '₱${products[index % products.length]['cost']}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 5),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      //Pets suggestion list function here
                      //Title here
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'PETS THAT MIGHT INTEREST YOU',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 101, 101, 101)),
                          ),
                          const SizedBox(height: 30),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PetSearchAllPage(
                                    userID: widget.userID,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'See All',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(0, 63, 63,
                              63), // Change the background color here
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PetDetailsScreen(
                                                petID: products[
                                                index % products.length]['id'],
                                                userID: widget.userID,
                                                ownerID: products[
                                                index % products.length]['user_id'],
                                          ),
                                        ),
                                      );
                                    },
                                    // child: Card(
                                    //   elevation: 3,
                                    //   color: index % 2 == 0
                                    //       ? Color.fromARGB(255, 237, 237, 237) // First color
                                    //       : Color.fromARGB(255, 221, 207, 194), // Alternate color
                                    //   shape: RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.circular(15),
                                    //   ),
                                    //   child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image(
                                              image: NetworkImage(
                                                  '${products[index % products.length]['image_product']}'),
                                              height: 100,
                                              width: 100,
                                            )),
                                        // const SizedBox(width:.5),
                                        // Container(
                                        //   padding: const EdgeInsets.all(5),
                                        //   decoration: BoxDecoration(
                                        //     borderRadius:
                                        //         BorderRadius.circular(0),
                                        //   ),
                                        //   child: ClipRRect(
                                        //     borderRadius:
                                        //         BorderRadius.circular(10),
                                        //     child: Image.asset(
                                        //       'assets/design1/paw.png',
                                        //       height: 100,
                                        //       width: 100,
                                        //       fit: BoxFit.cover,
                                        //     ),
                                        //   ),
                                        // ),
                                        const SizedBox(
                                            height:
                                                7), // Space between image and text
                                        Text(
                                          '${products[index % products.length]['petname']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.brown,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Text(
                                          '${products[index % products.length]['breed']}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 83, 79, 79),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),

                                        // const SizedBox(width: 20),
                                        // Row(
                                        //   children: [
                                        //     Column(
                                        //       crossAxisAlignment:
                                        //           CrossAxisAlignment.start,
                                        //       children: [
                                        //         SizedBox(height: 20),
                                        //         Text(
                                        //           '${products[index % products.length]['petname']}',
                                        //           style: const TextStyle(
                                        //             fontWeight: FontWeight.bold,
                                        //             color: Colors.brown,
                                        //             // color: Color.fromARGB(255, 83, 79, 79),
                                        //             fontSize: 20,
                                        //           ),
                                        //         ),
                                        //         Text(
                                        //           '${products[index % products.length]['breed']}',
                                        //           style: const TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.bold,
                                        //             color: Color.fromARGB(
                                        //                 255, 83, 79, 79),
                                        //           ),
                                        //           textAlign: TextAlign.start,
                                        //         ),
                                        //         const SizedBox(height: 5),
                                        //         const SizedBox(height: 10),
                                        // Row(
                                        //   children: [
                                        //     const Icon(
                                        //       Icons.transgender,
                                        //       size: 15,
                                        //     ),
                                        //     const SizedBox(width: 05),
                                        //     Text(
                                        //       '${products[index % products.length]['pet_gender']}',
                                        //       style: const TextStyle(
                                        //         fontWeight:
                                        //             FontWeight.w400,
                                        //         color: Color.fromARGB(
                                        //             255, 83, 79, 79),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //     const SizedBox(height: 1),
                                        //     Row(
                                        //       children: [
                                        //         const Icon(
                                        //           Icons.scale,
                                        //           size: 15,
                                        //         ),
                                        //         const SizedBox(width: 5),
                                        //         Text(
                                        //           '${products[index % products.length]['pet_weight']}KG',
                                        //           style: const TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.w400,
                                        //             color: Color.fromARGB(
                                        //                 255, 83, 79, 79),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        // SizedBox(width: 100),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     const SizedBox(height: 10),
                                        //     Container(
                                        //       child: SizedBox(
                                        //         height: 70,
                                        //         width: 50,
                                        //         child: Center(
                                        //           child: Text(
                                        //             '₱${products[index % products.length]['cost']}',
                                        //             style:
                                        //                 const TextStyle(
                                        //               fontSize: 23,
                                        //               color:
                                        //                   Color.fromARGB(
                                        //                       255,
                                        //                       83,
                                        //                       79,
                                        //                       79),
                                        //               fontWeight:
                                        //                   FontWeight.bold,
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     const SizedBox(height: 4),
                                        //     Row(
                                        //       children: [
                                        //         const Icon(
                                        //           Icons.av_timer_rounded,
                                        //           size: 15,
                                        //         ),
                                        //         const SizedBox(width: 10),
                                        //         Text(
                                        //           '${products[index % products.length]['pet_age']} y/o',
                                        //           style: const TextStyle(
                                        //             fontWeight:
                                        //                 FontWeight.w400,
                                        //             color: Color.fromARGB(
                                        //                 255, 83, 79, 79),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //     const SizedBox(height: 1),
                                        // Row(
                                        //   children: [
                                        //     const Icon(
                                        //       Icons.calendar_month,
                                        //       size: 15,
                                        //     ),
                                        //     const SizedBox(width: 10),
                                        //     Text(
                                        //       '${products[index % products.length]['pet_bday']}',
                                        //       style: const TextStyle(
                                        //         fontWeight:
                                        //             FontWeight.w400,
                                        //         color: Color.fromARGB(255, 83, 79, 79),
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                        //       ],
                                        //     ),
                                        //   ],
                                        // ),
                                        // const SizedBox(width: 10), (ITO YUNG MALING SOBRA SA TEXT BOX)
                                      ],
                                    ),
                                  ),
                                ),
                                // ),
                              );
                            },
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
}

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Logout?',
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
              const SizedBox(height: 20),
              const Text(
                'Are you sure you want to logout?',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text('Logout'),
          ),
        ],
      );
    },
  );
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
                  child: const Text('Pet Food(s)'),
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
