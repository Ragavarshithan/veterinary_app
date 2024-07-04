import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veterinary_app/screens/doctor/model.dart';
import 'package:veterinary_app/screens/location/mapScreen.dart';

class DoctorDetailsScreen extends StatelessWidget{
  const DoctorDetailsScreen({super.key,required this.doctor});

  final Doctor doctor;

  String get locationImage {
    final lat = doctor.location.latitude;
    final lng = doctor.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=16&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDOaKsCi6IFVYNIm_1QvbkJ01JDW8cZ4OU';
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          title: Text(doctor.doctorName),
        ),
        body: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MapScreen(
                                location: doctor.location,
                                isSelecting: false,
                              ),
                            )
                        );
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage(locationImage),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black54
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                      child: Text(
                          doctor.location.address,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface)),
                    )
                  ],
                )
            )
          ],
        )
    );
  }
}