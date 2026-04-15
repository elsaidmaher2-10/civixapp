import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_cubit.dart';
import 'package:citifix/feature/workerFeature/home/presentation/manager/mapController/cubit/map_controller_state.dart';
import 'package:citifix/generated/l10n.dart';
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

  CustomMapSection({
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

              if (allPoints.length >= 2) {
                final bounds = LatLngBounds.fromPoints(allPoints);
                _mapController.fitCamera(
                  CameraFit.bounds(
                    bounds: bounds,
                    padding: EdgeInsets.all(ScreenUtilsManager.s70),
                  ),
                );
              }
            } else if (state is WorkerInsideZone) {
              _currLocation = state.curlocation;
              _mapController.move(_currLocation!, ScreenUtilsManager.s17);
            } else if (state is WorkerNoZone) {
              _currLocation = state.curlocation;
              _mapController.move(_currLocation!, ScreenUtilsManager.s17);
            }
          }
        },
        builder: (context, state) {
          if (state is WorkerNoZone) {
            _currLocation = state.curlocation;
          }

          String distanceValue = "0.0";
          if (state is WorkerOutSideZone) {
            distanceValue = (state.distance / 1000).toStringAsFixed(1);
          }

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: ScreenUtilsManager.h450,
                    decoration: BoxDecoration(
                      color: ColorManger.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.s24,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: FlutterMap(
                      mapController: _mapController,
                      options: MapOptions(
                        initialCenter:
                            widget.taskLocation ??
                            (widget.zonemLevel.isNotEmpty
                                ? widget.zonemLevel.first
                                : LatLng(30.0444, 31.2357)),
                        initialZoom: ScreenUtilsManager.s14,
                        onMapReady: () {
                          setState(() => _mapReady = true);
                          context.read<MapControllerCubit>().trackUserLocation(
                            points: widget.zonemLevel.length >= 3
                                ? widget.zonemLevel
                                      .map(
                                        (e) => GeoPoint(
                                          latitude: e.latitude,
                                          longitude: e.longitude,
                                        ),
                                      )
                                      .toList()
                                : [],
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
                                strokeWidth: ScreenUtilsManager.s5,
                                color: Color(0xFFFF7B00),
                                borderStrokeWidth: ScreenUtilsManager.s2,
                                borderColor: Colors.white,
                              ),
                            ],
                          ),
                        if (widget.zonemLevel.length >= 3)
                          PolygonLayer(
                            polygons: [
                              Polygon(
                                points: widget.zonemLevel,
                                color: Color(0xFFFF7B00).withOpacity(0.1),
                                borderColor: Color(0xFFFF7B00),
                                borderStrokeWidth: ScreenUtilsManager.s2,
                              ),
                            ],
                          ),
                        MarkerLayer(
                          markers: [
                            if (widget.taskLocation != null)
                              Marker(
                                point: widget.taskLocation!,
                                width: ScreenUtilsManager.s50,
                                height: ScreenUtilsManager.s50,
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.blueGrey,
                                  size: ScreenUtilsManager.s45,
                                ),
                              ),
                            if (_currLocation != null)
                              Marker(
                                point: _currLocation!,
                                width: ScreenUtilsManager.s65,
                                height: ScreenUtilsManager.s65,
                                child: Lottie.asset(AssetValueManager.location),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  if (state is WorkerOutSideZone && widget.taskLocation != null)
                    Positioned(
                      top: ScreenUtilsManager.s20,
                      left: ScreenUtilsManager.s20,
                      right: ScreenUtilsManager.s20,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ScreenUtilsManager.s12,
                          horizontal: ScreenUtilsManager.s20,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFF7B00).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(
                            ScreenUtilsManager.s12,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: ScreenUtilsManager.s10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).distance_to_task,
                                  style: GoogleFonts.cairo(
                                    color: Colors.white70,
                                    fontSize: ScreenUtilsManager.s10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "$distanceValue ${S.of(context).km}",
                                  style: GoogleFonts.cairo(
                                    color: Colors.white,
                                    fontSize: ScreenUtilsManager.s18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.directions_run,
                              color: Colors.white,
                              size: ScreenUtilsManager.s30,
                            ),
                          ],
                        ),
                      ),
                    ),

                  Positioned(
                    bottom: ScreenUtilsManager.s20,
                    right: ScreenUtilsManager.s20,
                    child: Column(
                      children: [
                        _MapButton(
                          icon: Icons.add,
                          onTap: () {
                            final currentZoom = _mapController.camera.zoom;
                            _mapController.move(
                              _mapController.camera.center,
                              currentZoom + 1,
                            );
                          },
                        ),
                        SizedBox(height: ScreenUtilsManager.s8),
                        _MapButton(
                          icon: Icons.remove,
                          onTap: () {
                            final currentZoom = _mapController.camera.zoom;
                            _mapController.move(
                              _mapController.camera.center,
                              currentZoom - 1,
                            );
                          },
                        ),
                        SizedBox(height: ScreenUtilsManager.s8),
                        _MapButton(
                          icon: Icons.my_location,
                          onTap: () {
                            if (_currLocation != null) {
                              _mapController.move(
                                _currLocation!,
                                ScreenUtilsManager.s17,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.all(ScreenUtilsManager.s20),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenUtilsManager.s25,
                      backgroundColor: Color(0xFFFF7B00).withOpacity(0.1),
                      child: Icon(Icons.my_location, color: Color(0xFFFF7B00)),
                    ),
                    SizedBox(width: ScreenUtilsManager.w15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state is WorkerInsideZone
                                ? S.of(context).inside_work_zone
                                : state is WorkerNoZone
                                ? S.of(context).monitoring_area
                                : (widget.taskLocation != null
                                      ? S.of(context).heading_to_task
                                      : S.of(context).monitoring_area),
                            style: GoogleFonts.cairo(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtilsManager.s18,
                            ),
                          ),
                          Text(
                            widget.areaname,
                            style: GoogleFonts.cairo(
                              fontSize: ScreenUtilsManager.s14,
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

class _MapButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _MapButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Color(0xFFFF7B00), size: 22),
      ),
    );
  }
}
