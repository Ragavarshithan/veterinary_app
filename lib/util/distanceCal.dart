import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> calculateDistance(double cLat, double cLng, double dLat, double dLng, String apiKey) async {
  try {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$cLat,$cLng&destinations=$dLat,$dLng&key=$apiKey'
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final resData = json.decode(response.body);

      print('Distance Matrix API Response: ${resData['rows'][0]['elements'][0]['distance'].containsKey('value')}');

      if (resData['status'] == 'OK' && resData.containsKey('rows') && resData['rows'].isNotEmpty &&
          resData['rows'][0].containsKey('elements') && resData['rows'][0]['elements'].isNotEmpty &&
          resData['rows'][0]['elements'][0].containsKey('distance')
          && resData['rows'][0]['elements'][0]['distance'].containsKey('value')) {
        return resData['rows'][0]['elements'][0]['distance']['value'].toDouble();
      } else if (resData['status'] == 'ZERO_RESULTS') {
        throw Exception('No results found for the given origin and destination');
      } else {
        throw Exception('Failed to Fetch Distance: Invalid response structure');
      }
    } else {
      throw Exception('Failed to fetch distance: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching distance: $e');
    throw Exception('Failed to fetch distance');
  }
}
