import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/resource/assetvaluemanger.dart';
import '../../../citzenFeature/notication/notifaction.dart';
import '../../../citzenFeature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import '../../../citzenFeature/notication/presentation/manager/cubit/notifcation_state.dart';

class TasksHeader extends StatelessWidget {
  const TasksHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              S.of(context).tasks,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w800,
                fontSize: ScreenUtilsManager.s32,
                color: context.palette.onSurface,
                letterSpacing: -1,
              ),
            ),
            const Spacer(),
            BlocBuilder<NotificationCubit, NotificationState>(
              buildWhen: (previous, current) => current is NotificationLoaded,
              builder: (context, state) {
                int unreadCount = 0;
                if (state is NotificationLoaded) {
                  unreadCount = state.notifications
                      .where((e) => !e.isRead)
                      .length;
                }
                return Padding(
                  padding: EdgeInsets.only(right: ScreenUtilsManager.w12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationCenter(),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(
                        ScreenUtilsManager.r12,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtilsManager.w8),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                              child: unreadCount > 0
                                  ? Lottie.asset(
                                      AssetValueManager.Notificationbell,
                                      key: const ValueKey('lottie_bell'),
                                      width: ScreenUtilsManager.s28,
                                      height: ScreenUtilsManager.s28,
                                    )
                                  : Icon(
                                      Icons.notifications_none_rounded,
                                      key: const ValueKey('icon_bell'),
                                      size: ScreenUtilsManager.s26,
                                      color: context.palette.onSurface
                                          .withValues(alpha: 0.85),
                                    ),
                            ),

                            if (unreadCount > 0)
                              Positioned(
                                right: -4,
                                top: -4,
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.elasticOut,
                                  builder: (context, scale, child) {
                                    return Transform.scale(
                                      scale: scale,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 2,
                                        ),
                                        constraints: BoxConstraints(
                                          minWidth: ScreenUtilsManager.r18,
                                          minHeight: ScreenUtilsManager.r18,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              context.palette.notificationRedStart,
                                              context.palette.notificationRedEnd,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            ScreenUtilsManager.r10,
                                          ),
                                          border: Border.all(
                                            color: context.palette.white,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: context.palette.black
                                                  .withOpacity(0.15),
                                              blurRadius: 4,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            unreadCount > 9
                                                ? '9+'
                                                : '$unreadCount',
                                            style: GoogleFonts.cairo(
                                              color: context.palette.white,
                                              fontSize: ScreenUtilsManager.s9,
                                              fontWeight: FontWeight.bold,
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Text(
          S.of(context).tasksSubtitle,
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s15,
            color: context.palette.onSurfaceVariant.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
