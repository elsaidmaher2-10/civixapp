import 'dart:async';
import 'dart:io';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/ReportDetailsState.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/CompletionDataSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/IssuePhotosSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/MapNavigationSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskInfoSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskOwnerHeader.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/timelineSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import '../../../core/DI/getit.dart';
import '../../../core/resource/screenutilsmaanger.dart';
import '../tasks/data/repos/worker_task_Repo.dart';
import '../tasks/presentation/manager/cubit/task_report_cubit.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.reportid});
  final int reportid;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportDetailsManager>().getReportDetails(
        id: widget.reportid,
      );
    });
  }

  StreamController<List<File>> Controller = StreamController.broadcast();
  bool _isScrolling = false;
  final List<File> _pickedFiles = [];

  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollStartNotification) {
      setState(() => _isScrolling = true);
    } else if (notification is ScrollEndNotification) {
      setState(() => _isScrolling = false);
    }
    return true;
  }

  @override
  void dispose() {
    super.dispose();
    Controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.background,
      appBar: _buildAppBar(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: MarkAsCompletedButton(onTap: () {}),
        ),
      ),
      body: BlocBuilder<ReportDetailsManager, ReportDetailsState>(
        builder: (context, state) {
          if (state is ReportDetailsLoading) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: ScreenUtilsManager.r12,
                color: ColorManger.workerprimary,
              ),
            );
          }

          if (state is ReportDetailsFailure) {
            final isNoInternet = state.error.contains(
              Constantmanger.nointernet,
            );

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isNoInternet ? Icons.wifi_off : Icons.error_outline,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isNoInternet
                        ? "No Internet Connection"
                        : "Something went wrong",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    state.error,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(color: Colors.grey),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7B00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    onPressed: () {
                      context.read<ReportDetailsManager>().getReportDetails(
                        id: widget.reportid,
                      );
                    },
                    child: Text(
                      "Retry",
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ReportDetailsSuccess) {
            final task = state.data;

            return NotificationListener(
              onNotification: _onScrollNotification,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: BlocProvider(
                  create: (context) =>
                      WorkerTasksCubit(getIt<WorkerTaskRepo>()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskOwnerHeader(task: task),
                      const SizedBox(height: 16),

                      TaskInfoSection(task: task),
                      const SizedBox(height: 16),

                      IssuePhotosSection(
                        mediaItems: [...task.imagesUrls, ...task.videosUrls],
                      ),
                      const SizedBox(height: 16),

                      MapNavigationSection(taskDetailsModel: task),
                      const SizedBox(height: 16),

                      ActivityTimelineSection(
                        isCompleted: task.isCompleted,
                        initialStatus: task.status,
                        id: task.id,
                      ),
                      const SizedBox(height: 16),

                      !task.isCompleted
                          ? CompletionDataSection(
                              streamController: Controller,
                              notesController: TextEditingController(),
                              onFilesChanged: (List<File> p1) {},
                              addimage: (iamge) {
                                setState(() {
                                  _pickedFiles.addAll(iamge);
                                });
                                Controller.add(_pickedFiles);
                              },
                              removeImage: (index) {
                                setState(() {
                                  _pickedFiles.removeAt(index);
                                });
                                Controller.add(_pickedFiles);
                              },
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
        style: GoogleFonts.cairo(
          color: ColorManger.onSurface,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
