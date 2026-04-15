import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/verficationinitState.dart';
import 'package:citifix/feature/workerFeature/verfication/data/model/worker_verification_model.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationRequestsScreen extends StatefulWidget {
  const VerificationRequestsScreen({super.key});

  @override
  State<VerificationRequestsScreen> createState() =>
      _VerificationRequestsScreenState();
}

class _VerificationRequestsScreenState
    extends State<VerificationRequestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VerificationInitCubit>().fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      appBar: AppBar(
        leading: IconButton(
          color: ColorManger.workerprimary,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          s.verificationRequestsTitle,
          style: GoogleFonts.cairo(
            fontWeight: FontWeight.bold,
            color: ColorManger.workerprimary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<VerificationInitCubit>().fetchRequests(),
            icon: const Icon(Icons.refresh, color: ColorManger.workerprimary),
          ),
        ],
      ),
      body: BlocBuilder<VerificationInitCubit, VerificationInitState>(
        builder: (context, state) {
          if (state is VerificationRequestsLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: ScreenUtilsManager.r12,
                color: ColorManger.inProgressContainer,
              ),
            );
          } else if (state is VerificationRequestsError) {
            return _buildErrorState(state.message);
          } else if (state is VerificationRequestsSuccess) {
            if (state.requests.isEmpty) return _buildEmptyState(s);
            return _buildListView(state.requests, s);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildListView(List<WorkerVerificationModel> requests, S s) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.p16,
        vertical: ScreenUtilsManager.p12,
      ),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final item = requests[index];
        return _buildEnhancedCard(item, s, context);
      },
    );
  }

  Widget _buildEnhancedCard(
    WorkerVerificationModel item,
    S s,
    BuildContext context,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilsManager.w20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r20),
        child: Column(
          children: [
            Container(
              height: 4,
              color: _getStatusColor(item.status.name).withOpacity(0.5),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenUtilsManager.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: ColorManger.bgbackground,
                        backgroundImage: item.workerProfileImageUrl.isNotEmpty
                            ? NetworkImage(item.workerProfileImageUrl)
                            : null,
                        child: item.workerProfileImageUrl.isEmpty
                            ? Icon(Icons.person, color: ColorManger.textGrey)
                            : null,
                      ),
                      SizedBox(width: ScreenUtilsManager.p12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.workerName,
                              style: GoogleFonts.cairo(
                                fontSize: ScreenUtilsManager.s16,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                            ),
                            Text(
                              "${item.id}",
                              style: GoogleFonts.cairo(
                                color: ColorManger.textGrey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusBadge(context, item.status.name, s),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(thickness: 0.5),
                  ),
                  _buildIconInfoRow(
                    Icons.business_center_rounded,
                    item.departmentName,
                    Colors.blue,
                  ),
                  SizedBox(height: ScreenUtilsManager.p8),
                  _buildIconInfoRow(
                    Icons.location_on_rounded,
                    item.areaName,
                    Colors.redAccent,
                  ),
                  SizedBox(height: ScreenUtilsManager.p8),
                  _buildIconInfoRow(
                    Icons.access_time_filled_rounded,
                    DateFormat.yMMMd(
                      Localizations.localeOf(context).languageCode,
                    ).add_jm().format(item.submittedAt),
                    Colors.orange,
                  ),

                  if (item.rejectionReason != null)
                    _buildRejectionBox(item.rejectionReason!, s),

                  SizedBox(height: ScreenUtilsManager.w20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        SizedBox(width: ScreenUtilsManager.p10),
        Text(
          text,
          style: GoogleFonts.cairo(fontSize: 13, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildRejectionBox(String reason, S s) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.red, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "${s.rejectionReasonLabel}: $reason",
              style: GoogleFonts.cairo(
                color: Colors.red.shade800,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatusBadge(BuildContext context, String status, S s) {
    final color = _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: GoogleFonts.cairo(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off_rounded, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.cairo(fontSize: 16, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () =>
                context.read<VerificationInitCubit>().fetchRequests(),
            child: Text(S.of(context).tryAgain, style: GoogleFonts.cairo()),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(S s) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.auto_awesome_motion_rounded,
            size: 80,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            "All caught up!",
            style: GoogleFonts.cairo(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "No pending requests at the moment",
            style: GoogleFonts.cairo(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
