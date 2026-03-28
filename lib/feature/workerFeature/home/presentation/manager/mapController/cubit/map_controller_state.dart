import 'package:latlong2/latlong.dart';

sealed class MapControllerState {}

final class MapControllerInitial extends MapControllerState {}

final class WorkerInsideZone extends MapControllerState {
  String message;
  LatLng curlocation;
  WorkerInsideZone({required this.message, required this.curlocation});
}

class WorkerOutSideZone extends MapControllerState {
  final String message;
  final double distance;
  final List<LatLng> routePoints;
  final LatLng curpoint;

  WorkerOutSideZone({
    required this.curpoint,
    required this.message,
    required this.distance,
    required this.routePoints,
  });
}
