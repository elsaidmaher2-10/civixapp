import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/feature/onbroading/controller/onbroadingprovider.dart';
import 'package:citifix/feature/onbroading/model/onbroadingmodel.dart';
import 'package:citifix/feature/onbroading/widget/indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
      padding: EdgeInsets.all(ScreenUtilsManager.p23),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              !context.watch<Onbroadingprovider>().isLastPage
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
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
                            controller.animateToPage(
                              pages.length - 1,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          },
                          child: Text(
                            Constantmanger.skip,
                            style: GoogleFonts.publicSans(
                              color: ColorManger.lightColor,
                              fontSize: ScreenUtilsManager.s16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(height: 10.h),
            ],
          ),
          SizedBox(height: ScreenUtilsManager.h9),

          Expanded(
            flex: 4,
            child: SvgPicture.asset(
              height: MediaQuery.of(context).size.height * 0.75,
              pages[x].image,
              fit: BoxFit.fill,
            ),
          ),

          SizedBox(height: ScreenUtilsManager.h16),

          Text(
            pages[x].title,
            textAlign: TextAlign.center,
            style: GoogleFonts.publicSans(
              fontSize: ScreenUtilsManager.h22,
              color: ColorManger.kPrimaryDark,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: ScreenUtilsManager.h9),

          Text(
            pages[x].subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.publicSans(
              fontSize: ScreenUtilsManager.s16,
              color: ColorManger.lightGrey6,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Spacer(),

          _buildBottomActions(context),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customindicator(controller: controller),
        Consumer<Onbroadingprovider>(
          builder: (context, provider, child) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
                ),
                elevation: 0,
                backgroundColor: provider.isLastPage
                    ? ColorManger.kPrimary
                    : ColorManger.reportsPageBackground,
                foregroundColor: provider.isLastPage
                    ? Colors.white
                    : ColorManger.kPrimary,
              ),
              onPressed: () async {
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
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, Routes.login);
                  }
                }
              },
              child: Text(
                provider.isLastPage
                    ? Constantmanger.finish
                    : Constantmanger.next,
                style: TextStyle(
                  fontSize: ScreenUtilsManager.s18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
