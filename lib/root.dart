import 'package:flutter/material.dart';
import 'package:veterinary_app/screens/client/viewClient.dart';
import 'package:veterinary_app/screens/doctor/doctorList.dart';
import 'package:veterinary_app/screens/doctor/viewDoctors.dart';



class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.local_hospital),
        title: RichText(
          text: TextSpan(
            text: "R's ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontStyle: FontStyle.italic,
            ),
            children: [
              TextSpan(
                text: "care",
                style: TextStyle(color: Color(0xFFC2410C)),
              )
            ],
          ),
        ),

        backgroundColor: Colors.grey,
      ),
      body:Row(
    children: [
    ElevatedButton.icon(
        label: const Text("Doctor"),
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => ViewDoctorsScreen())
          );

        },
      ),
        SizedBox(width: 20,),
        ElevatedButton.icon(
        label: const Text("Client"),
    onPressed: (){
    Navigator.push(
    context,
    MaterialPageRoute(builder: (builder) => ViewClientScreen())
    );
    }
    ),
    ]
    ),
    );
  }
}


