import 'package:rick_and_morty/models/location_model.dart';
import 'package:rick_and_morty/screens/location_screen/bloc/location_provider.dart';

class LocationRepository {
  Provider provider = Provider();

  Future<List<LocationModel>> getLocations() {
    return provider.getLocations();
  }

Future<LocationModel> getLocation(String id) {
    return provider.getLocation(id);
  }
}
