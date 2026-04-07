
import 'dart:async';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/taskDetails/data/TimelineStepModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ActivityTimelineSection extends StatefulWidget {
  ActivityTimelineSection({super.key});
  @override
  State<ActivityTimelineSection> createState() =>
      _ActivityTimelineSectionState();
}

class _ActivityTimelineSectionState extends State<ActivityTimelineSection> {
  final List<TimelineStepModel> _timelineData = [
    TimelineStepModel(title: 'Assigned', time: '', state: true),
    TimelineStepModel(title: 'Accepted', time: '', state: false),
    TimelineStepModel(
      title: 'On the Way',
      time: 'Started at 09:12 AM',
      state: false,
    ),
    TimelineStepModel(title: 'Arrived', time: '', state: false),
    TimelineStepModel(title: 'In Progress', time: '', state: false),
    TimelineStepModel(title: 'Completed', time: '', state: false),
  ];

  final StreamController<List<TimelineStepModel>> _streamController =
      StreamController<List<TimelineStepModel>>();

  @override
  void initState() {
    super.initState();
    _streamController.add(_timelineData);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _onStepTap(int index) {
    final now = DateTime.now();
    final formattedTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} ${now.hour >= 12 ? 'PM' : 'AM'}";
    final isAlreadyActive = _timelineData[index].state;
    for (int i = 0; i < _timelineData.length; i++) {
      if (isAlreadyActive && i >= index) {
        _timelineData[i].state = false;
        _timelineData[i].time = '';
      } else if (!isAlreadyActive && i <= index) {
        _timelineData[i].state = true;
        if (i == index && _timelineData[i].time.isEmpty) {
          _timelineData[i].time = formattedTime;
        }
      }
    }

    _streamController.add(List.from(_timelineData));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_repeat,
                color: ColorManger.workerprimary,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'ACTIVITY TIMELINE',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          StreamBuilder<List<TimelineStepModel>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? _timelineData;
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final step = data[index];
                  return TimelineTile(
                    alignment: TimelineAlign.start,
                    isFirst: index == 0,
                    isLast: index == data.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 24,
                      height: 24,
                      indicator: GestureDetector(
                        onTap: () => _onStepTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            color: step.state
                                ? ColorManger.workerprimary
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: step.state
                                  ? ColorManger.workerprimary
                                  : Colors.grey.shade200,
                              width: step.state ? 4 : 1,
                            ),
                          ),
                          child: step.state
                              ? Icon(Icons.check, color: Colors.white, size: 14)
                              : null,
                        ),
                      ),
                    ),

                    beforeLineStyle: LineStyle(
                      color: step.state
                          ? ColorManger.workerprimary
                          : Colors.grey.shade200,
                      thickness: 2,
                    ),
                    afterLineStyle: LineStyle(
                      color:
                          data[index].state &&
                              index + 1 < data.length &&
                              data[index + 1].state
                          ? ColorManger.workerprimary
                          : Colors.grey.shade200,
                      thickness: 2,
                    ),
                    endChild: GestureDetector(
                      onTap: () => _onStepTap(index),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: step.state
                                    ? ColorManger.workerprimary
                                    : ColorManger.onSurface,
                              ),
                            ),
                            if (step.time.isNotEmpty)
                              Text(
                                step.time,
                                style: GoogleFonts.cairo(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
