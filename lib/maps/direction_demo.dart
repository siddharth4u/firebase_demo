import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionDemo extends StatefulWidget {
  @override
  _DirectionDemoState createState() => _DirectionDemoState();
}

class _DirectionDemoState extends State<DirectionDemo> {
  //
  final LatLng intiLatLan = LatLng(20.5937, 78.9629);
  LatLng? sourceLatLang, destLatLng;
  Marker? sourceMarker, destMarker;
  Polyline? polylineWIthDirection;

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Direction Demo'),
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: intiLatLan,
          zoom: 16,
        ),

        //
        markers: {
          if (sourceMarker != null) sourceMarker!,
          if (destMarker != null) destMarker!,
        },

        //
        polylines: {
          if (polylineWIthDirection != null) polylineWIthDirection!,
        },

        //
        onLongPress: placeMarker,
      ),
    );
  }

  void placeMarker(LatLng position) async {
    if (sourceMarker != null && destMarker != null) {
      sourceMarker = destMarker = null;
      sourceLatLang = destLatLng = null;
      polylineWIthDirection = null;
    }

    if (sourceMarker == null && destMarker == null) {
      sourceLatLang = position;

      //
      sourceMarker = Marker(
        markerId: MarkerId('SourceMarker'),
        position: position,
        infoWindow: InfoWindow(title: 'Source'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueViolet,
        ),
      );
    } else {
      destLatLng = position;

      //
      destMarker = Marker(
        markerId: MarkerId('DestMarker'),
        position: position,
        infoWindow: InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueGreen,
        ),
      );

      //
      await showDirection();
    }

    setState(() {
      //
    });
  }

  Future<void> showDirection() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();

      PolylineResult polylineResult =
          await polylinePoints.getRouteBetweenCoordinates(
        'API Key',
        PointLatLng(sourceLatLang!.latitude, sourceLatLang!.longitude),
        PointLatLng(destLatLng!.latitude, destLatLng!.longitude),
        travelMode: TravelMode.driving,
      );


      List<PointLatLng> allPoints = polylineResult.points;

      List<LatLng> requiredPoints = [];

      for (int i = 0; i < allPoints.length; i++) {
        requiredPoints.add(
          LatLng(allPoints[i].latitude, allPoints[i].longitude),
        );
      }

      polylineWIthDirection = Polyline(
        polylineId: PolylineId('Direction'),
        points: requiredPoints,
        color: Colors.blue,
        width: 5,
      );
    } catch (error) {
      print(error);
    }
  }
}
