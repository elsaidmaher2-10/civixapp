import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSnakeNavbar extends StatelessWidget {
  const CustomSnakeNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      MangeCustomBottomnavBarCubit,
      MangeCustomBottomnavBarState
    >(
      builder: (context, state) {
        final int currentIndex = state is MangeCustomBottomnavBarChange
            ? state.index
            : 0;

        final List<BottomNavigationBarItem> navItems = [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_rounded),
            label: S.of(context).home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.stars_rounded),
            label: S.of(context).achievement,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_rounded),
            label: S.of(context).profile,
          ),
        ];

        return SnakeNavigationBar.color(
          unselectedLabelStyle: GoogleFonts.cairo(),
          selectedLabelStyle: GoogleFonts.cairo(),
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.rectangle,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          snakeViewColor: ColorManger.kPrimary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blueGrey,
          backgroundColor: ColorManger.reportsPageBackground,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          currentIndex: currentIndex,
          onTap: (index) {
            context.read<MangeCustomBottomnavBarCubit>().ontap(index);
          },
          items: navItems,
        );
      },
    );
  }
}
