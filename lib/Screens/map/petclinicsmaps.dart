// ignore_for_file: unused_field, unnecessary_null_comparison

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart'; //+

class MapsPetClinics extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapsPetClinics> {
  Completer<GoogleMapController> _controller = Completer();
  late Position _currentPosition; // Variable to store current position
  bool _isLocationEnabled =
      false; // Flag to track if location permission is granted

  static const LatLng _center = LatLng(14.068900, 121.32903);

  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle the scenario where the user denies the permission request.
      // You can display a message or take any other appropriate action.
    } else {
      setState(() {
        _isLocationEnabled = true; // Location permission granted
      });
      _getCurrentLocation(); // Get current location if permission is granted
      _getPetClinicsNearby(); // Fetch pet clinics nearby
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position; // Store current position
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _getPetClinicsNearby() {
    // Simulated list of pet clinics, replace this with actual data from API
    List<PetClinic> petClinics = [
      PetClinic(
        name: 'Pet Clinic 1',
        lat: 14.069100,
        lng: 121.32913,
      ),
      PetClinic(
        name: 'Pet Clinic 2',
        lat: 14.068800,
        lng: 121.32892,
      ),
      // Add more pet clinics as needed
    ];

    Set<Marker> markers = {};

    for (var clinic in petClinics) {
      markers.add(
        Marker(
          markerId: MarkerId(clinic.name),
          position: LatLng(clinic.lat, clinic.lng),
          infoWindow: InfoWindow(
            title: clinic.name,
            snippet: 'Pet Clinic',
          ),
        ),
      );
    }

    setState(() {
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _currentPosition != null
                ? CameraPosition(
                    target: LatLng(
                        _currentPosition.latitude, _currentPosition.longitude),
                    zoom: 16.0,
                  )
                : CameraPosition(
                    target: _center,
                    zoom: 16.0,
                  ),
            markers: _markers,
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PetClinic {
  final String name;
  final double lat;
  final double lng;

  PetClinic({required this.name, required this.lat, required this.lng});
}
