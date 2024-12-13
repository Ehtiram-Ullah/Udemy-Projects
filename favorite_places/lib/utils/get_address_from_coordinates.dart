import 'package:geocoding/geocoding.dart';

Future<void> getAddressFromLatLng(double latitude, double longitude) async {
  try {
    print(latitude);
    print(longitude);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    print('Location: ${place.street}, ${place.locality}, ${place.country}');
  } catch (e) {
    print('Failed to get location name: $e');
  }
}
