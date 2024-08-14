import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LatLng _sriLankaCenter = LatLng(7.8731, 80.7718); // Center of Sri Lanka
  final double _zoomLevel = 7.0; // Initial zoom level
  final double _pinZoomLevel = 12.0; // Zoom level when pinning location

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Color.fromARGB(255, 230, 220, 235),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * 0.5, // Responsive height
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _sriLankaCenter,
                zoom: _zoomLevel,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          ),
          SizedBox(height: screenHeight * 0.02), // Responsive spacing
          ElevatedButton(
            onPressed: () {
              _pinLocation();
            },
            child: Text('Pin Location'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015, // Responsive padding
                horizontal: screenWidth * 0.1, // Responsive padding
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          // Add more map-related UI or functionality as needed
        ],
      ),
    );
  }

  void _pinLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _sriLankaCenter,
          zoom: _pinZoomLevel,
        ),
      ),
    );
  }
}
