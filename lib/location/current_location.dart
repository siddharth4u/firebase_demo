import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocation extends StatefulWidget {
  @override
  _CurrentLocationState createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  //
  final LatLng initialLocation = LatLng(20.5937, 78.9629);
  late GoogleMapController mapController;
  Marker? currentLocationMarker;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        //
        title: Text('Current Location'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              gotoCurrentLocation();
            },
          ),
        ],
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: initialLocation,
          zoom: 5,
        ),

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },

        //
        markers: {if (currentLocationMarker != null) currentLocationMarker!},
      ),
    );
  }

  //
  Future<void> gotoCurrentLocation() async {
    // check location service is eanbled
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      print('Device has no location service');
      Geolocator.requestPermission();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    Position currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 20,
        ),
      ),
    );

    currentLocationMarker = Marker(
      markerId: MarkerId('my_location'),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
    );

    setState(() {
      //
    });
  }
}
