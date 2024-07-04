import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:veterinary_app/screens/client/model.dart';
import 'package:veterinary_app/screens/doctor/model.dart';
import 'package:veterinary_app/screens/location/mapScreen.dart';
import 'package:veterinary_app/util/distanceCal.dart';

class ClientDetailsScreen extends StatefulWidget {
  const ClientDetailsScreen({super.key, required this.client, required this.doctors});

  final Client client;
  final List<Doctor> doctors;

  @override
  _ClientDetailsScreenState createState() => _ClientDetailsScreenState();
}

class _ClientDetailsScreenState extends State<ClientDetailsScreen> {
  List<Doctor>? _nearByDoctors;

  String get locationImage {
    final lat = widget.client.location.latitude;
    final lng = widget.client.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDOaKsCi6IFVYNIm_1QvbkJ01JDW8cZ4OU';
  }

  Future<void> _searchNearbyDoctors() async {
    List<Doctor> nearbyDoctors = [];
    for (var doctor in widget.doctors) {
      double distance = await calculateDistance(
        widget.client.location.latitude,
        widget.client.location.longitude,
        doctor.location.latitude,
        doctor.location.longitude,
        'AIzaSyDOaKsCi6IFVYNIm_1QvbkJ01JDW8cZ4OU',
      );
      if (distance <= 2000) { // 5 km radius
        nearbyDoctors.add(doctor);
      }
    }
    setState(() {
      _nearByDoctors = nearbyDoctors;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.client.clientName),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    location: widget.client.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(locationImage),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Text(
              widget.client.location.address,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton.icon(
            icon: const Icon(Icons.search),
            label: const Text("Search nearby Doctor"),
            onPressed: _searchNearbyDoctors,
          ),
          if (_nearByDoctors != null) ...[
            const SizedBox(height: 10),
            const Text('Nearby Doctors:', style: TextStyle(fontSize: 18)),
            Expanded(
              child: ListView.builder(
                itemCount: _nearByDoctors!.length,
                itemBuilder: (ctx, index) {
                  final doctor = _nearByDoctors![index];
                  return ListTile(
                    title: Text(doctor.doctorName),
                    subtitle: FutureBuilder<double>(
                      future: calculateDistance(
                        widget.client.location.latitude,
                        widget.client.location.longitude,
                        doctor.location.latitude,
                        doctor.location.longitude,
                        'AIzaSyDOaKsCi6IFVYNIm_1QvbkJ01JDW8cZ4OU',
                      ),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text('Calculating distance...');
                        } else if (snapshot.hasError) {
                          return const Text('Error calculating distance');
                        } else {
                          return Text('Distance: ${(snapshot.data! / 1000).toStringAsFixed(2)} km');
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
