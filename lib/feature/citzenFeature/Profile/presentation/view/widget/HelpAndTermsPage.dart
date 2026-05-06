import 'package:citifix/core/function/customerSupport.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/HelpModel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndTermsPage extends StatelessWidget {
  const HelpAndTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = HelpModel.getHelpContent(
      context,
    ).map((e) => e.category).toSet().toList();
    return Scaffold(
      backgroundColor: context.palette.reportsPageBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_sharp, size: ScreenUtilsManager.s18),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          S.of(context).helpAndLegal,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: context.palette.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.palette.surfaceContainerLowest,
        foregroundColor: context.palette.onSurface,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        itemCount: categories.length,
        itemBuilder: (context, catIndex) {
          final category = categories[catIndex];
          final items = HelpModel.getHelpContent(
            context,
          ).where((e) => e.category == category).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 8.w,
                  top: 15.h,
                  bottom: 10.h,
                ),
                child: Text(
                  category,
                  style: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: context.palette.kPrimary,
                  ),
                ),
              ),
              ...items.map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: FAQ(
                    question: item.question,
                    answer: item.answer,
                    showDivider: false,
                    ansDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    queDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    queStyle: GoogleFonts.cairo(
                      fontWeight: FontWeight.w600,
                      color: context.palette.onSurface,
                    ),
                    ansStyle: GoogleFonts.cairo(
                      color: context.palette.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildContactBar(context),
    );
  }

  Widget _buildContactBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.h),
      color: Theme.of(context).colorScheme.surface,
      child: ElevatedButton.icon(
        onPressed: () async {
          await Customersupport.sendEmail("body");
        },
        icon: const Icon(Icons.headset_mic_outlined),
        label: Text(
          S.of(context).contactSupport,
          style: GoogleFonts.cairo(fontSize: ScreenUtilsManager.s14),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.palette.kPrimary,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
