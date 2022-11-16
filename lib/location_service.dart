import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:take_picture_and_location/user_location_item_data.dart';

class LocationService {
  Future<UserLocationItemData> getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      String address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}.${place.postalCode}';
      UserLocationItemData userLocation = UserLocationItemData(
        latitude: position.latitude,
        longitude: position.longitude,
        addressLine: address,
      );
      return userLocation;
    } catch (e) {
      print('[getCurrentLocation] Error Ocurred ${e.toString()}');
      UserLocationItemData userLocation = UserLocationItemData(
        latitude: position.latitude,
        longitude: position.longitude,
        addressLine: "Cannot Get Your address",
      );

      return userLocation;
    }
  }
}
