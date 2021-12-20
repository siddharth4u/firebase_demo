import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LiveLocation extends StatefulWidget {
  @override
  _LiveLocationState createState() => _LiveLocationState();
}

class _LiveLocationState extends State<LiveLocation> {
  //
  final LatLng initialPostion = LatLng(20.5937, 78.9629);
  late GoogleMapController mapController;
  Marker? liveLocationMarker;
  var positionStream;

  //
  @override
  void initState() {
    super.initState();
  }

  //
  @override
  void dispose() {
    super.dispose();
    positionStream.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //
      appBar: AppBar(
        //
        title: Text('Live Location'),

        //
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              showLiveLocation();
            },
          ),
        ],
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: initialPostion,
          zoom: 5,
        ),

        //
        markers: {
          if (liveLocationMarker != null) liveLocationMarker!,
        },

        //
        onMapCreated: (GoogleMapController mapController) {
          this.mapController = mapController;
        },
      ),
    );
  }

  Future<void> showLiveLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isServiceEnabled) {
      Geolocator.requestPermission();
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
    }

    // get Current Location and place marker at this postion
    Position currenPostion = await Geolocator.getCurrentPosition(
        //  desiredAccuracy: LocationAccuracy.high,
        );

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currenPostion.latitude,
            currenPostion.longitude,
          ),
          zoom: 21,
        ),
      ),
    );

    liveLocationMarker = Marker(
      markerId: MarkerId('liveLocationMarker'),
      position: LatLng(
        currenPostion.latitude,
        currenPostion.longitude,
      ),
    );

    setState(() {
      //
    });

    // listen for change in location
    positionStream =
        Geolocator.getPositionStream().listen((Position newPosition) {
      print('You moved : $newPosition');
      //
      liveLocationMarker = Marker(
        markerId: MarkerId('liveLocationMarker'),
        position: LatLng(
          newPosition.latitude,
          newPosition.longitude,
        ),
      );

      setState(() {
        //
      });
    });
  }
}
