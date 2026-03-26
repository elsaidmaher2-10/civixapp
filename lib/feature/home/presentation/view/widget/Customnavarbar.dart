import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class CustomWaternavbar extends StatelessWidget {
  const CustomWaternavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. تحديد هل اللغة الحالية هي العربية
    final bool isRtl = Localizations.localeOf(context).languageCode == 'ar';

    // العناصر الأساسية
    final List<BarItem> originalItems = [
      BarItem(
        filledIcon: Icons.home_rounded,
        outlinedIcon: Icons.home_outlined,
      ),
      BarItem(
        filledIcon: Icons.stars_rounded,
        outlinedIcon: Icons.stars_outlined,
      ),
      BarItem(
        filledIcon: Icons.person_rounded,
        outlinedIcon: Icons.person_outline_rounded,
      ),
    ];

    return BlocBuilder<
      MangeCustomBottomnavBarCubit,
      MangeCustomBottomnavBarState
    >(
      builder: (context, state) {
        final int currentIndex = state is MangeCustomBottomnavBarChange
            ? state.index
            : 0;
        final int itemsCount = originalItems.length;

        // 2. عكس الـ Index حسابياً للقطرة فقط في حالة العربي
        // إذا كان currentIndex هو 0 (Home) في العربي يكون ترتيبه برمجياً 2 بالنسبة للمكتبة
        final int semanticIndex = isRtl
            ? (itemsCount - 1 - currentIndex)
            : currentIndex;

        return Container(
          color: ColorManger.reportsPageBackground,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Divider(
                  height: 0.5,
                  thickness: 0.5,
                  color: ColorManger.lightGrey2,
                ),

                Directionality(
                  textDirection: TextDirection.ltr,
                  child: WaterDropNavBar(
                    bottomPadding: 8.h,
                    waterDropColor: ColorManger.kPrimary,
                    backgroundColor: ColorManger.reportsPageBackground,
                    onItemSelected: (index) {
                      int actualTappedIndex = isRtl
                          ? (itemsCount - 1 - index)
                          : index;
                      context.read<MangeCustomBottomnavBarCubit>().ontap(
                        actualTappedIndex,
                      );
                    },
                    barItems: isRtl
                        ? originalItems.reversed.toList()
                        : originalItems,
                    selectedIndex: semanticIndex,
                  ),
                ),

                Padding(
                  padding: EdgeInsetsGeometry.directional(
                    start: 2.w,
                    bottom: 8.h,
                    end: 4.w,
                  ),
                  child: Row(
                    children: [
                      _buildLabel(
                        context,
                        S.of(context).home,
                        currentIndex == 0,
                      ),
                      _buildLabel(
                        context,
                        S.of(context).achievement,
                        currentIndex == 1,
                      ),
                      _buildLabel(
                        context,
                        S.of(context).profile,
                        currentIndex == 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLabel(BuildContext context, String text, bool isSelected) {
    return Expanded(
      child: Center(
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            fontSize: ScreenUtilsManager.s11,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? ColorManger.kPrimary : Colors.grey.shade600,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
