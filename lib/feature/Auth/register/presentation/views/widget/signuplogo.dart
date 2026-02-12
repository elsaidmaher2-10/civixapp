import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';

class signuplogo extends StatelessWidget {
  const signuplogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(AssetValueManager.Klog, width: screeutilsManager.w72),
          Text(
            Constantmanger.civix,
            style: TextStyle(
              fontFamily: FontFamily.OriginalSurfer,
              fontSize: screeutilsManager.s11,
              color: ColorManger.kprimary,
            ),
          ),
          SizedBox(height: screeutilsManager.h9),
          Text(
            Constantmanger.sinup,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: FontFamily.Otama_ep,
              fontSize: screeutilsManager.s38,
              color: ColorManger.kprimary,
            ),
          ),
        ],
      ),
    );
  }
}
