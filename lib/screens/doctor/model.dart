import 'package:uuid/uuid.dart';
import 'package:veterinary_app/util/placeLocation.dart';

const uuid = Uuid();

class Doctor {
  final String id;
  final String doctorName;
  final PlaceLocation location;

  Doctor({
    String? id,
    required this.doctorName,
    required this.location
  }): id = id ?? uuid.v4();
}