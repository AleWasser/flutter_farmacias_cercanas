import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final String title;
  final Map<String, dynamic> location;

  MapScreen({
    @required this.title,
    @required this.location,
  });

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location["lat"],
            widget.location["lng"],
          ),
          zoom: 16,
        ),
        markers: {
          Marker(
            markerId: MarkerId('m1'),
            position: LatLng(
              widget.location["lat"],
              widget.location["lng"],
            ),
          ),
        },
      ),
    );
  }
}
