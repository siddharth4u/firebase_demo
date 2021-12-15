/*
Dependency
------------
google_maps_flutter


Step for Writing App
------------------------
1) Create the new App
2) Add the Dependency  'google_maps_flutter'
3) Create firebase project & connect your app to it
4) Create Map API key through google developer console & add it to manifest file   
    https://console.developers.google.com
5) Enable Maps SDK for Android through google developer console


Important classe in google_maps_flutter
---------------------------------------
1) GoogleMap
2) GoogleMapController
3) LatLng
4) CameraPosition
5) CameraUpdate
6) Marker
7) InfoWindow
8) Circle
9) Polyline
10) Polygon
11) BitmapDiscriptor

*/

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
