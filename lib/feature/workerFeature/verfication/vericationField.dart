import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/profile/helpterms.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart';
import 'package:flutter/material.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationFailedScreen extends StatelessWidget {
  const VerificationFailedScreen({super.key, required this.workerRequestModel});
  final WorkerRequestModel workerRequestModel;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: context.palette.surface,
      appBar: _buildAppBar(context, s),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              context.palette.surface,
              context.palette.reportsPageBackground,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.w24,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: ScreenUtilsManager.h20),
                      _buildHeroSection(s, context),
                      SizedBox(height: ScreenUtilsManager.h32),
                      _buildReasonCard(context, s),
                      SizedBox(height: ScreenUtilsManager.h24),
                    ],
                  ),
                ),
              ),
              _buildBottomActions(context, s),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, S s) {
    return AppBar(
      backgroundColor: context.palette.surface,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          padding: EdgeInsets.all(ScreenUtilsManager.w8),
          decoration: BoxDecoration(
            color: context.palette.surfaceContainerHigh,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.close,
            color: context.palette.onSurface,
            size: ScreenUtilsManager.s20,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        s.appTitle,
        style: GoogleFonts.cairo(
          color: context.palette.onSurface,
          fontWeight: FontWeight.w800,
          fontSize: ScreenUtilsManager.s16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHeroSection(S s, BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: ScreenUtilsManager.h140,
              width: ScreenUtilsManager.h140,
              decoration: BoxDecoration(
                color: context.palette.red.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: ScreenUtilsManager.h110,
              width: ScreenUtilsManager.h110,
              decoration: BoxDecoration(
                color: context.palette.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: EdgeInsets.all(ScreenUtilsManager.w20),
              decoration: BoxDecoration(
                color: context.palette.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.palette.red.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.priority_high_rounded,
                color: Colors.white,
                size: ScreenUtilsManager.s48,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtilsManager.h24),
        Text(
          s.verificationFailed,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s24,
            fontWeight: FontWeight.w900,
            color: context.palette.onSurface,
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h12),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w20),
          child: Text(
            s.verificationFailedDesc,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s15,
              color: context.palette.onSurfaceVariant,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReasonCard(BuildContext context, S s) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ScreenUtilsManager.w24),
      decoration: BoxDecoration(
        color: context.palette.surface,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        border: Border.all(color: context.palette.outline.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: context.palette.red,
                size: ScreenUtilsManager.s22,
              ),
              SizedBox(width: ScreenUtilsManager.w10),
              Text(
                s.attentionRequired.toUpperCase(),
                style: GoogleFonts.cairo(
                  fontSize: ScreenUtilsManager.s13,
                  fontWeight: FontWeight.w800,
                  color: context.palette.red,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtilsManager.h16),
            child: Divider(color: context.palette.outline.withOpacity(0.2)),
          ),
          Text(
            workerRequestModel.rejectionReason ?? s.errorIdNotClear,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s15,
              color: context.palette.onSurface.withOpacity(0.8),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, S s) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        ScreenUtilsManager.w24,
        ScreenUtilsManager.h16,
        ScreenUtilsManager.w24,
        ScreenUtilsManager.h32,
      ),
      decoration: BoxDecoration(
        color: context.palette.surface,
        boxShadow: [
          BoxShadow(
            color: context.palette.shadow,
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        VerificationInitCubit(getIt<VerficationInitRepo>()),
                    child: const VerificationInit(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.palette.workerprimary,
              minimumSize: Size(double.infinity, ScreenUtilsManager.h56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
              ),
              elevation: 0,
            ),
            child: Text(
              s.resubmit,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: ScreenUtilsManager.h12),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => HelpAndTermsPageWorker()),
              );
            },
            style: TextButton.styleFrom(
              minimumSize: Size(double.infinity, ScreenUtilsManager.h50),
            ),
            child: Text(
              s.needHelp,
              style: GoogleFonts.cairo(
                fontSize: ScreenUtilsManager.s15,
                fontWeight: FontWeight.w700,
                color: context.palette.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
