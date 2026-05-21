import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/generated/l10n.dart';

import 'package:citifix/feature/citzenFeature/reports/data/repos/commentRepo/commentRepo.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/comment/commentmanger_cubit.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/ReportDetailsState.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/manager/reportdetailsManger.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/CompletionDataSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/IssuePhotosSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/MapNavigationSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskInfoSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskOwnerHeader.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/timelineSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/workerComments.dart';
import 'package:citifix/feature/workerFeature/tasks/data/repos/worker_task_Repo.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_cubit.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.reportid});
  final int reportid;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final StreamController<List<File>> _imagesController =
      StreamController.broadcast();
  final StreamController<bool> _buttonStatusController =
      StreamController.broadcast();
  final List<File> _pickedFiles = [];
  final TextEditingController notesController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  dynamic _currentTask;

  @override
  void initState() {
    super.initState();
    _fetchReportDetails();
    notesController.addListener(_checkButtonStatus);
  }

  void _fetchReportDetails() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ReportDetailsManager>().getReportDetails(
          id: widget.reportid,
        );
      }
    });
  }

  void _checkButtonStatus() {
    if (_pickedFiles.isNotEmpty && notesController.text.trim().isNotEmpty) {
      _buttonStatusController.add(true);
    } else {
      _buttonStatusController.add(false);
    }
  }

  @override
  void dispose() {
    _imagesController.close();
    _buttonStatusController.close();
    notesController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CommentsCubit(getIt<Commentrepo>())),
        BlocProvider(
          create: (context) => WorkerTasksCubit(getIt<WorkerTaskRepo>()),
        ),
      ],
      child: BlocConsumer<ReportDetailsManager, ReportDetailsState>(
        listener: _handleStateListener,
        builder: (context, state) {
          if (state is ReportDetailsSuccess) {
            _currentTask = state.data;
          }

          return ModalProgressHUD(
            inAsyncCall: state is MarkAsCompeleteLoading,
            opacity: 0.5,
            color: context.palette.black54,
            progressIndicator: CupertinoActivityIndicator(
              radius: ScreenUtilsManager.r12,
              color: context.palette.primary,
            ),
            child: Scaffold(
              backgroundColor: context.palette.reportsPageBackground,
              appBar: _buildAppBar(context),
              bottomNavigationBar: _buildBottomAction(context),
              body: _buildScaffoldBody(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffoldBody(BuildContext context, ReportDetailsState state) {
    if (state is ReportDetailsLoading && _currentTask == null) {
      return Center(
        child: CupertinoActivityIndicator(
          radius: ScreenUtilsManager.r12,
          color: context.palette.primary,
        ),
      );
    }
    if (state is ReportDetailsFailure && _currentTask == null) {
      return _buildErrorWidget(context, state.error);
    }
    if (_currentTask != null) {
      return _buildMainContent(context, _currentTask);
    }

    return const SizedBox.shrink();
  }

  Widget _buildBottomAction(BuildContext context) {
    if (_currentTask != null && !_currentTask.isCompleted) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtilsManager.w16),
          child: StreamBuilder<bool>(
            initialData: false,
            stream: _buttonStatusController.stream,
            builder: (context, snapshot) {
              final isFormValid = snapshot.data ?? false;
              return MarkAsCompletedButton(
                onTap: isFormValid
                    ? () =>
                          context.read<ReportDetailsManager>().markAsCompleted(
                            id: widget.reportid,
                            notes: notesController.text,
                            images: _pickedFiles,
                          )
                    : null,
              );
            },
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMainContent(BuildContext context, dynamic task) {
    return RefreshIndicator(
      color: context.palette.primary,
      backgroundColor: context.palette.surface,
      onRefresh: () async => context
          .read<ReportDetailsManager>()
          .getReportDetails(id: widget.reportid),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(ScreenUtilsManager.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TaskOwnerHeader(task: task),
            SizedBox(height: ScreenUtilsManager.h16),
            TaskInfoSection(task: task),
            SizedBox(height: ScreenUtilsManager.h16),
            IssuePhotosSection(
              mediaItems: [...task.imagesUrls, ...task.videosUrls],
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            MapNavigationSection(taskDetailsModel: task),
            SizedBox(height: ScreenUtilsManager.h16),
            ActivityTimelineSection(
              timeline: task.timeline,
              isCompleted: task.isCompleted,
              initialStatus: task.status,
              id: task.id,
            ),
            SizedBox(height: ScreenUtilsManager.h16),
            if (!task.isCompleted)
              CompletionDataSection(
                streamController: _imagesController,
                notesController: notesController,
                onFilesChanged: (_) {},
                addimage: (images) {
                  setState(() => _pickedFiles.addAll(images));
                  _imagesController.add(_pickedFiles);
                  _checkButtonStatus();
                },
                removeImage: (index) {
                  setState(() => _pickedFiles.removeAt(index));
                  _imagesController.add(_pickedFiles);
                  _checkButtonStatus();
                },
              ),
            SizedBox(height: ScreenUtilsManager.h16),
            Workercomments(
              isComment: false,
              comments: task.comments,
              controller: _commentController,
              reporID: task.id,
            ),
          ],
        ),
      ),
    );
  }

  void _handleStateListener(BuildContext context, ReportDetailsState state) {
    if (state is MarkAsCompeleteFailure) {
      Customsnackbar.show(
        context: context,
        backgroundColor: context.palette.red,
        message: state.error,
      );
    }
    if (state is MarkAsCompeleteSuccess) {
      Customsnackbar.show(
        context: context,
        backgroundColor: context.palette.green,
        message: S.of(context).markasCompeleted,
      );
      context.read<ReportDetailsManager>().getReportDetails(
        id: widget.reportid,
      );
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: context.palette.surface,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_outlined,
          color: context.palette.onSurface,
          size: ScreenUtilsManager.s20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        S.of(context).taskDetails,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.w800,
          color: context.palette.onSurface,
          fontSize: ScreenUtilsManager.s18,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String error) {
    final isNoInternet = error.contains(Constantmanger.nointernet);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(ScreenUtilsManager.w24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.palette.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isNoInternet ? Icons.wifi_off_rounded : Icons.error_outline_rounded,
                size: ScreenUtilsManager.s60,
                color: context.palette.error,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h20),
            Text(
              isNoInternet
                  ? S.of(context).noInternetConnection
                  : S.of(context).somethingWentWrong,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtilsManager.s18,
                color: context.palette.onSurface,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                color: context.palette.onSurfaceVariant,
                fontSize: ScreenUtilsManager.s14,
              ),
            ),
            SizedBox(height: ScreenUtilsManager.h24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.palette.workerprimary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w32,
                  vertical: ScreenUtilsManager.h12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => context
                  .read<ReportDetailsManager>()
                  .getReportDetails(id: widget.reportid),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                S.of(context).retry,
                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
