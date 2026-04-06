import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: ColorManger.bgBackground,
      appBar: _buildAppBar(context, s),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.p24,
            vertical: ScreenUtilsManager.p32,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildHeaderSection(context, s),
                  SizedBox(height: ScreenUtilsManager.p24),
                  _buildSummarySection(context, s),
                  SizedBox(height: ScreenUtilsManager.p24),
                  _buildWhatsNextSection(context, s),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, S s) {
    return AppBar(
      backgroundColor: ColorManger.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: ColorManger.border, height: 1),
      ),
      title: Row(
        children: [
          Icon(Icons.location_city, color: ColorManger.workerprimary),
          SizedBox(width: ScreenUtilsManager.p8),
          Text(
            s.appTitle,
            style: GoogleFonts.cairo(
              color: ColorManger.textDark,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: ScreenUtilsManager.p24),
          child: Text(
            s.verification,
            style: GoogleFonts.cairo(
              color: ColorManger.workerprimary,
              fontWeight: FontWeight.w600,
              fontSize: ScreenUtilsManager.s16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection(BuildContext context, S s) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: ColorManger.workerprimary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.schedule,
            size: ScreenUtilsManager.icon48,
            color: ColorManger.workerprimary,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p24),
        Text(
          s.underReview,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s32,
            fontWeight: FontWeight.w800,
            color: ColorManger.textDark,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p12),
        Text(
          s.reviewDesc,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s16,
            color: ColorManger.textGrey,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSummarySection(BuildContext context, S s) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.p32),
          decoration: BoxDecoration(
            color: ColorManger.white,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    s.submissionSummary,
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s20,
                      fontWeight: FontWeight.bold,
                      color: ColorManger.textDark,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtilsManager.p12,
                      vertical: ScreenUtilsManager.p8 / 2,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManger.workerprimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r16,
                      ),
                    ),
                    child: Text(
                      s.inProgress,
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s10,
                        fontWeight: FontWeight.bold,
                        color: ColorManger.workerprimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilsManager.p32),

              Wrap(
                spacing: ScreenUtilsManager.p24,
                runSpacing: ScreenUtilsManager.p24,
                children: [
                  SizedBox(
                    width: 250,
                    child: Column(
                      children: [
                        _buildInfoField(
                          s.accessZone,
                          "Tier 1 • High Security Data Center",
                        ),
                        SizedBox(height: ScreenUtilsManager.p16),
                        _buildInfoField(
                          s.department,
                          "Infrastructure & Operations",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.identityDocs,
                          style: GoogleFonts.cairo(
                            fontSize: ScreenUtilsManager.s10,
                            fontWeight: FontWeight.bold,
                            color: ColorManger.textGrey,
                            letterSpacing: 1.2,
                          ),
                        ),
                        SizedBox(height: ScreenUtilsManager.p8),
                        Row(
                          children: [
                            Expanded(child: _buildDocumentPlaceholder()),
                            SizedBox(width: ScreenUtilsManager.p12),
                            Expanded(child: _buildDocumentPlaceholder()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Positioned.fill(
          child: Container(color: ColorManger.bgbackground.withOpacity(0.5)),
        ),
      ],
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s10,
            fontWeight: FontWeight.bold,
            color: ColorManger.textGrey,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.p8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ScreenUtilsManager.p16),
          decoration: BoxDecoration(
            color: ColorManger.white,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
            border: Border.all(color: ColorManger.border),
          ),
          child: Text(
            value,
            style: GoogleFonts.cairo(
              fontWeight: FontWeight.w600,
              color: ColorManger.textDark,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentPlaceholder() {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
          border: Border.all(color: ColorManger.border),
        ),
        child: Icon(Icons.visibility_off, color: ColorManger.textGrey),
      ),
    );
  }

  Widget _buildWhatsNextSection(BuildContext context, S s) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.p24),
      decoration: BoxDecoration(
        color: ColorManger.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r24),
        border: Border.all(color: ColorManger.border),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ScreenUtilsManager.p12),
            decoration: BoxDecoration(
              color: ColorManger.workerprimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            ),
            child: Icon(Icons.info_outline, color: ColorManger.workerprimary),
          ),
          SizedBox(width: ScreenUtilsManager.p16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.whatsNext,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s16,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.textDark,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.p8 / 2),
                Text(
                  s.whatsNextDesc,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s14,
                    color: ColorManger.textGrey,
                    height: 1.5,
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
