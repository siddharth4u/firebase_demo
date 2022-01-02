import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GetLocation extends StatefulWidget {
  @override
  _GetLocationState createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  //
  final TextEditingController addressController = TextEditingController();
  final LatLng initialLatLng = LatLng(20.5937, 78.9629);
  late GoogleMapController mapController;
  Marker? locationMarker;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1
      appBar: AppBar(
        title: TextField(
          controller: addressController,
          decoration: InputDecoration(hintText: 'Address'),
        ),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              jumpToAddress();
            },
          ),
        ],
      ),

      // 2
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: initialLatLng,
          zoom: 4,
        ),

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },

        //
        markers: {
          if (locationMarker != null) locationMarker!,
        },

        //
        onLongPress: showAddress,
      ),
    );
  }

  //
  void jumpToAddress() async {
    if (addressController.text.isNotEmpty) {
      List<Location> locations =
          await locationFromAddress(addressController.text);

      if (locations.length > 0) {
        LatLng newPostion =
            LatLng(locations[0].latitude, locations[0].longitude);

        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: newPostion,
              zoom: 18,
            ),
          ),
        );

        locationMarker = Marker(
          markerId: MarkerId('newLocation'),
          position: newPostion,
        );

        setState(() {
          //
        });
      }
    }
  }

  void showAddress(LatLng postion) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(postion.latitude, postion.longitude);

    if (placemarks.length > 0) {
      print(placemarks[0]);
    }
  }
}
