import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
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
              'Tasks',
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.w800,
                fontSize: ScreenUtilsManager.s32,
                color: ColorManger.onSurface,
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
                      borderRadius: BorderRadius.circular(12),
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
                                      width: 28,
                                      height: 28,
                                    )
                                  : Icon(
                                      Icons.notifications_none_rounded,
                                      key: const ValueKey('icon_bell'),
                                      size: 26,
                                      color: ColorManger.kPrimaryDark
                                          .withOpacity(0.7),
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
                                        constraints: const BoxConstraints(
                                          minWidth: 18,
                                          minHeight: 18,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xffFF5252),
                                              Color(0xffFF1744),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 1.5,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(
                                                0.15,
                                              ),
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
                                              color: Colors.white,
                                              fontSize: 9,
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
          'Keep track of your daily progress',
          style: GoogleFonts.cairo(
            fontSize: ScreenUtilsManager.s15,
            color: ColorManger.onSurfaceVariant.withOpacity(0.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
