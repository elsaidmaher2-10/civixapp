import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/tasks/presentation/manager/cubit/task_report_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskSearchBar extends StatelessWidget {
  const TaskSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.palette.white,
        borderRadius: BorderRadius.circular(ScreenUtilsManager.r12),
        boxShadow: [
          BoxShadow(
            color: context.palette.black.withOpacity(0.03),
            blurRadius: ScreenUtilsManager.s15,
            offset: Offset(0, ScreenUtilsManager.h8),
          ),
        ],
      ),
      child: TextField(
        onChanged: (value) {
          context.read<WorkerTasksCubit>().searchTasks(value);
        },
        decoration: InputDecoration(
          hintText: S.of(context).searchTasksHint,
          hintStyle: GoogleFonts.cairo(
            color: context.palette.grey400,
            fontSize: ScreenUtilsManager.s14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: context.palette.primaryColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: ScreenUtilsManager.h16,
          ),
        ),
      ),
    );
  }
}
