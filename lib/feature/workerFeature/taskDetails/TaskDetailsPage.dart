import 'dart:async';
import 'dart:io';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/ReportDetailsState.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/IssuePhotosSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/MapNavigationSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskInfoSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskOwnerHeader.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/timelineSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';

import '../../../core/DI/getit.dart';
import '../../../core/resource/screenutilsmaanger.dart';
import '../../citzenFeature/Profile/presentation/view/widget/image_picker_menu.dart';
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

  StreamController<File>? Controller = StreamController.broadcast();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Controller?.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.background,
      appBar: _buildAppBar(),
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

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: BlocProvider(
                create: (context) => WorkerTasksCubit(getIt<WorkerTaskRepo>()),
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
                        ? _CompletionDataSection(
                            streamController: Controller,
                            ontap: (image) async {},
                          )
                        : SizedBox.shrink(),
                  ],
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

class _CompletionDataSection extends StatelessWidget {
  _CompletionDataSection({required this.ontap, required this.streamController});
  StreamController<File>? streamController;
  Function(File?) ontap;
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
              Icon(Icons.task_alt, color: ColorManger.workerprimary, size: 16),
              const SizedBox(width: 8),
              Text(
                'COMPLETION DATA',
                style: GoogleFonts.cairo(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'PROOF OF WORK *',
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 10),

          StreamBuilder<File>(
            stream: streamController?.stream,
            builder: (BuildContext context, AsyncSnapshot<File> snapshot) =>
                InkWell(
                  onTap: () async {
                    final image = await ImagePickerMenu.show(context);
                    if (image != null) {
                      ontap(image);
                      streamController?.add(image);
                    }
                  },
                  child: Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: snapshot.data != null
                        ? ClipRRect(
                            child: Image.file(
                              snapshot.data!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 32,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Tap to upload photos",
                                style: GoogleFonts.cairo(color: Colors.grey),
                              ),
                            ],
                          ),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
