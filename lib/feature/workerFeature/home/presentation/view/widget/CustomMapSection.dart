import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_cubit.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:geo_fence_utils/models/geo_point.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' hide Marker;

class CustomMapSection extends StatefulWidget {
  final LatLng? taskLocation;
  final String areaname;
  final List<LatLng> zonemLevel;

  const CustomMapSection({
    super.key,
    this.taskLocation,
    required this.areaname,
    required this.zonemLevel,
  });

  @override
  State<CustomMapSection> createState() => _CustomMapSectionState();
}

class _CustomMapSectionState extends State<CustomMapSection> {
  final MapController _mapController = MapController();
  bool _mapReady = false;
  LatLng? _currLocation;

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapControllerCubit(),
      child: BlocConsumer<MapControllerCubit, MapControllerState>(
        listener: (context, state) {
          if (_mapReady) {
            if (state is WorkerOutSideZone) {
              _currLocation = state.curpoint;

              List<LatLng> allPoints = [
                _currLocation!,
                if (widget.taskLocation != null) widget.taskLocation!,
                ...widget.zonemLevel,
                ...state.routePoints,
              ];

              final bounds = LatLngBounds.fromPoints(allPoints);
              _mapController.fitCamera(
                CameraFit.bounds(
                  bounds: bounds,
                  padding: const EdgeInsets.all(70.0),
                ),
              );
            } else if (state is WorkerInsideZone) {
              _currLocation = state.curlocation;
              _mapController.move(_currLocation!, 17.0);
            }
          }
        },
        builder: (context, state) {
          String distanceValue = "0.0";
          if (state is WorkerOutSideZone) {
            distanceValue = (state.distance / 1000).toStringAsFixed(1);
          }

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: ColorManger.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter:
                            widget.taskLocation ??
                            (widget.zonemLevel.isNotEmpty
                                ? widget.zonemLevel.first
                                : const LatLng(0, 0)),
                        initialZoom: 14.0,
                        onMapReady: () {
                          setState(() => _mapReady = true);
                          // تشغيل تتبع الموقع الجغرافي (Geofencing)
                          context.read<MapControllerCubit>().trackUserLocation(
                            points: widget.zonemLevel
                                .map(
                                  (e) => GeoPoint(
                                    latitude: e.latitude,
                                    longitude: e.longitude,
                                  ),
                                )
                                .toList(),
                          );
                        },
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.globalgate.worker',
                        ),

                        if (state is WorkerOutSideZone &&
                            state.routePoints.isNotEmpty)
                          PolylineLayer(
                            polylines: [
                              Polyline(
                                points: state.routePoints,
                                strokeWidth: 5.0,
                                color: const Color(0xFFFF7B00),
                                borderStrokeWidth: 2.0,
                                borderColor: Colors.white,
                              ),
                            ],
                          ),

                        PolygonLayer(
                          polygons: [
                            Polygon(
                              points: widget.zonemLevel,
                              color: const Color(0xFFFF7B00).withOpacity(0.1),
                              borderColor: const Color(0xFFFF7B00),
                              borderStrokeWidth: 2,
                            ),
                          ],
                        ),

                        MarkerLayer(
                          markers: [
                            if (widget.taskLocation != null)
                              Marker(
                                point: widget.taskLocation!,
                                width: 50,
                                height: 50,
                                child: const Icon(
                                  Icons.location_on,
                                  color: Colors.blueGrey,
                                  size: 45,
                                ),
                              ),

                            if (_currLocation != null)
                              Marker(
                                point: _currLocation!,
                                width: 65,
                                height: 65,
                                child: Lottie.asset(AssetValueManager.location),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (state is WorkerOutSideZone && widget.taskLocation != null)
                    Positioned(
                      top: 20,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF7B00).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 10),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DISTANCE TO TASK",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white70,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$distanceValue KM",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.directions_run,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: const Color(0xFFFF7B00).withOpacity(0.1),
                      child: const Icon(
                        Icons.my_location,
                        color: Color(0xFFFF7B00),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state is WorkerInsideZone
                                ? "Inside Work Zone"
                                : (widget.taskLocation != null
                                      ? "Heading to Task"
                                      : "Monitoring Area"),
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            widget.areaname,
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
