import 'package:flutter/material.dart';
import 'package:pawprojui/petCare/cat/c_diet.dart';
import 'package:pawprojui/petCare/cat/c_grooming.dart';
import 'package:pawprojui/petCare/cat/c_indoor.dart';
import 'package:pawprojui/petCare/cat/c_litter.dart';
import 'package:pawprojui/petCare/cat/c_love.dart';
import 'package:pawprojui/petCare/cat/c_monitor.dart';
import 'package:pawprojui/petCare/cat/c_play.dart';
import 'package:pawprojui/petCare/cat/c_safety.dart';
import 'package:pawprojui/petCare/cat/c_vet.dart';

import 'dog/d_attention.dart';
import 'dog/d_diet.dart';
import 'dog/d_environment.dart';
import 'dog/d_exercise.dart';
import 'dog/d_grooming.dart';
import 'dog/d_mental.dart';
import 'dog/d_monitor.dart';
import 'dog/d_ownership.dart';
import 'dog/d_training.dart';
import 'dog/d_veterinary.dart';

class PetCarePage extends StatefulWidget {
  @override
  _PetCarePageState createState() => _PetCarePageState();
}

class _PetCarePageState extends State<PetCarePage> {
  int _selectedTabIndex = 0; // Track the selected tab index

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 90),
                    child: Text(
                      'PET CARE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to previous screen
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/design1/pinkbg.png',
              fit: BoxFit.cover, // Ensures the image covers the entire background
            ),
          ),
          // Main content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tab bar at the top
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTabItem('DOG', 0, screenWidth),
                        _buildTabItem('CAT', 1, screenWidth),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Conditional content based on selected tab
                  _selectedTabIndex == 0 ? _buildDogContent() : _buildCatContent(),
                  const SizedBox(height: 20),
                  // Other content widgets...
                ],
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: const EdgeInsets.all(20.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         // Tab bar at the top
      //         SingleChildScrollView(
      //           scrollDirection: Axis.horizontal,
      //           child: Row(
      //             children: [
      //               _buildTabItem('DOG', 0, screenWidth),
      //               _buildTabItem('CAT', 1, screenWidth),
      //             ],
      //           ),
      //         ),
      //
      //         const SizedBox(height: 20),
      //
      //         // Conditional content based on selected tab
      //         _selectedTabIndex == 0 ? _buildDogContent() : _buildCatContent(),
      //
      //         const SizedBox(height: 20),
      //
      //         // Other content widgets...
      //       ],
      //     ),
      //   ),
      // ),

    );
  }

  Widget _buildTabItem(String title, int index, double screenWidth) {
    bool isSelected = _selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        width: screenWidth * 0.45,
        decoration: BoxDecoration(
          border: Border(
            // left: BorderSide(
            //   color: Colors.black38,
            // ),
            // right: BorderSide(
            //   color: Colors.black38,
            // //   width: 1.2,
            // ),
            bottom: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            // Handle tab selection by updating the selectedTabIndex
            setState(() {
              _selectedTabIndex = index;
            });
          },
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDogContent() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogDietPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogtreat.png', // Image path
            'Nutritious Diet',
            'Feed your dog high-quality dog food that is appropriate for their age, breed, and size.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogExercisePage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogexercise.png', // Image path
            'Regular Exercise',
            'Dogs need regular exercise to stay healthy and maintain a healthy weight.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogGroomingPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/doggroom.png', // Image path
            'Grooming',
            'Trim nails, clean ears, and brush teeth regularly.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogVeterinaryPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogvet.png', // Image path
            'Veterinary Care',
            'Schedule regular vet check-ups to monitor your dog\'s health.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogTrainingPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogtrain.png', // Image path
            'Training and \nSocialization',
            'Invest time in training your dog using positive reinforcement techniques.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogMentalPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogmental.png', // Image path
            'Provide Mental \nStimulation',
            'Keep your dog mentally engaged with interactive toys, puzzle feeders, or training sessions.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogEnvironmentPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogenvi.png', // Image path
            'Create a Safe \nEnvironment',
            'Dog-proof your home by removing toxic plants, securing hazardous items.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogAttentionPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/doglove.png', // Image path
            'Love and \nAttention',
            'Spend quality time with your dog, offer praise, and show them love and attention regularly.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogMonitorPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogmonitor.png', // Image path
            'Monitor Health \nChanges',
            'Be vigilant for any signs of illness or discomfort.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DogOwnershipPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/dogowner.png', // Image path
            'Responsible \nOwnership',
            'Obey local laws regarding dog ownership, such as licensing and leash regulations.',
          ),
        ),
      ],
    );
  }

  Widget _buildCatContent() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatDietPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/foodcat.png',
            'Nutritional Diet',
            'Provide your cat with a balanced diet suited for feline nutritional needs.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatGroomingPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catgroom.png',
            'Grooming',
            'Regular grooming helps maintain your cat\'s coat and prevents matting.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CatVetPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catvet.png',
            'Veterinary Care',
            'Schedule routine vet check-ups for vaccinations, preventive care, and health assessments.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatLitterPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catlitter.png',
            'Litter Box \nMaintenance',
            'Keep the litter box clean by scooping waste daily and using an appropriate type of litter.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatIndoorPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catsafe.png',
            'Indoor Safety',
            'Remove potential hazards and secure windows and balconies to ensure your cat\'s safety indoors.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatPlayPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catplay.png',
            'Socialization \nand Play',
            'Engage in interactive play sessions and spend quality bonding time with your cat.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatLovePage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catlove.png',
            'Love and \nAttention',
            'Show affection and respect your cat\'s space to strengthen the bond between you.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatMonitorPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/cathealth.png',
            'Monitoring Health',
            'Watch for changes in behavior and promptly address any health concerns with your vet.',
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CatSafetyPage()));
          },
          child: _buildPetCareCard(
            'assets/design1/catiden.png',
            'Identification \nand Safety',
            'Consider microchipping and ensure your cat wears a collar with an ID tag for identification in case they wander off.',
          ),
        ),
        const SizedBox(height: 10),
        // Add more cat-related cards as needed...
      ],
    );
  }

  Widget _buildPetCareCard(String imagePath, String title, String description) {
    return Card(
      elevation: 1.5,
      color: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      height: 115,
                      width: 115,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 83, 79, 79),
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 83, 79, 79),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
