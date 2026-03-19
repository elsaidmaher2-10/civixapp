import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class CustomWaternavbar extends StatelessWidget {
  const CustomWaternavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      MangeCustomBottomnavBarCubit,
      MangeCustomBottomnavBarState
    >(
      builder: (BuildContext context, state) => Padding(
        padding: EdgeInsets.only(bottom: 6.h, top: 0.h),
        child: Wrap(
          children: [
            Container(
              height: 0.4,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: ColorManger.lightGrey2)],
              ),
            ),
            WaterDropNavBar(
              bottomPadding: 0,
              waterDropColor: ColorManger.kPrimary,
              backgroundColor: ColorManger.reportsPageBackground,
              onItemSelected: (index) {
                context.read<MangeCustomBottomnavBarCubit>().ontap(index);
              },
              barItems: [
                BarItem(
                  filledIcon: Icons.home,
                  outlinedIcon: CupertinoIcons.home,
                ),
                BarItem(
                  filledIcon: Icons.star,
                  outlinedIcon: Icons.star_border_outlined,
                ),
                BarItem(
                  filledIcon: CupertinoIcons.person_fill,
                  outlinedIcon: CupertinoIcons.person,
                ),
              ],
              selectedIndex: state is MangeCustomBottomnavBarChange
                  ? state.index
                  : 0,
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 46.h,
                vertical: 5.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: ScreenUtilsManager.s12,

                      color: state is MangeCustomBottomnavBarChange
                          ? state.index == 0
                                ? ColorManger.kPrimary
                                : Colors.black
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Achievement",
                    style: TextStyle(
                      fontSize: ScreenUtilsManager.s12,
                      color: state is MangeCustomBottomnavBarChange
                          ? state.index == 1
                                ? ColorManger.kPrimary
                                : Colors.black
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: ScreenUtilsManager.s12,
                      color: state is MangeCustomBottomnavBarChange
                          ? state.index == 2
                                ? ColorManger.kPrimary
                                : Colors.black
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
