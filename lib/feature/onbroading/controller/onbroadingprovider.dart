import 'package:civixapp/feature/onbroading/model/onbroadingmodel.dart';
import 'package:flutter/material.dart';

class Onbroadingprovider extends ChangeNotifier {
  final List<Onbroadingmodel> pages = [
    Onbroadingmodel(
      title: "Help Community",
      subtitle: "Report your problem as soon as possible",
      image: "assets/onbroadingimage/1.png",
    ),
    Onbroadingmodel(
      title: "Officials Are Acting",
      subtitle: "Work is underway to fix the problem",
      image: "assets/onbroadingimage/2.png",
    ),
    Onbroadingmodel(
      title: "Civilized City",
      subtitle: "Stable city with no problems",
      image: "assets/onbroadingimage/3.png",
    ),
  ];

  PageController controller = PageController();

  int value = 0;

  void updateIndex(int v) {
    value = v;
    notifyListeners();
  }

  bool get isLastPage => value == pages.length - 1;
}
