import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controller/onbroadingprovider.dart';
import '../model/onbroadingmodel.dart';
import '../widget/indicator.dart';

class Customonbroadingitem extends StatelessWidget {
  const Customonbroadingitem({
    super.key,
    required this.x,
    required this.value,
    required this.pages,
    required this.controller,
  });
  final int value;
  final int x;
  final List<Onbroadingmodel> pages;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              !context.read<Onbroadingprovider>().isLastPage
                  ? TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: ColorManger.Lightgrey,
                            width: 0.5.w,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                      ),
                      onPressed: () {
                        controller.jumpToPage(pages.length - 1);
                      },
                      child: Text(
                        Constantmanger.skip,
                        style: GoogleFonts.publicSans(
                          color: ColorManger.lightcolor,
                          fontSize: ScreenUtilsManager.s20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h9),
          Image.asset(
            pages[x].image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.50,
          ),
          SizedBox(height: ScreenUtilsManager.h16),
          Text(
            pages[x].title,
            style: GoogleFonts.publicSans(
              fontSize: ScreenUtilsManager.s32,
              color: ColorManger.kprimarydark,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h9),
          Text(
            pages[x].subtitle,
            style: GoogleFonts.publicSans(
              fontSize: ScreenUtilsManager.s16,
              color: ColorManger.Lightgrey6,
              fontWeight: FontWeight.w400,
            ),
          ),

          SizedBox(height: ScreenUtilsManager.h18),
          customindicator(controller: controller),
          SizedBox(height: ScreenUtilsManager.h68),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
                fixedSize: Size(double.infinity, ScreenUtilsManager.h44),
                foregroundColor: ColorManger.white,
                backgroundColor: ColorManger.kprimary,
              ),
              onPressed: () async {
                final provider = context.read<Onbroadingprovider>();
                if (!provider.isLastPage) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.fastOutSlowIn,
                  );
                } else {
                  await PrefrenceManager().setbool(
                    Constantmanger.isOnboardingViewed,
                    true,
                  );
                  Navigator.pushReplacementNamed(context, Routes.login);
                }
              },
              child: Text(
                context.watch<Onbroadingprovider>().isLastPage
                    ? Constantmanger.finish
                    : Constantmanger.next,
                style: TextStyle(
                  fontSize: ScreenUtilsManager.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
