import 'package:location/location.dart';

class Locationservice {
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

  getLocationData(void Function(LocationData)? onData) {
    location.changeSettings(distanceFilter: 10, interval: 10000);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocationOce() async {
    return await location.getLocation();
  }
}
