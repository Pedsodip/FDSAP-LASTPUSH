// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, duplicate_import, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use

import 'dart:async';
import 'dart:io' show File, Platform;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:pawprojui/Screens/dashboard/mydashboard.dart';
import 'package:pawprojui/domain.dart';
// import 'dart:html' as html;

class PetUploadPage extends StatefulWidget {
  final int userID;

  const PetUploadPage(this.userID, {super.key});
  @override
  PetUploadState createState() => PetUploadState();
}

class PetUploadState extends State<PetUploadPage> {
  Map<String, List<String>> breedsMap = {
    'Cat': [
      'Persian',
      'Maincoon',
      'Siamese',
      'British Shorthair',
      'ScottishFold'
    ],
    'Dog': [
      'Shihtzu',
      'ScottishFold',
      'GermanShepherd',
      'GoldenRetriever',
      'Bulldog',
      'FrenchBulldog'
    ],
    'Other/s': ['Other'],
  };
  bool isChecked = false;
  int maxLength = 11;
  TextEditingController petID = TextEditingController();
  TextEditingController name = TextEditingController();
  // TextEditingController type = TextEditingController();
  // TextEditingController breed = TextEditingController();
  TextEditingController dateofbirth = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController loc = TextEditingController();

  bool showTextFieldBorderPI = false;
  bool showTextFieldBorderN = false;
  bool showTextFieldBorderB = false;
  bool showTextFieldBorderDOB = false;
  bool showTextFieldBorderW = false;
  bool showTextFieldBorderP = false;
  bool showTextFieldBorderT = false;
  bool showTextFieldBorderG = false;
  bool showTextFieldBorderD = false;

  String message = "";
  bool showWidget = false;

  bool showPrimaryFields = true;
  bool showSecondaryFields = false;

  bool isButtonVisiblenext = true;
  bool isButtonVisiblesignup = false;
  bool enablepassword = true;
  bool enablepassword2 = true;

  get type => null;
  String selectedtype = 'Cat';

  get breed => null;
  String selectedbreed = 'Persian';

  get gender => null;
  String selectedGender = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }



  Future<void> _listingTable(String nameOfPet, String selectedtype, String selectedbreed, String price, String weight, String bday,String gender) async {
    String dateUpload = DateTime.now().toString();
    var url = Uri.parse('http://$domain:8070/addtolist');
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_id": widget.userID,
        "pet_id": 777,
        "date_uploaded": dateUpload,
        "name": nameOfPet,
        "type": selectedtype,
        "breed": selectedbreed,
        "gender": gender,
        "date_of_birth": bday,
        "weight": weight,
        "price": price,
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

  void _checkinput() {
    setState(() {
      bool anyEmpty = false;

      if (name.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderN = true;
      } else {
        showTextFieldBorderN = false;
      }

      if (price.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderP = true;
      } else {
        showTextFieldBorderP = false;
      }

      if (weight.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderW = true;
      } else {
        showTextFieldBorderW = false;
      }

      if (dateofbirth.text.isEmpty) {
        anyEmpty = true;
        showTextFieldBorderDOB = true;
      } else {
        showTextFieldBorderDOB = false;
      }

      if (anyEmpty) {
        message = 'Please fill out all empty fields.';
        showWidget = true;
        return;
      }

      if (selectedGender == '') {
        selectedGender = 'N/A';
      }

      showWidget = false;
      showSecondaryFields = true;
      showPrimaryFields = false;
      isButtonVisiblenext = false;
      isButtonVisiblesignup = true;
    });
  }

  Uint8List? _byteaData;

  // Future<void> _selectImageAndUpload(String seller, String location) async {
  // final picker = ImagePicker();
  // final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //
  // if (pickedFile != null) {
  // final bytes = await pickedFile.readAsBytes();
  // setState(() {
  // _byteaData = Uint8List.fromList(bytes);
  // });
  // _uploadPet(_byteaData.toString(), seller, location);
  // } else {
  // print('No image selected.');
  // }
  // }

  List<Map<String, dynamic>> dataofUser = []; // Store fetched products
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

  File? image;
  final picker = ImagePicker();
  String? _fileName;
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path); // Store the file object
        _fileName = pickedFile.name; // Store the file name
      });
    }
  }

  Future<void> _uploadPet() async {
    int idOfUser = widget.userID;
    String dateUpload = DateTime.now().toString();
    String nameOfPet = name.text;
    String petBday = dateofbirth.text;
    int pricePet = int.parse(price.text); // Ensure this is parsed as int
    String agePet = "1"; // Example static value for age
    String petWeight = weight.text;
    String description = desc.text;
    String location = loc.text;
    var url = Uri.parse('http://10.0.2.2:8080/api/add/pet');

    var request = http.MultipartRequest('POST', url);

    // Add the form fields
    request.fields['UserID'] = idOfUser.toString();
    request.fields['DateUploaded'] = dateUpload;
    request.fields['PetName'] = nameOfPet;
    request.fields['Breed'] = selectedbreed ?? "";
    request.fields['Category'] = selectedtype ?? "";
    request.fields['Cost'] = pricePet.toString();
    request.fields['PetBday'] = petBday;
    request.fields['PetAge'] = agePet;
    request.fields['PetWeight'] = petWeight;
    request.fields['PetGender'] = selectedGender ?? "";
    request.fields['Desc'] = description;
    request.fields['Location'] = location;

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'image',
        image!.path,
        filename: _fileName,
      ));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      print('Pet added successfully: $jsonResponse');
    } else {
      var responseData = await response.stream.bytesToString();
      var jsonResponse = jsonDecode(responseData);
      print('Failed to add pet: $jsonResponse');
    }
  }

// void _uploadPet(String base64Image, String seller, String loc) async {
// int idOfUser = widget.userID;
// String product = 'DOG/CAT';
// String dateUpload = DateTime.now().toString();
// String nameOfPet = name.text;
// String petBday = dateofbirth.text;
// String pricePet = price.text;
// String agePet = "1";
// String petWeight = weight.text;
// String sellerName = seller;
// String description = desc.text;
// String location = loc;
//
// var url = Uri.parse('http://$domain:8070/insertproduct');
// var response = await http.post(
// url,
// headers: {
// "Content-Type": "application/json",
// },
// body: jsonEncode({
// "user_id": idOfUser,
// "product": product,
// "date_uploaded": dateUpload,
// "petname": nameOfPet,
// "breed": selectedbreed,
// "category": selectedtype,
// "cost": pricePet,
// "pet_bday": petBday,
// "pet_age": agePet,
// "pet_weight": petWeight,
// "pet_gender": selectedGender,
// "sellerfullname": sellerName,
// "image_product": base64Image,
// "description": description,
// "pet_Loc": location
// }),
// );
//
// if (response.statusCode == 200) {
// var jsonResponse = jsonDecode(response.body);
// setState(() {
// _listingTable(nameOfPet, selectedbreed, selectedtype, selectedGender, petBday, petWeight, pricePet);
// message = jsonResponse['message'];
// print(message);
// Navigator.pop(context);
// });
// } else if (response.statusCode == 409) {
// // Email or username already exists
// setState(() {
// message = 'Email already exists or in use';
// showWidget = true;
// });
// } else {
// setState(() {
// debugPrint("ERROR" );
// });
// }
// }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (dataofUser.isEmpty) {
      // If dataofUser is empty, display a loading indicator or any placeholder widget
      return Center(child: CircularProgressIndicator());
    } else {
      Map<String, dynamic> userData = dataofUser.first;

      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 207, 184, 153),
          ),
          body: Container(
            color: Color.fromARGB(255, 207, 184, 153),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/design1/brown.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Container(
                    width: screenWidth * 0.87,
                    height: screenHeight * 0.86,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                if (isButtonVisiblenext)
                  Positioned(
                    top: 50,
                    left: screenWidth * 0.1,
                    child: Container(
                      width: 25,
                      height: 25,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/design1/arrow_button.png', // Replace this with your image path
                          width: 10, // Adjust image width
                          height: 10, // Adjust image height
                        ),
                      ),
                    ),
                  ),
                // Label and icon
                Positioned(
                  top: 30,
                  child: Image.asset(
                    'assets/design1/furpaw.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                const Positioned(
                  top: 110,
                  child: Text(
                    'Find an New Home for the Little One',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 153, 133, 93),
                      fontWeight: FontWeight.bold, // Font Weight
                      fontFamily: 'Roboto-Black', // System font
                    ),
                  ),
                ),

                // TextFields
                Positioned(
                  top: 100,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: TextField(
                            controller: name,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              labelText: 'Pet Name',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            value: selectedtype,
                            decoration: InputDecoration(
                              labelText: 'Type',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedtype = newValue!;
                                // Reset selected breed when type changes
                                selectedbreed = breedsMap[selectedtype]![0];
                              });
                            },
                            items: <String>['Cat', 'Dog', 'Other/s']
                                .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            value: selectedbreed,
                            decoration: InputDecoration(
                              labelText: 'Breed',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedbreed = newValue!;
                              });
                            },
                            items: breedsMap[selectedtype]!
                                .map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: TextField(
                            cursorHeight: 20,
                            controller: price,
                            keyboardType: TextInputType
                                .number, // Set the keyboard type to only allow numbers
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  7), // Restrict the input length to 11 characters
                              FilteringTextInputFormatter
                                  .digitsOnly // Restrict input to only digits
                            ],
                            decoration: InputDecoration(
                              labelText: 'Price (₱)',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: TextField(
                            cursorHeight: 20,
                            controller: weight,
                            keyboardType: TextInputType
                                .number, // Set the keyboard type to only allow numbers
                            inputFormatters: <TextInputFormatter>[
                              LengthLimitingTextInputFormatter(
                                  2), // Restrict the input length to 11 characters
                              FilteringTextInputFormatter
                                  .digitsOnly // Restrict input to only digits
                            ],
                            decoration: InputDecoration(
                              labelText: 'Weight (KG)',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  cursorHeight: 20,
                                  controller: dateofbirth,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    labelText: 'Date of Birth',
                                    labelStyle: const TextStyle(
                                      fontSize: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color:
                                        Color.fromARGB(255, 198, 198, 198),
                                        width: 2.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color:
                                        Color.fromARGB(255, 198, 198, 198),
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: showTextFieldBorderDOB
                                            ? Color.fromARGB(255, 255, 132, 132)
                                            : Color.fromARGB(
                                            255, 240, 240, 240),
                                        width: 2.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal:
                                        20), // Padding between text field and icon
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        ///
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1950),
                                          lastDate: DateTime.now(),
                                        ).then((selectedDate) {
                                          if (selectedDate != null) {
                                            //handler
                                            dateofbirth.text =
                                                DateFormat('yyyy/MM/dd')
                                                    .format(selectedDate);
                                          }
                                        });
                                      },
                                      child: Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: const Color.fromARGB(
                                            255, 169, 169, 169),
                                      ),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 135, 132, 127),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: DropdownButtonFormField<String>(
                            value: gender,
                            decoration: InputDecoration(
                              labelText: 'Pet Gender',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedGender = newValue!;
                              });
                            },
                            items: <String>[
                              'Male',
                              'Female',
                              'Prefer Not To Say',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: TextField(
                            controller: desc,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              labelText: 'Description',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: screenWidth * 0.7,
                          height: 40,
                          child: TextField(
                            controller: loc,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                              labelText: 'Location',
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  // color: Color.fromARGB(255, 156, 153, 147),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198), // Set the focused border color
                                  width: 2.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: showTextFieldBorderN
                                      ? Color.fromARGB(255, 255, 132, 132)
                                      : Color.fromARGB(255, 240, 240, 240),
                                  width: 2.0,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 135, 132, 127),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap:
                              _pickImage, // Call image picker when tapped
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color:
                                  const Color.fromARGB(255, 240, 240, 240),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 156, 153, 147),
                                    width: 2.0,
                                  ),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Center the selected image or icon
                                    Center(
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color:
                                        Color.fromARGB(255, 135, 132, 127),
                                        size: 30,
                                      ),
                                    ),

                                    // Position the "Add" icon on the bottom right corner
                                    Positioned(
                                      bottom: 5.0, // Adjust spacing as needed
                                      right: 5.0,
                                      child: Container(
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 2.0, // Space between icon and filename
                            ),

                            // Display filename to the right of the gesture detector
                            if (_fileName != null)
                              SizedBox(
                                width: 150,
                                child: Text(
                                  _fileName!,
                                  overflow:
                                  TextOverflow.ellipsis, // Prevent overflow
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign
                                      .right, // Align text to the right
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  height: 60,
                  width: screenWidth * 0.7,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment
                            .center, // Center the button within the Stack
                        child: Padding(
                          padding: const EdgeInsets.all(
                              3.0), // Add padding to the button
                          child: ElevatedButton(
                            onPressed: () {
                              // _checkinput();
                              _uploadPet();
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 110, 77,
                                    34), // Set the button's background color
                              ),
                              elevation: MaterialStateProperty.all<double>(
                                  0), // Remove button elevation
                            ),
                            child: SizedBox(
                              height: 35,
                              child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 190,
                    left: 70,
                    child: Visibility(
                      visible: showWidget,
                      child: Text(
                        message,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 255, 51, 51),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto-Black',
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      );
    }
  }
}