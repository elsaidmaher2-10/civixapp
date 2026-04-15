import 'package:latlong2/latlong.dart';

sealed class MapControllerState {}

final class MapControllerInitial extends MapControllerState {}

final class WorkerInsideZone extends MapControllerState {
  final String message;
  final LatLng curlocation;
  WorkerInsideZone({required this.message, required this.curlocation});
}

final class WorkerOutSideZone extends MapControllerState {
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

final class WorkerNoZone extends MapControllerState {
  final LatLng curlocation;
  WorkerNoZone({required this.curlocation});
}

final class MapControllerError extends MapControllerState {
  final String message;
  MapControllerError({required this.message});
}
