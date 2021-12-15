import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDemo extends StatefulWidget {
  @override
  _MapDemoState createState() => _MapDemoState();
}

class _MapDemoState extends State<MapDemo> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(title: Text('Map Demo')),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937, 78.9629),
          zoom: 10,
          bearing: 0,
          tilt: 90,
        ),

        //
        mapType: MapType.normal,

        //
        compassEnabled: true,

        //
        zoomControlsEnabled: false,
      ),
    );
  }
}
