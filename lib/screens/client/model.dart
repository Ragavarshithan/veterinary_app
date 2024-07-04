import 'package:uuid/uuid.dart';
import 'package:veterinary_app/util/placeLocation.dart';

const uuid = Uuid();

class Client {
  final String id;
  final String clientName;
  final PlaceLocation location;

  Client({
    String? id,
    required this.clientName,
    required this.location
  }): id = id ?? uuid.v4();
}