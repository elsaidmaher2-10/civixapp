import 'dart:convert';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/CustomMapSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/model/taskdetailsmodel.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MapNavigationSection extends StatefulWidget {
  const MapNavigationSection({super.key, required this.taskDetailsModel});
  final TaskDetailsModel taskDetailsModel;

  @override
  State<MapNavigationSection> createState() => _MapNavigationSectionState();
}

class _MapNavigationSectionState extends State<MapNavigationSection> {
  List<LatLng>? zonemLevel;
  @override
  void initState() {
    super.initState();
    zonemLevel = getZone();
  }

  List<LatLng>? getZone() {
    final zonemdecode = PrefrenceManager().getstring("zone");
    if (zonemdecode != null) {
      return (jsonDecode(zonemdecode) as List)
          .map((e) => LatLng(e["lat"], e["lang"]))
          .toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomMapSection(
      areaname: widget.taskDetailsModel.location,
      taskLocation: LatLng(
        widget.taskDetailsModel.latitude,
        widget.taskDetailsModel.longitude,
      ),
      zonemLevel: zonemLevel ?? [],
    );
  }
}
