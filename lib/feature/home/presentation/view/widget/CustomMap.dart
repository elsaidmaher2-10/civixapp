import 'dart:core';

import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/LocationService.dart';
import 'package:citifix/feature/home/presentation/view/widget/Animatedmarker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class CustomMap extends StatefulWidget {
  const CustomMap({super.key, required this.onmapCreated});
  final Function(String street, LatLng latlang) onmapCreated;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final MapController mapController = MapController();
  final Locationservice locationservice = Locationservice();
  String street = "";
  LatLng currentPosition = LatLng(31.410687579920204, 31.81590218785798);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200.h,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentPosition,
                initialZoom: 8,
                onMapReady: () async {
                  LocationData newLocation = await locationservice
                      .getLocationOce();
                  currentPosition = LatLng(
                    newLocation.latitude!,
                    newLocation.longitude!,
                  );


                  List<Placemark> placemarks = await placemarkFromCoordinates(
                    newLocation.latitude!,
                    newLocation.longitude!,
                  );

                  street =
                      "${placemarks.map((e) => e.name).toList().first}  ${placemarks.map((e) => e.subAdministrativeArea).toList().last}";
                  widget.onmapCreated(street, currentPosition);
                  setState(() {
                    mapController.move(currentPosition, 14);
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
          SizedBox(height: 10.h),
          street.isEmpty
              ? SizedBox.shrink()
              : Row(
                  children: [
                    Icon(Icons.place_outlined, color: Color(0xff475569)),
                    SizedBox(width: 5),
                    Text(
                      street,
                      style: TextStyle(
                        color: Color(0xff475569),
                        fontSize: ScreenUtilsManager.s14,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
