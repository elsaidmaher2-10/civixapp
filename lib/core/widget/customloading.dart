import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget customloading() {
  return Lottie.asset(AssetValueManager.laoding, width: 200, height: 200);
}
