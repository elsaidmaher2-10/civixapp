import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/controller/homecontroller.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/workercardDashborad.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkerDashboard extends StatefulWidget {
  final DashBroadHome data;
  const WorkerDashboard({super.key, required this.data});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    double initialProgress = HomeDashboardLogic.calculateProgress(widget.data);
    animation = Tween<double>(begin: 0.0, end: initialProgress).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOutQuart),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) animationController.forward();
    });
  }

  @override
  void didUpdateWidget(covariant WorkerDashboard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.data.resolvedReports != oldWidget.data.resolvedReports ||
        widget.data.totalReports != oldWidget.data.totalReports) {
      double newProgress = HomeDashboardLogic.calculateProgress(widget.data);
      animation = Tween<double>(begin: animation.value, end: newProgress)
          .animate(
            CurvedAnimation(
              parent: animationController,
              curve: Curves.easeOutQuart,
            ),
          );

      animationController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildWorkerCard(
              label: S.of(context).resolved,
              value: HomeDashboardLogic.formatNumber(
                widget.data.resolvedReports,
              ),
            ),
            SizedBox(width: ScreenUtilsManager.w16),
            buildWorkerCard(
              label: S.of(context).assigned,
              value: HomeDashboardLogic.formatNumber(
                widget.data.assignedReports,
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtilsManager.h16),
        Container(
          padding: EdgeInsets.all(ScreenUtilsManager.h20),
          decoration: BoxDecoration(
            color: ColorManger.surfaceContainerLow,
            borderRadius: BorderRadius.circular(ScreenUtilsManager.r16),
            boxShadow: [
              BoxShadow(
                color: ColorManger.onSurface.withOpacity(0.04),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).inProgress,
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s11,
                          fontWeight: FontWeight.bold,
                          color: ColorManger.onSurfaceVariant,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        HomeDashboardLogic.formatNumber(
                          widget.data.inProgressReports,
                        ),
                        style: GoogleFonts.cairo(
                          fontSize: ScreenUtilsManager.s32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  _buildTrendIndicator(
                    '+${HomeDashboardLogic.calculateTrend(widget.data)}%',
                  ),
                ],
              ),

              SizedBox(height: ScreenUtilsManager.h16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL REPORTS: ${widget.data.totalReports}',
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s11,

                      fontWeight: FontWeight.bold,
                      color: ColorManger.onSurfaceVariant,
                    ),
                  ),
                  AnimatedBuilder(
                    animation: animation,
                    builder: (context, _) => Text(
                      'PROGRESS: ${(animation.value * 100).toInt()}%',
                      style: GoogleFonts.cairo(
                        fontSize: ScreenUtilsManager.s11,
                        fontWeight: FontWeight.bold,
                        color: ColorManger.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ScreenUtilsManager.h8),
              AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context, Widget? child) =>
                    LinearProgressIndicator(
                      value: animation.value,
                      backgroundColor: ColorManger.surfaceContainer,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorManger.primaryColor,
                      ),
                      minHeight: ScreenUtilsManager.h6,
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r8,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendIndicator(String text) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilsManager.w8,
        vertical: ScreenUtilsManager.h4,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r8),
      ),
      child: Text(
        text,
        style: GoogleFonts.cairo(
          fontSize: ScreenUtilsManager.s12,
          fontWeight: FontWeight.bold,
          color: Colors.green.shade700,
        ),
      ),
    );
  }
}
