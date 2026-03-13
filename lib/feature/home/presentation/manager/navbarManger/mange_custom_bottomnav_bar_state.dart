part of 'mange_custom_bottomnav_bar_cubit.dart';

@immutable
sealed class MangeCustomBottomnavBarState {}

final class MangeCustomBottomnavBarInitial
    extends MangeCustomBottomnavBarState {}

// ignore: must_be_immutable
final class MangeCustomBottomnavBarChange extends MangeCustomBottomnavBarState {
  int index;
  MangeCustomBottomnavBarChange(this.index);
}
