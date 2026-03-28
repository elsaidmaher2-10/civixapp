import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:citifix/core/service/LocationService.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/Animatedmarker.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:lottie/lottie.dart' hide Marker;

class CustomMap extends StatefulWidget {
  final Function(String street, LatLng latlng) onmapCreated;
  final LatLng? initialPosition;
  final String? initialStreet;

  const CustomMap.fromDevice({super.key, required this.onmapCreated})
    : initialPosition = null,
      initialStreet = null;

  const CustomMap.fromAPI({
    super.key,
    required this.onmapCreated,
    required LatLng apiPosition,
    required String location,
  }) : initialPosition = apiPosition,
       initialStreet = location;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> with TickerProviderStateMixin {
  final MapController _mapController = MapController();
  final Locationservice _locationservice = Locationservice();

  LatLng? _currentPosition;
  String _street = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _street = widget.initialStreet ?? "";
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      LatLng? targetPosition;

      if (widget.initialPosition != null) {
        targetPosition = widget.initialPosition;
      } else {
        LocationData newLocation = await _locationservice.getLocationOce();
        targetPosition = LatLng(newLocation.latitude!, newLocation.longitude!);
      }

      if (mounted) {
        setState(() {
          _currentPosition = targetPosition;
          _isLoading = false;
        });

        // جلب اسم الشارع لو مش موجود
        if (_street.isEmpty && targetPosition != null) {
          await _updateStreet(targetPosition);
        }

        _mapController.move(_currentPosition!, 14);

        widget.onmapCreated(_street, _currentPosition!);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _updateStreet(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty && mounted) {
        final place = placemarks.first;
        setState(() {
          _street = "${place.street ?? ''} ${place.subAdministrativeArea ?? ''}"
              .trim();
        });
      }
    } catch (e) {
      _street = "Unknown location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtilsManager.h250,
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: ColorManger.kPrimaryDark,
                    ),
                  )
                : Stack(
                    children: [
                      FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter:
                              _currentPosition ??
                              const LatLng(31.4106, 31.8159),
                          initialZoom: 14,
                          onMapReady: () {
                            if (_currentPosition != null) {
                              _mapController.move(_currentPosition!, 14);
                            }
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.citifix.app',
                          ),
                          if (_currentPosition != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: _currentPosition!,
                                  width: 50,
                                  height: 50,
                                  child: CustomLocationMarker(),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
          if (_street.isNotEmpty) ...[
            SizedBox(height: ScreenUtilsManager.h10),
            Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: Lottie.asset(AssetValueManager.pinLocaation),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    _street,
                    style: TextStyle(
                      color: const Color(0xff475569),
                      fontSize: ScreenUtilsManager.s14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
