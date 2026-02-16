import 'dart:async' show StreamController;

import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordRules extends StatefulWidget {
  PasswordRules({super.key, required this.streamController});
  StreamController<List> streamController;
  State<PasswordRules> createState() => _PasswordRulesState();
}

class _PasswordRulesState extends State<PasswordRules> {
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: Constantmanger.passwordRules,
      stream: widget.streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            snapshot.data.any((e) => e["status"] == false)
                ? Text(
                    Constantmanger.passwordRulestitle,
                    style: TextStyle(
                      fontSize: screeutilsManager.s10,
                      color: ColorManger.red,
                    ),
                  )
                : SizedBox(),

            ...Constantmanger.passwordRules.map(
              (e) => Row(
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    Icons.circle,
                    size: screeutilsManager.s5,
                    color: e["status"] == true
                        ? ColorManger.green
                        : ColorManger.red,
                  ),
                  SizedBox(width: 2.sp),
                  Text(
                    e["title"],

                    style: TextStyle(
                      decoration: e["status"] == true
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontSize: screeutilsManager.s9,
                      color: e["status"] == true
                          ? ColorManger.green
                          : ColorManger.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
