import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veterinary_app/screens/location/locationInput.dart';
import 'package:veterinary_app/util/placeLocation.dart';
import 'package:veterinary_app/util/userDetails.dart';

class AddDoctorScreen extends ConsumerStatefulWidget{
  const AddDoctorScreen({super.key});

  @override
  ConsumerState<AddDoctorScreen> createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends ConsumerState<AddDoctorScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void savePlace(){
    final enteredTitle = _titleController.text;
    if(enteredTitle.isEmpty || _selectedLocation == null){
      return;
    }
    ref.read(doctorProvider.notifier).addDoctor(enteredTitle, _selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose(){
    _titleController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Doctor"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Name"
              ),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10),
            LocationInput(
              onSelectLocation: (location){
                _selectedLocation = location;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: const Icon(Icons.add),
              label: const Text("Add doctor"),
            )
          ],
        ),
      ),
    );
  }
}
