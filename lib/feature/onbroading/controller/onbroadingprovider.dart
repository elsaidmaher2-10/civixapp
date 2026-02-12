import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:flutter/material.dart';

class Onbroadingprovider extends ChangeNotifier {
  PageController controller = PageController();

  int value = 0;

  void updateIndex(int v) {
    value = v;
    notifyListeners();
  }

  bool get isLastPage => value == Constantmanger.pages.length - 1;
}
