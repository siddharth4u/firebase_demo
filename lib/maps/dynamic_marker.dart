import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DynamicMarker extends StatefulWidget {
  @override
  _DynamicMarkerState createState() => _DynamicMarkerState();
}

class _DynamicMarkerState extends State<DynamicMarker> {
  //
  final LatLng ytlLocation = LatLng(20.3899, 78.1307);
  final Set<Marker> markers = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController snnipetController = TextEditingController();
  final CollectionReference markersCollection =
      FirebaseFirestore.instance.collection('markers');

  //
  @override
  void initState() {
    super.initState();

    placeMarkersFromFirebase();
  }

  //
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    snnipetController.dispose();
  }

  //
  Future<void> placeMarkersFromFirebase() async {
    QuerySnapshot rawData = await markersCollection.get();
    List<DocumentSnapshot> markerList = rawData.docs;

    for (int i = 0; i < markerList.length; i++) {
      print(markerList[i].id);
      //
      Marker marker = Marker(
        markerId: MarkerId('${markerList[i].id}'),
        position: LatLng(markerList[i]['location'].latitude,
            markerList[i]['location'].longitude),
        infoWindow: InfoWindow(
          title: '${markerList[i]['title']}',
          snippet: '${markerList[i]['snippet']}',
        ),
      );

      //
      markers.add(marker);
    }

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
        title: Text('Dynamic Marker'),
      ),

      //
      body: GoogleMap(
        //
        initialCameraPosition: CameraPosition(
          target: ytlLocation,
          zoom: 18,
        ),

        //
        markers: markers,

        //
        onLongPress: (LatLng postion) {
          createMarker(postion);
        },
      ),
    );
  }

  //
  Future<void> createMarker(LatLng postion) async {
    // get marker through bottomsheet
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            height: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Marker Title',
                  ),
                ),

                SizedBox(height: 16),

                //
                TextField(
                  controller: snnipetController,
                  decoration: InputDecoration(
                    hintText: 'Marker Descreption',
                  ),
                ),

                SizedBox(height: 16),

                //
                ElevatedButton(
                  child: Text('Add Marker'),
                  onPressed: () async {
                    //
                    DocumentReference documentReference =
                        await markersCollection.add({
                      'location': '',
                    });

                    Marker marker = Marker(
                      markerId: MarkerId('${documentReference.id}'),
                      position: postion,
                      infoWindow: InfoWindow(
                        title: titleController.text,
                        snippet: snnipetController.text,
                      ),
                    );

                    await markersCollection.doc(documentReference.id).set({
                      'location': GeoPoint(postion.latitude, postion.longitude),
                      'title': titleController.text,
                      'snippet': snnipetController.text,
                    });

                    markers.add(marker);

                    titleController.clear();
                    snnipetController.clear();

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    setState(() {
      //
    });
  }
}
