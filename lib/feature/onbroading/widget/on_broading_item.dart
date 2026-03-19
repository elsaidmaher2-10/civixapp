import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/onbroading/widget/indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../controller/onbroadingprovider.dart';
import '../model/onbroadingmodel.dart';

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
    return Scaffold(
      backgroundColor: ColorManger.reportsPageBackground,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilsManager.p23,
          vertical: ScreenUtilsManager.p23,
        ),
        child: Row(
          children: [
            customindicator(controller: controller),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
                elevation: 0,
                backgroundColor: ColorManger.reportsPageBackground,
                foregroundColor: ColorManger.kPrimary,
              ),
              onPressed: () async {
                final provider = context.read<Onbroadingprovider>();
                if (!provider.isLastPage) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 400),
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
              label: Text(
                context.watch<Onbroadingprovider>().isLastPage
                    ? Constantmanger.finish
                    : Constantmanger.next,
                style: TextStyle(
                  fontSize: ScreenUtilsManager.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.p23),
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
                              color: ColorManger.lightGrey,
                              width: 0.5.w,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.r),
                            ),
                          ),
                        ),
                        onPressed: () {
                          controller.jumpToPage(pages.length - 1);
                        },
                        child: Text(
                          Constantmanger.skip,
                          style: GoogleFonts.publicSans(
                            color: ColorManger.lightColor,
                            fontSize: ScreenUtilsManager.s16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: ScreenUtilsManager.h9),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: SvgPicture.asset(
                pages[x].image,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * 0.50,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            Text(
              pages[x].title,
              style: GoogleFonts.publicSans(
                fontSize: ScreenUtilsManager.s20,
                color: ColorManger.kPrimaryDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h9),
            Text(
              pages[x].subtitle,
              style: GoogleFonts.publicSans(
                fontSize: ScreenUtilsManager.s16,
                color: ColorManger.lightGrey6,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h18),
          ],
        ),
      ),
    );
  }
}
