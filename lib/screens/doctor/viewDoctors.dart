import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veterinary_app/screens/doctor/addDoctor.dart';
import 'package:veterinary_app/screens/doctor/doctorList.dart';
import 'package:veterinary_app/util/userDetails.dart';

class ViewDoctorsScreen extends ConsumerStatefulWidget{
  const ViewDoctorsScreen({super.key});

  @override
  ConsumerState<ViewDoctorsScreen> createState(){
    return _viewDoctorsScreenState();
  }

}

class _viewDoctorsScreenState extends ConsumerState<ViewDoctorsScreen>{

  late Future<void> _doctorFuture;

  @override
  void initState() {
    super.initState();
    _doctorFuture = ref.read(doctorProvider.notifier).loadDoctors();
  }
  @override
  Widget build(BuildContext context){
    final doctorInfo = ref.watch(doctorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx)=> const AddDoctorScreen(),
                    )
                );
              },
              icon: const Icon(Icons.add)
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: _doctorFuture,
              builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : DoctorList(
                doctor: doctorInfo,
              )
          )
      ),
    );
  }
}