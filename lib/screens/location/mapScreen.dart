import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:veterinary_app/util/placeLocation.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
        latitude: 9.746922,
        longitude: 79.970594,
        address: ''
    ),
    this.isSelecting = true,
  });
  
  final PlaceLocation location;
  final bool isSelecting;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting? 'Pick Your Location' : 'Your Location'),
        actions: [
          if(widget.isSelecting)
            IconButton(
                onPressed: (){
                  Navigator.of(context).pop(_pickedLocation);
                },
                icon: const Icon(Icons.save),
            )
        ],
      ),
      body: GoogleMap(
        onTap: !widget.isSelecting? null : (position){
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude
          ),
          zoom: 16,
        ),
        markers: (_pickedLocation == null && widget.isSelecting == true)?{} : {
          Marker(
            markerId: const MarkerId("m1"),
            position: _pickedLocation?? LatLng(
              widget.location.latitude,
              widget.location.longitude,
            )
          )
        },
      ),
    );
  }
}
