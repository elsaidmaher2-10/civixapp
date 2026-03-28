import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/mapController/cubit/map_controller_cubit.dart';
import 'package:citifix/feature/workerFeature/home/mapController/cubit/map_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:geo_fence_utils/geo_fence_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lottie/lottie.dart' hide Marker;

class CustomMapSection extends StatefulWidget {
  const CustomMapSection({super.key});
  @override
  State<CustomMapSection> createState() => _CustomMapSectionState();
}

class _CustomMapSectionState extends State<CustomMapSection> {
  final MapController _mapController = MapController();
  bool _mapReady = false;
  LatLng? _currLocation;
  final List<LatLng> zonemLevel = [
    const LatLng(31.41663201768019, 31.860368768499974),
    const LatLng(31.40487411404046, 31.857285834514656),
    const LatLng(31.405614165409748, 31.877787078402152),
    const LatLng(31.40668311819574, 31.897999297228538),
  ];

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
          double targezone = 15;
          if (state is WorkerOutSideZone) {
            _currLocation = state.curpoint;
            if (_mapReady && _currLocation != null) {
              List<LatLng> allPointsToShow = [
                _currLocation!,
                ...state.routePoints,
                ...zonemLevel,
              ];
              targezone = _calculateZoomLevel(state.distance);
              final bounds = LatLngBounds.fromPoints(allPointsToShow);
              _mapController.fitCamera(
                CameraFit.bounds(
                  minZoom: targezone,
                  bounds: bounds,
                  padding: const EdgeInsets.all(60.0),
                ),
              );
            }
          } else if (state is WorkerInsideZone) {
            _currLocation = state.curlocation;
            targezone = 27;
            if (_mapReady && _currLocation != null) {
              _mapController.move(_currLocation!, targezone);
            }
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: ColorManger.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: ColorManger.onSurface.withOpacity(0.04),
                  blurRadius: 32,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          minZoom: 10,
                          maxZoom: 18,
                          onMapReady: () {
                            setState(() {
                              _mapReady = true;
                            });

                            context
                                .read<MapControllerCubit>()
                                .trackUserLocation(
                                  points: zonemLevel
                                      .map(
                                        (e) => GeoPoint(
                                          latitude: e.latitude,
                                          longitude: e.longitude,
                                        ),
                                      )
                                      .toList(),
                                );
                          },
                          initialCenter: zonemLevel.first,
                          initialZoom: 14.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.globalgate.worker',
                          ),

                          PolygonLayer(
                            polygons: [
                              Polygon(
                                points: zonemLevel,
                                color: ColorManger.lightBlue.withOpacity(0.15),
                                borderColor: ColorManger.lightBlue,
                                borderStrokeWidth: 2.5,
                                isFilled: true,
                                label: "ZONE A",
                                labelStyle: TextStyle(
                                  color: ColorManger.textBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),

                          if (state is WorkerOutSideZone &&
                              state.routePoints.isNotEmpty)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  color: Colors.blue,
                                  strokeWidth: 2,
                                  points: state.routePoints,
                                ),
                              ],
                            ),

                          MarkerLayer(
                            markers: [
                              if (_currLocation != null)
                                Marker(
                                  point: _currLocation!,
                                  width: 60,
                                  height: 60,
                                  child: Lottie.asset(
                                    AssetValueManager.location,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),

                      if (state is WorkerOutSideZone)
                        Positioned(
                          top: 10,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ColorManger.primaryColor.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                      if (state is WorkerInsideZone)
                        Positioned(
                          top: 16,
                          left: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: Text(
                              state.message,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: ColorManger.primaryColor),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ASSIGNED ZONE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorManger.onSurfaceVariant,
                              letterSpacing: 1,
                            ),
                          ),
                          const Text(
                            'North District',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  double _calculateZoomLevel(double distanceInMeters) {
    if (distanceInMeters < 500) {
      return 17.0;
    } else if (distanceInMeters < 2000) {
      return 15.0;
    } else if (distanceInMeters < 5000) {
      return 13.0;
    } else if (distanceInMeters < 10000) {
      return 12.0;
    } else if (distanceInMeters < 20000) {
      return 11.0;
    } else {
      return 10.0;
    }
  }
}
