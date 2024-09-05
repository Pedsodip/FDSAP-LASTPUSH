// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:pawprojui/domain.dart';
import 'package:flutter/material.dart';
import 'package:pawprojui/Screens/dashboard/mydashboard.dart';
import 'package:pawprojui/Screens/petscreens/petdetailspage.dart';
import 'package:http/http.dart' as http;

class PetSearchAllPage extends StatefulWidget {
  final int userID;

  PetSearchAllPage({required this.userID});

  @override
  _PetSearchAllPageState createState() => _PetSearchAllPageState();
}

class _PetSearchAllPageState extends State<PetSearchAllPage> {
  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchAllProducts();
  }

  var client = http.Client();

  List<Map<String, dynamic>> dataofUser = []; // Store fetched products
  List<Map<String, dynamic>> products = []; // Store fetched products

  Future<void> fetchUserData() async {
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

  Future<void> fetchAllProducts() async {
    try {
      final response =
          await client.get(Uri.parse('http://$domain:8070/dashdata'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        dynamic responseData = jsonDecode(response.body);

        if (responseData is Map<String, dynamic>) {
          // If responseData is a JSON object (Map)
          setState(() {
            products = [responseData]; // Wrap responseData in a list
          });
          print(dataofUser);
        } else if (responseData is List<dynamic>) {
          // If responseData is a JSON array (List)
          setState(() {
            products = List<Map<String, dynamic>>.from(responseData);
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

  Widget build(BuildContext context) {
    // Check if user data has been fetched
    if (dataofUser.isEmpty) {
      // If dataofUser is empty, display a loading indicator or any placeholder widget
      return Center(child: CircularProgressIndicator());
    } else {
      // If user data is available, display the user profile
      Map<String, dynamic> userData = dataofUser.first;
      if (products.isEmpty) {
        // If dataofUser is empty, display a loading indicator or any placeholder widget
        return Center(child: CircularProgressIndicator());
      } else {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Image.asset(
                  'assets/design1/load001txt.png',
                  height: 120,
                  width: 200,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons
                  .arrow_back_ios), // You can replace Icons.menu with any other icon
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDashboard(
                        userID: widget.userID,
                      ),
                    ));
              },
            ),
            //function for notification
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.notifications),
                iconSize: 35,
                onPressed: () {
                  // Handle notification button press
                },
              )
            ],
//Search and filter function here
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: SizedBox(
                  height: 50,
                  child: Container(
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
                ),
              ),
            ),
          ),
          //Card List
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 15), // Adjust the horizontal padding
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              itemCount: products.length, //Dami ng Cards
              itemBuilder: (BuildContext context, int index) {
                //kulay ng CARDS pra alternate
                Color cardColor;
                if (index == 0) {
                  cardColor =
                      Color.fromARGB(255, 244, 243, 243); // unang index (white)
                } else if ((index - 1) % 4 < 2) {
                  cardColor = Color.fromARGB(255, 207, 184,
                      153); // Brown color sa index number 2, 3, 6, 7, 10, ...
                } else {
                  cardColor = const Color.fromARGB(255, 244, 243,
                      243); // White fcolor sa index number 4, 5, 8, 9, 12, ...
                }
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PetDetailsScreen(
                                petID: products[index % products.length]['id'],
                                userID: widget.userID,
                              )),
                    );
                  },
                  child: Card(
                    color: cardColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Adjust the radius as needed
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    '${products[index % products.length]['image_product']}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top:
                                        10, // Adjust this value to position the text vertically
                                    left:
                                        10, // Adjust this value to position the text horizontally
                                    child: Text(
                                      '\₱${products[index % products.length]['cost']}',
                                      style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8 , horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${products[index % products.length]['petname']}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Breed: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${products[index % products.length]['breed']}',
                                          style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Age: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${products[index % products.length]['pet_age']} y/o',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          'Weight: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${products[index % products.length]['pet_weight']} KG',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Birthdate: ',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${products[index % products.length]['pet_bday']}',
                                          style: TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    }
  }
}
