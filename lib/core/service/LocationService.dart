import 'package:location/location.dart';

class Locationservice {
  Location location = Location();

  Future<bool> init() async {
    final serviceOk = await checkAndReqeustLocationService();
    if (!serviceOk) return false;
    final permissionOk = await checkAndRequestLocationPremmsion();
    if (!permissionOk) return false;
    return true;
  }

  Future<bool> checkAndReqeustLocationService() async {
    bool isEnabled = await location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await location.requestService();
      if (!isEnabled) return false;
    }
    return true;
  }

  Future<bool> checkAndRequestLocationPremmsion() async {
    PermissionStatus status = await location.hasPermission();
    if (status == PermissionStatus.deniedForever) return false;
    if (status == PermissionStatus.denied) {
      status = await location.requestPermission();
      if (status != PermissionStatus.granted) return false;
    }
    return true;
  }

  // ✅ بقت async وبتستنى init الأول
  Future<bool> getLocationData(void Function(LocationData) onData) async {
    final ready = await init();
    if (!ready) return false;

    location.changeSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
      interval: 10000,
    );

    location.onLocationChanged.listen(onData);
    return true;
  }

  Future<LocationData?> getLocationOce() async {
    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }
}
