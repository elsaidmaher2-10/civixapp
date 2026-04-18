import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customShimerwidget.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/pageCheckverfiaction.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerCard extends StatelessWidget {
  final bool isVerified;
  final String name;
  final String imageUrl;

  const WorkerCard({
    super.key,
    required this.isVerified,
    required this.name,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: context.palette.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
          side: BorderSide(color: context.palette.onSurface.withOpacity(0.05)),
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilsManager.w16),
          child: Column(
            children: [
              Row(
                children: [
                  _buildWorkerImage(),
                  SizedBox(width: ScreenUtilsManager.w16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildNameAndBadge(context),
                        SizedBox(height: ScreenUtilsManager.h4),
                        _buildVerificationBadge(context),
                        SizedBox(height: ScreenUtilsManager.h6),
                        _buildOnlineStatus(context),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isVerified) ...[
                SizedBox(height: ScreenUtilsManager.h20),
                _buildVerifyButton(context),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWorkerImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: ScreenUtilsManager.w64,
        height: ScreenUtilsManager.h64,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            customShimer(context, ScreenUtilsManager.h64),
        errorWidget: (context, url, error) =>
            Icon(Icons.person, size: ScreenUtilsManager.s40),
      ),
    );
  }

  Widget _buildNameAndBadge(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            name,
            textScaler: TextScaler.noScaling,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s20,
              fontWeight: FontWeight.bold,
              color: context.palette.onSurface,
            ),
          ),
        ),
        if (isVerified) ...[
          SizedBox(width: ScreenUtilsManager.w5),
          SvgPicture.asset(
            "assets/verified-symbol-icon.svg",
            width: ScreenUtilsManager.w20,
          ),
        ],
      ],
    );
  }

  Widget _buildVerificationBadge(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.h8,
        vertical: ScreenUtilsManager.w2,
      ),
      child: Text(
        isVerified ? S.of(context).verified : S.of(context).pending,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s10,
          fontWeight: FontWeight.w700,
          color: isVerified ? context.palette.green : context.palette.orange,
        ),
      ),
    );
  }

  Widget _buildOnlineStatus(BuildContext context) {
    return Row(
      children: [
        Container(
          width: ScreenUtilsManager.w8,
          height: ScreenUtilsManager.h8,
          decoration: BoxDecoration(
            color: context.palette.green,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: ScreenUtilsManager.w6),
        Text(
          S.of(context).online,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s14,
            color: context.palette.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildVerifyButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtilsManager.h44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF954400), Color(0xFFFF7B04)],
          ),
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) =>
                      VerificationInitCubit(getIt<VerficationInitRepo>()),
                  child: const pageCheckVerication(),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
            ),
          ),
          child: Text(
            S.of(context).verifyNow,
            style: GoogleFonts.cairo(
              fontSize: ScreenUtilsManager.s16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
