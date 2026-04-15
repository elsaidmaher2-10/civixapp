import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/TaskCard.dart';
import 'package:citifix/feature/workerFeature/main/Manager/cubit/worker_cubit_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTaskListView extends StatelessWidget {
  final List<RecentReportModel> reports;

  const CustomTaskListView({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.w4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    S.of(context).available_tasks,
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: ScreenUtilsManager.w8),
                  Text(
                    '(${reports.length})',
                    style: GoogleFonts.cairo(
                      fontSize: ScreenUtilsManager.s14,
                      color: ColorManger.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  context.read<WorkerCubit>().changeCurrentIndex(1);
                },
                child: Text(
                  S.of(context).see_all,
                  style: GoogleFonts.cairo(color: ColorManger.primaryColor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h8),
        SizedBox(
          height: ScreenUtilsManager.h240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              return TaskCard(report: reports[index]);
            },
          ),
        ),
      ],
    );
  }
}
