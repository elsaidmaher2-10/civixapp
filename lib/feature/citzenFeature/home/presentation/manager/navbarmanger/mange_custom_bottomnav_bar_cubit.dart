import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/achievment.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/Homeview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../reports/data/repos/reports/reports.dart';
import '../../../../reports/presentation/manager/achievement/achivementManger.dart';

part 'mange_custom_bottomnav_bar_state.dart';

class MangeCustomBottomnavBarCubit extends Cubit<MangeCustomBottomnavBarState> {
  MangeCustomBottomnavBarCubit() : super(MangeCustomBottomnavBarInitial());
  int curindex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    BlocProvider(
      create: (_) =>
          AchievementCubit(getIt<ReportRepositoryT>())..getAchievements(),
      child: AchievemrntReportScreen(),
    ),
    ProfileScreen(),
  ];

  void ontap(int newindex) {
    curindex = newindex;
    if (curindex == 2) {
      PrefrenceManager().setbool("isvisit", true);
    }
    emit(MangeCustomBottomnavBarChange(curindex));
  }

  Widget CurScreen() {
    return _screens[curindex];
  }
}
