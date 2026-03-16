import 'package:citifix/core/resource/constantmanger.dart';
import 'package:intl/intl.dart';

extension Datetimeextension on DateTime {
  String get setdate {
    return DateFormat(Constantmanger.dateformate).format(this);
  }
}
