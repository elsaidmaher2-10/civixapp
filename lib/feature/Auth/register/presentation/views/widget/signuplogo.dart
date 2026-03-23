import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class signuplogo extends StatelessWidget {
  const signuplogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            AssetValueManager.Klog,
            height: ScreenUtilsManager.h120,
          ),

          SizedBox(height: ScreenUtilsManager.h9),
          Text(
            Constantmanger.sinup,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtilsManager.s34,
              color: ColorManger.kPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
