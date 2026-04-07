import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationCompleteScreen extends StatelessWidget {
  VerificationCompleteScreen({
    super.key,
    required WorkerRequestModel this.workerRequestModel,
  });
  WorkerRequestModel workerRequestModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: ColorManger.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilsManager.s24,
            vertical: ScreenUtilsManager.s40,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildSuccessHero(context),
                  const SizedBox(height: ScreenUtilsManager.s48),
                  _buildSummaryGrid(context),
                  SizedBox(height: ScreenUtilsManager.s16),
                  _buildStatusDetails(context),
                  SizedBox(height: ScreenUtilsManager.s32),
                  SizedBox(height: ScreenUtilsManager.s40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManger.background.withOpacity(0.9),
      elevation: ScreenUtilsManager.s0,
      surfaceTintColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(ScreenUtilsManager.s1),
        child: Container(
          color: ColorManger.surfaceVariant,
          height: ScreenUtilsManager.s1,
        ),
      ),
      title: Row(
        children: [
          const Icon(Icons.location_city, color: ColorManger.workerprimary),
          SizedBox(width: ScreenUtilsManager.s12),
          Text(
            S.of(context).appTitle,
            style: GoogleFonts.cairo(
              color: ColorManger.onSurface,
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtilsManager.s18,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          width: ScreenUtilsManager.s36,
          height: ScreenUtilsManager.s36,
          margin: EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: ColorManger.surfaceContainerHigh,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.menu,
            size: ScreenUtilsManager.s20,
            color: ColorManger.workerprimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessHero(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: ScreenUtilsManager.s120,
              height: ScreenUtilsManager.s120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManger.success.withOpacity(0.4),
                boxShadow: [
                  BoxShadow(
                    color: ColorManger.success.withOpacity(0.2),
                    blurRadius: ScreenUtilsManager.s40,
                    spreadRadius: ScreenUtilsManager.s20,
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtilsManager.s96,
              height: ScreenUtilsManager.s96,
              decoration: BoxDecoration(
                color: ColorManger.success.withOpacity(1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: ScreenUtilsManager.s10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_circle,
                color: ColorManger.white,
                size: ScreenUtilsManager.s56,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtilsManager.s32),
        Text(
          S.of(context).verificationComplete,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s32,
            fontWeight: FontWeight.w800,
            color: ColorManger.onSurface,
            height: 1.2,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.s16),
        SizedBox(
          width: 280,
          child: Text(
            S.of(context).verificationSuccessDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s16,
              color: ColorManger.secondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            label: S.of(context).confirmedZone,
            value: workerRequestModel.areaName,

            icon: Icons.location_on,
          ),
        ),
        SizedBox(width: ScreenUtilsManager.s16),
        Expanded(
          child: _buildInfoCard(
            label: S.of(context).department,
            value: workerRequestModel.departmentName,
            icon: Icons.domain,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.s20),
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.s16),
        border: Border.all(color: ColorManger.surfaceVariant.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s10,
              fontWeight: FontWeight.w700,
              color: ColorManger.secondary,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: ScreenUtilsManager.s12),
          Row(
            children: [
              Icon(
                icon,
                color: ColorManger.workerprimary,
                size: ScreenUtilsManager.s22,
              ),
              const SizedBox(width: ScreenUtilsManager.s8),
              Expanded(
                child: Text(
                  value,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s18,
                    fontWeight: FontWeight.bold,
                    color: ColorManger.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ScreenUtilsManager.s20),
      decoration: BoxDecoration(
        color: ColorManger.surfaceContainerLow,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.s16),
        border: Border.all(color: ColorManger.surfaceVariant.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: ScreenUtilsManager.s44,
            height: ScreenUtilsManager.s44,
            decoration: BoxDecoration(
              color: ColorManger.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: ScreenUtilsManager.s8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.badge_outlined,
              color: ColorManger.workerprimary,
              size: ScreenUtilsManager.s22,
            ),
          ),
          SizedBox(width: ScreenUtilsManager.s16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).digitalIdIssued,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s16,
                    fontWeight: FontWeight.w700,
                    color: ColorManger.onSurface,
                  ),
                ),
                const SizedBox(height: ScreenUtilsManager.s2),
                Text(
                  S.of(context).expiresDate,
                  style: GoogleFonts.cairo(
                    fontSize: ScreenUtilsManager.s12,
                    color: ColorManger.secondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: ColorManger.secondary.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}
