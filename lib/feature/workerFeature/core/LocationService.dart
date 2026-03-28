import 'package:location/location.dart';

class Locationservice {
  Locationservice._internal();
  static final _instance = Locationservice._internal();

  factory Locationservice(){
    return _instance;
  }
  Location location = Location();
  Future<bool> checkAndReqeustLocationService() async {
    bool isEnabled = await location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await location.requestService();
      if (!isEnabled) {
        return false;
      }
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPremmsion() async {
    PermissionStatus isEnabled = await location.hasPermission();
    if (isEnabled == PermissionStatus.deniedForever) {
      return false;
    }
    if (isEnabled == PermissionStatus.denied) {
      isEnabled = await location.requestPermission();
      if (isEnabled != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  Future<void> getLocationData(void Function(LocationData)? onData) async {
    location.changeSettings(
      distanceFilter: 10,
      interval: 10000,
      accuracy: LocationAccuracy.high,
    );

    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocationOce() async {
    return await location.getLocation();
  }
}
