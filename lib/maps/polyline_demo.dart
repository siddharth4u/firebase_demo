import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineDemo extends StatefulWidget {
  @override
  _PolylineDemoState createState() => _PolylineDemoState();
}

class _PolylineDemoState extends State<PolylineDemo> {
  //
  final LatLng ytlLocation = LatLng(20.3899, 78.1307);
  List<LatLng> pointsOverLine = [];
  late Polyline polyline;

  //
  @override
  void initState() {
    super.initState();

    //
    polyline = Polyline(
      polylineId: PolylineId('line1'),
      points: pointsOverLine,
      color: Colors.blue,
      width: 5,
    );
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Polyline Demo'),
      ),

      //
      body: GoogleMap(
          //
          initialCameraPosition: CameraPosition(
            target: ytlLocation,
            zoom: 16,
          ),

          //
          onLongPress: addPointToLine,

          //
          polylines: {
            polyline,
          }
          // single line demo
          // {
          //   Polyline(
          //     polylineId: PolylineId('line1'),
          //     width: 20,
          //     color: Colors.orange,
          //     points: [
          //       LatLng(20.3899, 78.1307),
          //       LatLng(20.3942, 78.1419),
          //       LatLng(20.3721, 78.1315),
          //     ],
          //   ),
          // },
          ),
    );
  }

  void addPointToLine(LatLng position) {
    pointsOverLine.add(position);

    //
    setState(() {
      //
    });
  }
}
