import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../helpers/location_helper.dart';

class Farmacia {
  String name;
  bool abierto;
  String imageUrl;
  Map<String, dynamic> location;
  String address;

  Farmacia({
    @required this.name,
    this.abierto,
    this.imageUrl,
    @required this.location,
    @required this.address,
  });
}

class FarmaciasProvider with ChangeNotifier {
  List<Farmacia> _items = [];

  Future<void> fetchPlaces() async {
    try {
      if (_items.length >= 1) {
        return;
      }
      final places = await LocationHelper.findNearby();
      places.forEach((element) {
        _items.add(
          Farmacia(
            name: element['name'],
            abierto: element['opening_hours'] != null
                ? element['opening_hours']['open_now']
                : false,
            imageUrl: element['photos'] != null
                ? 'https://maps.googleapis.com/maps/api/place/photo?photo_reference=${element['photos'][0]['photo_reference']}&maxwidth=200&maxheight=100&key=${DotEnv().env["GOOGLE_MAPS_KEY"]}'
                : 'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse1.mm.bing.net%2Fth%3Fid%3DOIP.0faQQosBDN2F-62g8nTk_QHaDg%26pid%3DApi&f=1',
            location: {
              'lat': element['geometry']['location']['lat'],
              'lng': element['geometry']['location']['lng'],
            },
            address: element['vicinity'],
          ),
        );
      });
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  List<Farmacia> get getPlaces {
    return [..._items];
  }
}
