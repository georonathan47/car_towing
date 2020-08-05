import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TorerMap extends StatefulWidget {
  TorerMap(
      {this.toreLocation,
      this.height,
      this.width,
      this.isNotExitable = false});
  final LatLng toreLocation;
  final double height;
  final double width;
  final bool isNotExitable;
  @override
  _TorerMapState createState() => _TorerMapState();
}

class _TorerMapState extends State<TorerMap> {
  LatLng currentToreLocation;
  GoogleMapController controller;
  List<Marker> marker = [];
  LatLng location;

  onDonorMapCreated(
      GoogleMapController controller, LatLng donorLocation) async {
    this.controller = controller;
    currentToreLocation =
        LatLng(donorLocation.latitude, donorLocation.longitude);
    print(currentToreLocation);
    setState(() {
      marker.add(
        Marker(
            markerId: MarkerId("Mylocation"),
            position: currentToreLocation,
            draggable: true,
            onTap: () {
              print("tapped");
            },
            consumeTapEvents: true,
            infoWindow: InfoWindow(title: "Your location")),
      );
    });

    controller
        .animateCamera(CameraUpdate.newLatLngZoom(currentToreLocation, 15));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      location = widget.toreLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(),
        child: GoogleMap(
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            ].toSet(),
            onMapCreated: (controller) =>
                onDonorMapCreated(controller, location),
            initialCameraPosition: CameraPosition(
              target: LatLng(0, 0),
              zoom: 6,
            ),
            markers: Set<Marker>.of(marker)),
      ),
      widget.isNotExitable
          ? SizedBox(width: 0.0, height: 0.0)
          : IconButton(
              icon: Icon(Icons.close, color: Colors.red),
              onPressed: () => Navigator.pop(context)),
    ]);
  }
}
