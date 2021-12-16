import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerDemo extends StatefulWidget {
  @override
  _MarkerDemoState createState() => _MarkerDemoState();
}

class _MarkerDemoState extends State<MarkerDemo> {
  //
  final LatLng ytlLocation = LatLng(20.3899, 78.1307);
  BitmapDescriptor? customMarker;

  //
  @override
  void initState() {
    super.initState();

    getCustomMarker();
  }

  Future<void> getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(),
      'images/marker2.png',
    );

    setState(() {
      //
    });
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        title: Text('Marker Demo'),
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: ytlLocation,
          zoom: 15,
        ),

        //
        markers: {
          //
          Marker(
            markerId: MarkerId('marker1'),
            position: ytlLocation,
            infoWindow: InfoWindow(
              title: 'Yavatmal',
              snippet: 'This is the cotton city',
            ),

            icon: customMarker == null
                ? BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue)
                : customMarker!,

            // icon: BitmapDescriptor.defaultMarkerWithHue(
            //   BitmapDescriptor.hueViolet,
            // ),

            // draggable: true,
            // onTap: () {
            //   //
            // },

            // //
            // onDragEnd: (LatLng newPosition) {
            //   //
            // },

            // //
            // onDragStart: (LatLng newPosition) {
            //   //
            // },

            // onDrag: (LatLng newPosition) {
            //   //
            // },
          ),
        },
      ),
    );
  }
}
