import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:veterinary_app/screens/client/model.dart';
import 'package:veterinary_app/screens/doctor/model.dart';
import 'package:veterinary_app/util/placeLocation.dart';

Future<Database> _getDatabase() async{
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(path.join(dbPath,'users.db'),
    onCreate: (db,version){
    db.execute(
      'CREATE TABLE doctors(id TEXT PRIMARY KEY,  docName TEXT, lat REAL, lng REAL,address TEXT)',
    );
    db.execute(
      'CREATE TABLE clients(id TEXT PRIMARY KEY,  cliName TEXT, lat REAL, lng REAL,address TEXT)',
    );
    },
    version: 1,
  );
  return db;
}

class DoctorNotifier extends StateNotifier<List<Doctor>>{
  DoctorNotifier(): super(const []);

  Future<void> loadDoctors() async {
    final db = await _getDatabase();
    final data = await db.query("doctors");
    final doctors = data.map(
        (row) => Doctor(
          id: row['id'] as String,
          doctorName: row['docName'] as String,
          location: PlaceLocation(
            latitude: row['lat'] as double,
            longitude: row['lng'] as double,
            address: row['address'] as String
          )
        ),
    ).toList();

    state = doctors;
  }


  void addDoctor(String doctorName, PlaceLocation location) async {
    final newDoctor =
        Doctor(doctorName: doctorName, location: location);
    final db = await _getDatabase();
    db.insert('doctors', {
      'id': newDoctor.id,
      'docName': newDoctor.doctorName,
      'lat': newDoctor.location.latitude,
      'lng': newDoctor.location.latitude,
      'address': newDoctor.location.address
    });
    state = [newDoctor, ...state];
  }

  void removeAllDoctors(){
    state = [];
  }
}
class ClientNotifier extends StateNotifier<List<Client>>{
 ClientNotifier(): super(const []);

  Future<void> loadClient() async {
    final db = await _getDatabase();
    final data = await db.query("clients");
    final clients = data.map(
          (row) => Client(
          id: row['id'] as String,
          clientName: row['cliName'] as String,
          location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String
          )
      ),
    ).toList();

    state = clients;
  }


  void addClient(String clientName, PlaceLocation location) async {
    final newClient =
    Client(clientName: clientName, location: location);
    final db = await _getDatabase();
    db.insert('clients', {
      'id': newClient.id,
      'cliName': newClient.clientName,
      'lat': newClient.location.latitude,
      'lng': newClient.location.latitude,
      'address': newClient.location.address
    });
    state = [newClient, ...state];
  }

  void removeAllClients(){
    state = [];
  }
}

final doctorProvider = StateNotifierProvider<DoctorNotifier,List<Doctor>>(
    (ref)=> DoctorNotifier()
);

final clientProvider = StateNotifierProvider<ClientNotifier,List<Client>>(
        (ref)=> ClientNotifier()
);