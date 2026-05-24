import 'package:citifix/core/function/customerSupport.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/Models/HelpModel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_faq/flutter_faq.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndTermsPageWorker extends StatelessWidget {
  const HelpAndTermsPageWorker({super.key});

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
            fontSize: ScreenUtilsManager.s18,
            color: context.palette.onSurface,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: context.palette.surface,
        foregroundColor: context.palette.onSurface,
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilsManager.w16,
          vertical: ScreenUtilsManager.h20,
        ),
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
                  start: ScreenUtilsManager.w8,
                  top: ScreenUtilsManager.h15,
                  bottom: ScreenUtilsManager.h10,
                ),
                child: Text(
                  category,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s16,
                    fontWeight: FontWeight.bold,
                    color: context.palette.workerprimary,
                  ),
                ),
              ),
              ...items.map(
                (item) => Padding(
                  padding: EdgeInsets.only(bottom: ScreenUtilsManager.h8),
                  child: FAQ(
                    question: item.question,
                    answer: item.answer,
                    showDivider: false,
                    ansDecoration: BoxDecoration(
                      color: context.palette.surface,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r12,
                      ),
                    ),
                    queDecoration: BoxDecoration(
                      color: context.palette.surface,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r12,
                      ),
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
              SizedBox(height: ScreenUtilsManager.h10),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildContactBar(context),
    );
  }

  Widget _buildContactBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.h20),
      color: context.palette.surface,
      child: ElevatedButton.icon(
        onPressed: () async {
          await Customersupport.sendEmail("body");
        },
        icon: Icon(Icons.headset_mic_outlined, size: ScreenUtilsManager.s20),
        label: Text(
          S.of(context).contactSupport,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s14,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: context.palette.workerprimary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: Size(double.infinity, ScreenUtilsManager.h50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          ),
        ),
      ),
    );
  }
}
