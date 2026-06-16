import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/EditCompletionImagesSection.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskDetailsAppBar.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/TaskDetailsErrorView.dart';
import 'package:citifix/feature/workerFeature/taskDetails/presentation/views/widget/WorkerCompletionDetailsSection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:screenshot/screenshot.dart';

import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
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

import 'data/model/taskdetailsmodel.dart';

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
  final ScreenshotController screenshotController = ScreenshotController();

  TaskDetailsModel? _currentTask;
  bool _isEditing = false;
  final List<int> _deletedImageIds = [];

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
    if (_isEditing) {
      _buttonStatusController.add(notesController.text.trim().isNotEmpty);
    } else {
      _buttonStatusController.add(
        _pickedFiles.isNotEmpty && notesController.text.trim().isNotEmpty,
      );
    }
  }

  Future<void> _exportToPdf() async {
    try {
      final Uint8List? imageBytes = await screenshotController.capture(
        delay: const Duration(milliseconds: 100),
      );

      if (imageBytes != null) {
        final pdf = pw.Document();
        final image = pw.MemoryImage(imageBytes);

        pdf.addPage(
          pw.Page(
            pageFormat: PdfPageFormat.a4,
            build: (pw.Context context) {
              return pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain));
            },
          ),
        );

        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdf.save(),
          name: 'Task_Details_${widget.reportid}.pdf',
        );
      } else {
        throw Exception("Capture returned null");
      }
    } catch (e) {
      debugPrint("PDF Generation Error: $e");
      if (mounted) {
        Customsnackbar.show(
          context: context,
          backgroundColor: context.palette.red,
          message: "Failed to generate PDF: ${e.toString()}",
        );
      }
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
            if (!(_isEditing && state.data.isCompleted)) {
              _isEditing = false;
              _deletedImageIds.clear();
            }
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
              appBar: const TaskDetailsAppBar(),
              floatingActionButton: _currentTask != null
                  ? FloatingActionButton(
                      onPressed: _exportToPdf,
                      backgroundColor: context.palette.workerprimary,
                      child: const Icon(
                        Icons.picture_as_pdf,
                        color: Colors.white,
                      ),
                    )
                  : null,
              bottomNavigationBar: _buildBottomAction(),
              body: _buildScaffoldBody(state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScaffoldBody(ReportDetailsState state) {
    if (state is ReportDetailsLoading && _currentTask == null) {
      return Center(
        child: CupertinoActivityIndicator(
          radius: ScreenUtilsManager.r12,
          color: context.palette.primary,
        ),
      );
    }
    if (state is ReportDetailsFailure && _currentTask == null) {
      return TaskDetailsErrorView(
        error: state.error,
        onRetry: () => _fetchReportDetails(),
      );
    }
    if (_currentTask != null) {
      return _buildMainContent(_currentTask!);
    }
    return const SizedBox.shrink();
  }

  Widget _buildBottomAction() {
    if (_currentTask != null && (!_currentTask!.isCompleted || _isEditing)) {
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
                    ? () {
                        if (_isEditing) {
                          context.read<ReportDetailsManager>().updateCompletion(
                            id: widget.reportid,
                            notes: notesController.text,
                            imagesToAdd: _pickedFiles,
                            imagesToDeleteIds: _deletedImageIds,
                          );
                        } else {
                          context.read<ReportDetailsManager>().markAsCompleted(
                            id: widget.reportid,
                            notes: notesController.text,
                            images: _pickedFiles,
                          );
                        }
                      }
                    : null,
              );
            },
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildMainContent(TaskDetailsModel task) {
    return RefreshIndicator(
      color: context.palette.primary,
      backgroundColor: context.palette.surface,
      onRefresh: () async => context
          .read<ReportDetailsManager>()
          .getReportDetails(id: widget.reportid),
      child: SingleChildScrollView(
        child: Screenshot(
          controller: screenshotController,
          child: Container(
            color: context.palette.reportsPageBackground,
            padding: EdgeInsets.all(ScreenUtilsManager.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TaskOwnerHeader(task: task),
                SizedBox(height: ScreenUtilsManager.h16),
                TaskInfoSection(task: task),
                if (task.imagesUrls.isNotEmpty ||
                    task.videosUrls.isNotEmpty) ...[
                  SizedBox(height: ScreenUtilsManager.h16),
                  IssuePhotosSection(
                    mediaItems: [...task.imagesUrls, ...task.videosUrls],
                  ),
                ],
                SizedBox(height: ScreenUtilsManager.h16),
                MapNavigationSection(taskDetailsModel: task),
                if (task.timeline.isNotEmpty) ...[
                  SizedBox(height: ScreenUtilsManager.h16),
                  ActivityTimelineSection(
                    timeline: task.timeline,
                    isCompleted: task.isCompleted,
                    initialStatus: task.status,
                    id: task.id,
                  ),
                ],
                SizedBox(height: ScreenUtilsManager.h16),
                if (task.isCompleted &&
                    task.completionDetails != null &&
                    !_isEditing) ...[
                  WorkerCompletionDetailsSection(
                    completionDetails: task.completionDetails!,
                    status: task.status,
                    onEdit: () {
                      setState(() {
                        _isEditing = true;
                        notesController.text = task.completionDetails!.note;
                        _deletedImageIds.clear();
                        _pickedFiles.clear();
                        _imagesController.add([]);
                        _checkButtonStatus();
                      });
                    },
                  ),
                  SizedBox(height: ScreenUtilsManager.h16),
                ],
                if (!task.isCompleted || _isEditing) ...[
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
                ],
                if (_isEditing && task.completionDetails != null) ...[
                  EditCompletionImagesSection(
                    completionDetails: task.completionDetails!,
                    deletedImageIds: _deletedImageIds,
                    onToggleDelete: (id) {
                      setState(() {
                        if (_deletedImageIds.contains(id)) {
                          _deletedImageIds.remove(id);
                        } else {
                          _deletedImageIds.add(id);
                        }
                        _checkButtonStatus();
                      });
                    },
                  ),
                  SizedBox(height: ScreenUtilsManager.h16),
                ],
                if (task.comments.isNotEmpty || !task.isCompleted || _isEditing)
                  Workercomments(
                    isComment: false,
                    comments: task.comments,
                    controller: _commentController,
                    reporID: task.id,
                  ),
              ],
            ),
          ),
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
}
