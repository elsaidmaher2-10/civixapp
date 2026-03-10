import 'package:citifix/core/service/LocationService.dart';
import 'package:citifix/feature/home/presentation/view/widget/Animatedmarker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key});
  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final MapController mapController = MapController();
  final Locationservice locationservice = Locationservice();
  LatLng currentPosition = LatLng(31.410687579920204, 31.81590218785798);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 200.h,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: currentPosition,
            initialZoom: 8,
            onMapReady: () async {
              LocationData newLocation = await locationservice.getLocationOce();

              currentPosition = LatLng(
                newLocation.latitude!,
                newLocation.longitude!,
              );

              print("Current position: $currentPosition");

              List<Placemark> placemarks = await placemarkFromCoordinates(
                newLocation.latitude!,
                newLocation.longitude!,
              );

              print("Street: ${placemarks.map((e) => e.street).toList()}");

              setState(() {
                mapController.move(currentPosition, 16);
              });
            },
          ),
          children: [
            TileLayer(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.citifix',
            ),
            MarkerLayer(
              markers: [
                Marker(point: currentPosition, child: AnimatedMarker()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
