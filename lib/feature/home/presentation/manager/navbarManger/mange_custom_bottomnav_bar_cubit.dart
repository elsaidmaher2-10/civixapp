import 'package:bloc/bloc.dart';
import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/feature/Profile/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/reports/presentation/views/ReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/Homeview.dart';
import 'package:flutter/cupertino.dart';

part 'mange_custom_bottomnav_bar_state.dart';

class MangeCustomBottomnavBarCubit extends Cubit<MangeCustomBottomnavBarState> {
  MangeCustomBottomnavBarCubit() : super(MangeCustomBottomnavBarInitial());
  int curindex = 0;
  final List<Widget> _screens = [HomeScreen(), ReportListingScreen(), ProfileScreen()];

  ontap(int newindex) {
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
