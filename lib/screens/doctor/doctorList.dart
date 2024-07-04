import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veterinary_app/screens/doctor/model.dart';
import 'package:veterinary_app/screens/doctor/viewDoctorDetails.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key, required this.doctor});
  final List<Doctor> doctor;

  @override
  Widget build(BuildContext context) {
    if(doctor.isEmpty){
      return const Center(
        child: Text("No Doctor Added Yet"),
      );
    }
    return ListView.builder(
        itemCount: doctor.length,
        itemBuilder:(ctx,index) => ListTile(
          title: Text(doctor[index].doctorName, style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface
          ),
        ),
      subtitle: Text(doctor[index].location.address,style: Theme.of(context).textTheme.bodySmall!.copyWith(
    color: Theme.of(context).colorScheme.onSurface),
    ),
    onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> DoctorDetailsScreen(doctor: doctor[index]),
            ),
            );
    },
        ),
    );
  }
}
