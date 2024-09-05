// ignore_for_file: library_private_types_in_public_api, unused_local_variable, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pawprojui/Screens/petscreens/petaccessories.dart';
import '../login/login.dart';
import '../dashboard/mydashboard.dart';
import '../map/google_map.dart';
import '../map/petclinicsmaps.dart';
import '../user/profile.dart';
import 'contactus.dart';

class PetsFeedsPage extends StatefulWidget {
  final int userID;

  PetsFeedsPage({required this.userID});
  @override
  _PetsFeedsPageState createState() => _PetsFeedsPageState();
}

const String userImage = 'assets/kitz.jpg';
const String name = 'Kitzie123';
const String petImage = 'assets/dog001.jpg';

class _PetsFeedsPageState extends State<PetsFeedsPage> {
  late List<dynamic> datas = [];

  List<String> feedsImages = [
    'assets/feeds/feedpup.jpg',
    'assets/feeds/feedkit.jpg',
    'assets/feeds/feeddog.jpeg',
    'assets/feeds/feedcat.jpeg',
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
    SizeAvailability('', 10),
    SizeAvailability('S', 15),
    SizeAvailability('M', 20),
    SizeAvailability('L', 25),
    SizeAvailability('XL', 18),
    SizeAvailability('XXL', 12),
  ];

  List<String> feedsNames = [
    'Pedigree Pup',
    'Royal Canin Kitten',
    'Top Breed',
    'Sea Food',
  ];

  List<String> feedsDescriptions = [
    'A Pedigree Pup is a purebred puppy with a documented lineage, ensuring high quality and breed standards. Ideal for dog lovers, it boasts excellent traits and distinctive characteristics.',
    'Royal Canin is a global leader in tailored pet nutrition, renowned for its commitment to providing precise, breed-specific formulas to meet the unique dietary needs of cats and dogs. Founded in France in 1968 by veterinary surgeon Dr. Jean Cathary, the brand has since expanded its reach worldwide, earning the trust of pet owners and professionals alike. Central to Royal Canins philosophy is the belief that every pet is unique, with distinct nutritional requirements based on factors such as age, breed, size, and specific health concerns.One of the key pillars of Royal Canins success lies in its extensive research and development efforts. The company collaborates with veterinarians, nutritionists, and other experts to continually innovate and refine its product offerings. This dedication to scientific advancement ensures that Royal Canin formulas are not only palatable but also highly effective in supporting pets` overall health and well-being. From specialized diets for sensitive stomachs to formulas designed to promote joint health or dental care, Royal Canin offers a comprehensive range of options to address a variety of pet health concerns. Royal Canin`s commitment to quality extends beyond its product formulations to encompass sustainability and responsible sourcing practices. The company places a strong emphasis on ethical sourcing of ingredients, ensuring that every component of its pet foods meets rigorous standards for safety and nutritional value. Additionally, Royal Canin prioritizes environmental sustainability throughout its operations, striving to minimize its ecological footprint and contribute to a healthier planet for future generations. Beyond its dedication to providing superior nutrition, Royal Canin also plays an active role in promoting pet welfare and education. Through partnerships with animal shelters, veterinary schools, and advocacy organizations, the company works to raise awareness about responsible pet ownership and the importance of proper nutrition in supporting pets` health and longevity. By combining scientific expertise with a genuine passion for pets, Royal Canin continues to set the standard for excellence in the pet food industry, enriching the lives of cats and dogs around the world.',
    'A Top Breed represents the pinnacle of canine excellence, known for its exceptional traits, health, and performance.',
    'Sea Food for cats and dogs includes nutrient-rich fish and shellfish treats designed to support a healthy coat and provide essential vitamins and minerals.',
  ];

  List<double> feedsPrice = [
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
            'Pet Foods',
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
              // Handle notification button press
            },
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: PopupMenuButton(
                    icon: const Icon(Icons.filter_list),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry>[
                        const PopupMenuItem(
                          child: Text('Php 0-100'),
                          value: 'Filter1',
                        ),
                        const PopupMenuItem(
                          child: Text('Php 101-500'),
                          value: 'Filter2',
                        ),
                        const PopupMenuItem(
                          child: Text('Php 500 and above'),
                          value: 'Filter3',
                        ),
                        // const PopupMenuItem(
                        //     child: Text('Php 701-1000'),
                        //     value: 'Filter4'),
                      ];
                    },
                    onSelected: (value) {
                      print('Selected Filter: $value');
                    },
                  ),
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
              itemCount: 20, // Number of Cards
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
                                  feedsImages[index % feedsImages.length],
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
                                  feedsNames[index % feedsNames.length],
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
                                      '₱ ' +
                                          feedsPrice[index % feedsPrice.length]
                                              .toStringAsFixed(2),
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
                          feedsImages[index % feedsImages.length],
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
                          feedsNames[index % feedsNames.length],
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
                              feedsDescriptions[
                                  index % feedsDescriptions.length],
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
                                'Stocks\nAvailable',
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
                                    '250g (${getAvailableStackCount('XS', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'S',
                                  child: Text(
                                    '500g (${getAvailableStackCount('S', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'M',
                                  child: Text(
                                    '1kg (${getAvailableStackCount('M', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'L:',
                                  child: Text(
                                    '5kg (${getAvailableStackCount('L', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'XL',
                                  child: Text(
                                    '10Kg (${getAvailableStackCount('XL', sizeAvailabilities)} pcs)',
                                  ),
                                ),
                                PopupMenuItem<String>(
                                  value: 'XXL',
                                  child: Text(
                                    '20Kg (${getAvailableStackCount('XXL', sizeAvailabilities)} pcs)',
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
                                  'Seee\nLocation',
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
