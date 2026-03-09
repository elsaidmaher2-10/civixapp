import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/Ellipse 2.png"),
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

          SizedBox(height: 47.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SETTINGS",
                  style: TextStyle(
                    color: Color(0xff939393),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xffF4F2F2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/profileicons/Frame 34.svg",
                        ),
                        title: Text("language"),
                        trailing: RotatedBox(
                          quarterTurns: 90,
                          child: Icon(CupertinoIcons.back),
                        ),
                      ),
                      Divider(),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/profileicons/Frame 34(1).svg",
                        ),
                        title: Text("identity"),
                        trailing: RotatedBox(
                          quarterTurns: 90,
                          child: Icon(CupertinoIcons.back),
                        ),
                      ),
                      Divider(),

                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/profileicons/Frame 36.svg",
                        ),
                        title: Text("Support"),
                        trailing: RotatedBox(
                          quarterTurns: 90,
                          child: Icon(CupertinoIcons.back),
                        ),
                      ),
                      Divider(),

                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/profileicons/Frame 37.svg",
                        ),
                        title: Text("Account information"),
                        trailing: RotatedBox(
                          quarterTurns: 90,
                          child: Icon(CupertinoIcons.back),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
