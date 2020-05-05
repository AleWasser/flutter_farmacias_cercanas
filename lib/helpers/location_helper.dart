import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationHelper {
  static Future<List<Map<String, dynamic>>> findNearby() async {
    final location = await Location().getLocation();
    final url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${location.latitude},${location.longitude}&radius=1500&type=pharmacy&keyword=farmacia&language=es-419&key=${DotEnv().env["GOOGLE_MAPS_KEY"]}";
    final response = await http.get(url);
    return List<Map<String, dynamic>>.from(
        json.decode(response.body)["results"]);
  }
}
