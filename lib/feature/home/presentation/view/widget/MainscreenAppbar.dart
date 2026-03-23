import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/notication/notifaction.dart';
import 'package:citifix/feature/notication/presentation/manager/cubit/notifcation_cubit.dart';
import 'package:citifix/feature/notication/presentation/manager/cubit/notifcation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class MainscreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  const MainscreenAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManger.reportsPageBackground,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: Border(
        bottom: BorderSide(color: Colors.grey.withOpacity(0.15), width: 1),
      ),
      automaticallyImplyLeading: false,
      toolbarHeight: ScreenUtilsManager.h61,
      titleSpacing: ScreenUtilsManager.w16,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetValueManager.citifixicon,
            width: ScreenUtilsManager.w32,
            height: ScreenUtilsManager.h32,
          ),
          SizedBox(width: ScreenUtilsManager.w8),
          Text(
            Constantmanger.apptitle,
            style: GoogleFonts.publicSans(
              color: ColorManger.kPrimaryDark,
              fontWeight: FontWeight.w800,
              fontSize: ScreenUtilsManager.s20,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      actions: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationCenter(),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilsManager.w8),
              child: BlocBuilder<NotificationCubit, NotificationState>(
                builder: (context, state) {
                  
                  int unreadCount = 0;
                  if (state is NotificationLoaded) {
                    unreadCount = state.notifications
                        .where((e) => !e.isRead)
                        .length;
                  }

                  if (unreadCount > 0) {
                    return Badge(
                      label: Text('$unreadCount'),
                      smallSize: 15,
                      largeSize: 20,
                      textColor: Colors.white,
                      backgroundColor: Colors.redAccent,
                      offset: const Offset(2, 1),
                      child: Lottie.asset(
                        AssetValueManager.Notificationbell,
                        width: 40,
                        height: 40,
                      ),
                    );
                  }

                  return Icon(
                    Icons.notifications_none_rounded,

                    size: 28,
                    color: ColorManger.kPrimaryDark.withOpacity(0.7),
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(width: ScreenUtilsManager.w12),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ScreenUtilsManager.h61);
}
