import 'package:citifix/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';

class Onbroadingprovider extends ChangeNotifier {
  final PageController controller = PageController();
  int _value = 0;
  int get value => _value;
  bool get isLastPage => _value == Constantmanger.pages.length - 1;

  void updateIndex(int v) {
    if (_value == v) return;
    _value = v;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}