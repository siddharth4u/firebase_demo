import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ControllerDemo extends StatefulWidget {
  @override
  _ControllerDemoState createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo> {
  //
  final LatLng newDelhiLocation = LatLng(28.6139, 77.2090);
  final LatLng hyderabadLocation = LatLng(17.3850, 78.4867);
  late GoogleMapController mapController;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),

        //
        actions: [
          //
          TextButton(
            child: Text(
              'Delhi',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              changeLocation(newDelhiLocation);
            },
          ),

          //
          TextButton(
            child: Text(
              'Hyderabad',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              changeLocation(hyderabadLocation);
            },
          ),
        ],
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: newDelhiLocation,
          zoom: 15,
        ),

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },
      ),
    );
  }

  //
  void changeLocation(LatLng newLocation) async {
    await mapController.animateCamera(
      CameraUpdate.newLatLng(newLocation),
    );

    setState(() {
      //
    });
  }
}
