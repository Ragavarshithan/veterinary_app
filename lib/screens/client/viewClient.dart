import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:veterinary_app/screens/client/addClient.dart';
import 'package:veterinary_app/screens/client/clientList.dart';
import 'package:veterinary_app/util/userDetails.dart';

class ViewClientScreen extends ConsumerStatefulWidget{
  const ViewClientScreen({super.key});

  @override
  ConsumerState<ViewClientScreen> createState(){
    return _viewClientScreenState();
  }

}

class _viewClientScreenState extends ConsumerState<ViewClientScreen>{

  late Future<void> _clientFuture;
  late Future<void> _doctorFuture;

  @override
  void initState() {
    super.initState();
    _clientFuture = ref.read(clientProvider.notifier).loadClient();
    _doctorFuture = ref.read(doctorProvider.notifier).loadDoctors();
  }
  @override
  Widget build(BuildContext context){
    final clientInfo = ref.watch(clientProvider);
    final doctorInfo = ref.watch(doctorProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Client List"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx)=> const AddClientScreen(),
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
              future: Future.wait([_clientFuture, _doctorFuture]),
              builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : ClientList(
                client: clientInfo,
                doctors: doctorInfo,
              )
          )
      ),
    );
  }
}