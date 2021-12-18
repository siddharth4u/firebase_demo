import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CircleDemo extends StatefulWidget {
  @override
  _CircleDemoState createState() => _CircleDemoState();
}

class _CircleDemoState extends State<CircleDemo> {
  //
  final LatLng ytlLocation = LatLng(20.3899, 78.1307);
  final Set<Circle> circleSet = {};

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Circle Demo'),
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: ytlLocation,
          zoom: 16,
        ),

        //
        onLongPress: placeCircle,

        //
        circles: circleSet,

        //{
        // show the single circle at begining
        //------------------------------------------
        // Circle(
        //   circleId: CircleId('circle1'),
        //   center: ytlLocation,
        //   radius: 50,
        //   fillColor: Colors.green.withOpacity(0.25),
        //   strokeColor: Colors.green,
        //   strokeWidth: 2,
        // ),
        //},
      ),
    );
  }

  void placeCircle(LatLng postion) {
    // create Circle object
    Circle circle = Circle(
      circleId: CircleId('${circleSet.length}'),
      center: postion,
      radius: 50,
    );

    // add circle object to circleSet
    circleSet.add(circle);

    

    // refresh the UI
    setState(() {
      //
    });
  }
}
