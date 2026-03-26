import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Datetimeextension on DateTime {
  String get setdate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String timeAgo(BuildContext context) {
    final dateUtc = this.toUtc();
    final nowUtc = DateTime.now().toUtc();
    final Duration diff = nowUtc.difference(dateUtc);

    if (diff.inDays >= 30) {
      return setdate;
    } else if (diff.inDays >= 7) {
      int weeks = (diff.inDays / 7).floor();
      return S.of(context).weeksAgo(weeks);
    } else if (diff.inDays >= 1) {
      return S.of(context).daysAgo(diff.inDays);
    } else if (diff.inHours >= 1) {
      return S.of(context).hoursAgo(diff.inHours);
    } else if (diff.inMinutes >= 1) {
      return S.of(context).minutesAgo(diff.inMinutes);
    } else {
      return S.of(context).justNow;
    }
  }
}