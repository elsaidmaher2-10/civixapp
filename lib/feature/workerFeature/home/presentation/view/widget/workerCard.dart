import 'package:cached_network_image/cached_network_image.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customShimerwidget.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart';
import 'package:flutter/material.dart';

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
        color: ColorManger.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtilsManager.r14),
          side: BorderSide(color: ColorManger.onSurface.withOpacity(0.05)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: ScreenUtilsManager.w64,
                      height: ScreenUtilsManager.h64,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          customShimer(ScreenUtilsManager.h64),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.person, size: ScreenUtilsManager.s40),
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: ScreenUtilsManager.s20,
                          fontWeight: FontWeight.bold,
                          color: ColorManger.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      _buildVerificationBadge(),
                      const SizedBox(height: 6),
                      _buildOnlineStatus(),
                    ],
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

  Widget _buildVerificationBadge() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.h8,
        vertical: ScreenUtilsManager.w2,
      ),
      decoration: BoxDecoration(
        color: (isVerified ? ColorManger.green : ColorManger.orange)
            .withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        isVerified ? Constantmanger.VERIFIED : Constantmanger.Pending,
        style: TextStyle(
          fontSize: ScreenUtilsManager.s10,
          fontWeight: FontWeight.w700,
          color: isVerified ? ColorManger.green : ColorManger.orange,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildOnlineStatus() {
    return Row(
      children: [
        Container(
          width: ScreenUtilsManager.w8,
          height: ScreenUtilsManager.h8,
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: ScreenUtilsManager.w6),
        Text(
          Constantmanger.Online,
          style: TextStyle(
            fontSize: ScreenUtilsManager.s14,
            color: ColorManger.onSurfaceVariant,
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
                builder: (context) => GlobalGateVerificationPage(),
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
            Constantmanger.verifynow,
            style: TextStyle(
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
