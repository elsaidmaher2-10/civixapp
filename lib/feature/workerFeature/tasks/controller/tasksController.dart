import 'package:citifix/generated/l10n.dart';

class Taskscontroller {
  static String selectedFilter = 'All';
  static List<String> filters(context) => [
    S.of(context).all,
    S.of(context).assigned,
    S.of(context).pending,
    S.of(context).resolved,
  ];
}
