import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/profile/helpterms.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/WorkerRequestModel.dart';
import 'package:citifix/feature/workerFeature/verfication/data/repo/VerficationInitRepo.dart';
import 'package:citifix/feature/workerFeature/verfication/verficationinit.dart';
import 'package:flutter/material.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationFailedScreen extends StatelessWidget {
  const VerificationFailedScreen({super.key, required this.workerRequestModel});
  final WorkerRequestModel workerRequestModel;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      // Gradient background for a more modern feel
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context, s),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _buildHeroSection(s),
                      const SizedBox(height: 32),
                      _buildReasonCard(context, s),
                      const SizedBox(height: 24),
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
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.close, color: Colors.black87, size: 20),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        s.appTitle,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w800,
          fontSize: 16,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildHeroSection(S s) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Soft animated-like pulses
            Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.priority_high_rounded,
                color: Colors.white,
                size: 48,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          s.verificationFailed,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            s.verificationFailedDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
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
            children: [
              Icon(
                Icons.info_outline_rounded,
                color: Colors.red.shade400,
                size: 22,
              ),
              const SizedBox(width: 10),
              Text(
                s.attentionRequired.toUpperCase(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.red.shade700,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Divider(),
          ),
          Text(
            workerRequestModel.rejectionReason ?? s.errorIdNotClear,
            style: const TextStyle(
              fontSize: 15,
              color: Color(0xFF424242),
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
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        VerificationInitCubit(getIt<VerficationInitRepo>()),
                    child: const VerificationInit(),
                  ),
                ),
                (route) => route.isFirst,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.palette.workerprimary,
              minimumSize: const Size(double.infinity, 58),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              s.resubmit,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => HelpAndTermsPageWorker()),
              );
            },
            style: TextButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              s.needHelp,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
