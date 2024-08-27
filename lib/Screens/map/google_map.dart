import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  MapScreen({super.key, required this.Loc});

  final LatLng Loc;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  late LatLng location;

//  LatLng = _center
//   // static const LatLng _center = const LatLng(14.068900, 121.32903);
//   _center =  widget.Loc ?? null;
  late Set<Marker> _markers = {
    Marker(
      markerId: MarkerId('SanPablo'),
      position: widget.Loc,
      infoWindow: InfoWindow(
        title: 'Pet Lovers Boulevard Pet Store',
        snippet: 'malapit lang to',
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
    location = widget.Loc;
  }

  Future<void> _requestLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();
    if (status != PermissionStatus.granted) {
      // Handle the scenario where the user denies the permission request.
      // You can display a message or take any other appropriate action.
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: widget.Loc,
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
