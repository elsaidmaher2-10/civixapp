import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customShimer(BuildContext context, double height) {
  final Color base = context.palette.surfaceContainerHigh;
  final Color highlight = context.palette.surfaceContainerHighest;
  return Shimmer.fromColors(
    baseColor: base,
    highlightColor: highlight,
    child: Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: base,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
