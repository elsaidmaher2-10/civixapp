import 'package:intl/intl.dart';

extension Datetimeextension on DateTime {
  String get setdate {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String get timeAgo {
    final Duration diff = DateTime.now().difference(this);

    if (diff.inDays >= 30) {
      return setdate;
    } else if (diff.inDays >= 7) {
      int weeks = (diff.inDays / 7).floor();
      return "$weeks ${weeks == 1 ? 'week' : 'weeks'} ago";
    } else if (diff.inDays >= 1) {
      return "${diff.inDays} ${diff.inDays == 1 ? 'day' : 'days'} ago";
    } else if (diff.inHours >= 1) {
      return "${diff.inHours} ${diff.inHours == 1 ? 'hour' : 'hours'} ago";
    } else if (diff.inMinutes >= 1) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? 'minute' : 'minutes'} ago";
    } else {
      return "Just now";
    }
  }
}
