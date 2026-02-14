import 'package:civixapp/core/database/local/prefmanger.dart';
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                          side: const BorderSide(
                            color: ColorManger.Lightgrey,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      onPressed: () {
                        controller.jumpToPage(pages.length - 1);
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          // fontFamily: FontFamily.Otama_ep,
                          color: Color(0xff2A4D8B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(height: 15),
            ],
          ),

          const SizedBox(height: 9),

          Image.asset(
            pages[x].image,
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * 0.50,
          ),

          const SizedBox(height: 16),

          Text(
            pages[x].title,
            style: TextStyle(
              // fontFamily: FontFamily.Otama_ep,
              fontSize: 32,
              color: Color(0xff003366),
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 9),
          Text(
            pages[x].subtitle,
            style: const TextStyle(
              fontSize: 20,
              color: ColorManger.Lightgrey2,
              fontWeight: FontWeight.w400,
            ),
          ),

          const SizedBox(height: 18),

          customindicator(controller: controller),

          SizedBox(height: 68.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                fixedSize: Size(double.infinity, 44.h),
                foregroundColor: const Color(0xffFFFFFF),
                backgroundColor: const Color(0xff2A4D8B),
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
                  Navigator.pushNamed(context, Routes.login);
                }
              },
              child: Text(
                context.watch<Onbroadingprovider>().isLastPage
                    ? "Finish"
                    : "Next",
                style: const TextStyle(
                  fontSize: 20,
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
