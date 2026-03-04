import 'package:bloc/bloc.dart';
import 'package:citifix/feature/home/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/home/presentation/view/ReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/widget/Homeview.dart';
import 'package:flutter/cupertino.dart';

part 'mange_custom_bottomnav_bar_state.dart';

class MangeCustomBottomnavBarCubit extends Cubit<MangeCustomBottomnavBarState> {
  MangeCustomBottomnavBarCubit() : super(MangeCustomBottomnavBarInitial());
  int _curindex = 0;
  final List<Widget> _screens = [HomeScreen(), ReportScreen(), ProfileScreen()];

  ontap(int newindex) {
    _curindex = newindex;
    emit(MangeCustomBottomnavBarChange(_curindex));
  }

  Widget CurScreen() {
    return _screens[_curindex];
  }
}
