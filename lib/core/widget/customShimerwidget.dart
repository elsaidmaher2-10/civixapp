import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget customShimer(double height) {
  return Shimmer.fromColors(
    baseColor: ColorManger.workerbgLight,
    highlightColor: Colors.grey[100]!,
    child: Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  );
}
