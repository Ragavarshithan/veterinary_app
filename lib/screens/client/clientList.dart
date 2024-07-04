import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veterinary_app/screens/client/model.dart';
import 'package:veterinary_app/screens/client/viewClientDetails.dart';
import 'package:veterinary_app/screens/doctor/model.dart';
import 'package:veterinary_app/screens/doctor/viewDoctorDetails.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key, required this.client, required this.doctors});
  final List<Client> client;
  final List<Doctor> doctors;

  @override
  Widget build(BuildContext context) {
    if(client.isEmpty){
      return const Center(
        child: Text("No Client Added Yet"),
      );
    }
    return ListView.builder(
      itemCount: client.length,
      itemBuilder:(ctx,index) => ListTile(
        title: Text(client[index].clientName, style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface
        ),
        ),
        subtitle: Text(client[index].location.address,style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Theme.of(context).colorScheme.onSurface),
        ),
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ClientDetailsScreen(client: client[index], doctors: doctors,),
          ),
          );
        },
      ),
    );
  }
}
