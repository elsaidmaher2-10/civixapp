import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/widget/CustomMapSection.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../verfication/verficationinit.dart';
import 'TaskInfoSection.dart';
import 'TaskOwnerHeader.dart';

enum StepState { completed, active, pending }

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

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.background,
      appBar: _buildAppBar(context),
      bottomNavigationBar: const _TaskBottomBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TaskOwnerHeader(),
            SizedBox(height: 16),
            TaskInfoSection(),
            SizedBox(height: 16),
            _IssuePhotosSection(),
            SizedBox(height: 16),
            _MapNavigationSection(),
            SizedBox(height: 16),
            ActivityTimelineSection(),
            SizedBox(height: 16),
            _CompletionDataSection(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManger.surface,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: ColorManger.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Task Details',
        style: TextStyle(
          color: ColorManger.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'Manrope',
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.more_vert, color: ColorManger.onSurfaceVariant),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ActivityTimelineSection extends StatefulWidget {
  const ActivityTimelineSection({super.key});
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
      padding: const EdgeInsets.all(24),
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
              Icon(Icons.event_repeat, color: ColorManger.primary, size: 16),
              const SizedBox(width: 8),
              const Text(
                'ACTIVITY TIMELINE',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          StreamBuilder<List<TimelineStepModel>>(
            stream: _streamController.stream,
            builder: (context, snapshot) {
              final data = snapshot.data ?? _timelineData;
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                                ? ColorManger.primary
                                : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: step.state
                                  ? ColorManger.primary
                                  : Colors.grey.shade200,
                              width: step.state ? 4 : 1,
                            ),
                          ),
                          child: step.state
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 14,
                                )
                              : null,
                        ),
                      ),
                    ),

                    beforeLineStyle: LineStyle(
                      color: step.state
                          ? ColorManger.primary
                          : Colors.grey.shade200,
                      thickness: 2,
                    ),
                    afterLineStyle: LineStyle(
                      color:
                          data[index].state &&
                              index + 1 < data.length &&
                              data[index + 1].state
                          ? ColorManger.primary
                          : Colors.grey.shade200,
                      thickness: 2,
                    ),
                    endChild: GestureDetector(
                      onTap: () => _onStepTap(index),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step.title,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Manrope',
                                color: step.state
                                    ? ColorManger.primary
                                    : ColorManger.onSurface,
                              ),
                            ),
                            if (step.time.isNotEmpty)
                              Text(
                                step.time,
                                style: TextStyle(
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

class _IssuePhotosSection extends StatelessWidget {
  const _IssuePhotosSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'ISSUE PHOTOS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: ColorManger.onSurfaceVariant,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPhotoCard(
                'https://images.unsplash.com/photo-1585704032915-c3400ca199e7?q=80&w=2070',
              ),
              const SizedBox(width: 12),
              _buildPhotoCard(
                'https://cdn.pixabay.com/photo/2023/10/03/10/49/anonymous-8291223_1280.png',
              ),
              const SizedBox(width: 12),
              _buildPhotoCard(
                'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?q=80&w=2069',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoCard(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(url, width: 128, height: 128, fit: BoxFit.cover),
    );
  }
}

class _MapNavigationSection extends StatelessWidget {
  const _MapNavigationSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CustomMapSection(),
        Positioned(
          bottom: 40,
          right: 40,
          child: Column(
            children: [
              Icon(Icons.location_on, color: ColorManger.primary, size: 40),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Text(
                  'TASK SITE',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 12,
          left: 12,
          right: 12,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: ColorManger.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.directions_car,
                        color: ColorManger.primary,
                      ),
                    ),

                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ESTIMATED ARRIVAL',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: ColorManger.primary,
                            letterSpacing: 1,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '12 mins',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: ColorManger.onSurface,
                              ),
                            ),
                            Text(
                              ' • 1.8 km away',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManger.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  child: const Text(
                    'NAVIGATE',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CompletionDataSection extends StatelessWidget {
  const _CompletionDataSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
              Icon(Icons.task_alt, color: ColorManger.primary, size: 16),
              const SizedBox(width: 8),
              const Text(
                'COMPLETION DATA',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'PROOF OF WORK ',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
              const Text(
                '*',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          InkWell(
            onTap: () {
              // أضف كود اختيار الصورة هنا
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManger.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.grey.shade400,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap to upload photos',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskBottomBar extends StatelessWidget {
  const _TaskBottomBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: ColorManger.surface,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF7A00), Color(0xFFFF9533)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorManger.primary.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.verified, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Mark as Completed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Manrope',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
