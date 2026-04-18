import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';

class Taskscontroller {
  static String selectedFilter = 'All';
  static List<String> filters(context) => [
    S.of(context).all,
    S.of(context).assigned,
    S.of(context).pending,
    S.of(context).resolved,
  ];

 static String transalte(String filtername, BuildContext context) {
    switch (filtername.toLowerCase()) {
      case "all":
        return S.of(context).all;
      case "assigned":
        return S.of(context).assigned;
      case "pending":
        return S.of(context).pending;
      case "resolved":
        return S.of(context).resolved;
      default:
        return S.of(context).all;
    }
  }

  static List<String> filtersen(context) => [
    "all",
    "assigned",
    "pending",
    "resolved",
  ];
}
