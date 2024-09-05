// ignore_for_file: library_private_types_in_public_api, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawprojui/Screens/petscreens/petdetailspage.dart';
import 'package:pawprojui/Screens/petscreens/petfoods.dart';
import '../login/login.dart';
import '../dashboard/mydashboard.dart';
import '../map/google_map.dart';
import '../map/petclinicsmaps.dart';
import '../user/profile.dart';
import 'contactus.dart';

class PetAccessoriesPage extends StatefulWidget {
  final int userID;

  PetAccessoriesPage({required this.userID});
  @override
  _PetAccessoriesPageState createState() => _PetAccessoriesPageState();
}

const String userImage = 'assets/kitz.jpg';
const String name = 'Kitzie123';
const String petImage = 'assets/dogs/dog001.jpg';

class _PetAccessoriesPageState extends State<PetAccessoriesPage> {
  late List<dynamic> datas = [];

  List<String> accImages = [
    'assets/petaccessories/catcollar1.jpg',
    'assets/petaccessories/catleash1.jpg',
    'assets/petaccessories/cattag1.jpg',
    'assets/petaccessories/dogtag1.jpg',
    'assets/petaccessories/dogcollar1.jpg',
    'assets/petaccessories/dogleash1.jpg',
    'assets/petaccessories/chewbone.jpg',
    'assets/petaccessories/furremovroller1.jpg',
    'assets/petaccessories/litterbox.jpg',
  ];

  List<LatLng> locationLatLng = [
    LatLng(14.068760386861499,
        121.32907542861261), // San pablo - petLovers boulevard
    LatLng(14.178426665635675, 121.27713359307762), // bay laguna - good pets
    LatLng(
        14.110600445845161, 121.14447923863916), // santo tomas -barks and meows
    LatLng(48.8566, 2.3522), // Paris, France
    LatLng(35.6895, 139.6917), // Tokyo, Japan
  ];

  List<SizeAvailability> sizeAvailabilities = [
    SizeAvailability('XS', 10),
    SizeAvailability('S', 15),
    SizeAvailability('M', 20),
    SizeAvailability('L', 25),
    SizeAvailability('XL', 18),
    SizeAvailability('XXL', 12),
  ];

  List<String> accNames = [
    'DIY Cute Cat Collars',
    'Leash for Cats',
    'Personalized Cat Tags',
    'Dog tags',
    'Dog Collar',
    'Retractable Leash',
    'Bone Chews',
    'Pet Hair Remover Roller',
    'Pet Litter Box',
  ];

  List<String> accDescriptions = [
    'Customize your cat’s style with DIY Cute Cat Collars. These easy-to-make, adorable collars offer a personal touch, combining comfort and charm for your feline friend.',
    'A Leash for Cats provides control and safety during outdoor adventures, allowing your cat to explore securely.',
    "Personalized Cat Tags are custom-engraved identifiers that ensure your cat's safety. ",
    "Dog Tags are essential ID tags that ensure your pet's safety. ",
    'A Dog Collar combines style and function, providing a secure fit for your dog while offering a space for identification tags.',
    'A Retractable Leash offers freedom and control, allowing your dog to explore while staying safely connected.',
    "Bone Chews are durable treats that satisfy your dog's chewing instincts while promoting dental health. ",
    'A Pet Hair Remover Roller efficiently lifts and removes pet hair from surfaces, making clean-up quick and easy.',
    'A Pet Litter Box provides a clean and convenient space for your pet’s bathroom needs. ',
  ];

  List<double> accPrice = [
    349.99,
    299.50,
    99.99,
  ];

  final ScrollController _scrollController = ScrollController();
  bool _showToTopButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= 300) {
      setState(() {
        _showToTopButton = true;
      });
    } else {
      setState(() {
        _showToTopButton = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Accessories',
            style: TextStyle(
              color: Colors.brown,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications),
            iconSize: 35,
            onPressed: () {
              //Handle searched data
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Stack(
          children: [
            GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              // Number of Cards
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                // Card color
                Color cardColor;
                if (index == 0) {
                  cardColor =
                      Color.fromARGB(255, 244, 243, 243); // First index (white)
                } else if ((index - 1) % 4 < 2) {
                  cardColor = Color.fromARGB(255, 207, 184,
                      153); // Brown color at index number 2, 3, 6, 7, 10, ...
                } else {
                  cardColor = Color.fromARGB(255, 244, 243,
                      243); // White color at index number 4, 5, 8, 9, 12, ...
                }
                return GestureDetector(
                  onTap: () {
                    _showPopupScreen(context, index);
                    print('Card tapped: $index');
                  },
                  child: Card(
                    color: cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 3,
                                color: Color.fromARGB(255, 193, 190, 190),
                              ),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: AssetImage(
                                  accImages[index % accImages.length],
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child:
                                null, // You can add additional content here if needed
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 8,
                              bottom: 8,
                              left: 10,
                              right: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  accNames[index % accNames.length],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '₱ ${accPrice[index % accPrice.length].toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Add more pet details as needed
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
            Positioned(
              bottom: 20,
              right: 20,
              child: _showToTopButton
                  ? FloatingActionButton(
                      onPressed: _scrollToTop,
                      child: Icon(Icons.arrow_upward),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupScreen(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 193, 190, 190),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                          accImages[index % accImages.length],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: null,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 8,
                      left: 10,
                      right: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          accNames[index % accNames.length],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Item Description',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          width: double
                              .infinity, // Set a fixed height for the container
                          child: SingleChildScrollView(
                            child: Text(
                              accDescriptions[index % accDescriptions.length],
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  border: TableBorder.symmetric(),
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                            child: PopupMenuButton<String>(
                              child: Text(
                                'Sizes\nAvailable',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 11,
                                ),
                              ),
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  child: Text(
                                    'Stocks Available',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'XS',
                                  child: Text(
                                    'XS (${getAvailableStackCount('XS', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'S',
                                  child: Text(
                                    'S (${getAvailableStackCount('S', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'M',
                                  child: Text(
                                    'M (${getAvailableStackCount('M', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'L:',
                                  child: Text(
                                    'L (${getAvailableStackCount('L', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'XL',
                                  child: Text(
                                    'XL (${getAvailableStackCount('XL', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'XXL',
                                  child: Text(
                                    'XXL (${getAvailableStackCount('XXL', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                              ],
                              onSelected: (String size) {
                                // Handle the selection
                                print('Selected size: $size');
                              },
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                print('pressed');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MapScreen(
                                            Loc: locationLatLng[
                                                index % locationLatLng.length],
                                          )),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: const Text(
                                  'Add to\nCart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           ProfileScreen(widget.userID)), // Pass datas here
                                // );
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: const Text(
                                  'Store\nDetails',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SizeAvailability {
  final String size;
  final int availableStackCount;

  SizeAvailability(this.size, this.availableStackCount);
}

int getAvailableStackCount(
    String size, List<SizeAvailability> sizeAvailabilities) {
  for (var availability in sizeAvailabilities) {
    if (availability.size == size) {
      return availability.availableStackCount;
    }
  }
  return 0;
}
