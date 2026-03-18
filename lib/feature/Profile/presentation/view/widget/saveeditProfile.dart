import 'dart:async';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Saveeditprofile extends StatelessWidget {
  const Saveeditprofile({
    super.key,
    required this.ontap,
    required this.bntcontroller,
  });
  final Function() ontap;
  final StreamController<bool> bntcontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.p23),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: StreamBuilder<bool>(
              initialData: false,
              stream: bntcontroller.stream,
              builder:
                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) =>
                      ElevatedButton(
                        onPressed: snapshot.data == true ? ontap : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManger.kPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 6,
                          shadowColor: ColorManger.kPrimary.withOpacity(0.35),
                        ),
                        child: Text(
                          'Save Changes',
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
