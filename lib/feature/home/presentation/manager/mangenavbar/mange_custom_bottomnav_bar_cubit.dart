import 'package:bloc/bloc.dart';
import 'package:citifix/feature/home/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/home/presentation/view/ReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/widget/Homeview.dart';
import 'package:flutter/cupertino.dart';

part 'mange_custom_bottomnav_bar_state.dart';

class MangeCustomBottomnavBarCubit extends Cubit<MangeCustomBottomnavBarState> {
  MangeCustomBottomnavBarCubit() : super(MangeCustomBottomnavBarInitial());
  int curindex = 0;
  final List<Widget> _screens = [HomeScreen(), ReportScreen(), ProfileScreen()];

  ontap(int newindex) {
    curindex = newindex;
    emit(MangeCustomBottomnavBarChange(curindex));
  }

  Widget CurScreen() {
    return _screens[curindex];
  }
}
