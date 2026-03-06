import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/citifixlogo.png"),
              ),
              SvgPicture.asset("assets/edit.svg"),
            ],
          ),
          Text(
            "Mohamed Ahmed",
            style: TextStyle(
              fontSize: ScreenUtilsManager.s16,
              fontWeight: FontWeight.w700,
              color: ColorManger.kprimary,
            ),
          ),
        ],
      ),
    );
  }
}
