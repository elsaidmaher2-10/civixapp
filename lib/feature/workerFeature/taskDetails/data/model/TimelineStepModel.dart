class TimelineStepModel {
  final String title;
  String time;
  bool state;

  TimelineStepModel({
    required this.title,
    required this.time,
    this.state = false,
  });
}
