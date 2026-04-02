import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/workerFeature/home/data/models/dashbroadmodel.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/widget/TaskCard.dart';
import 'package:citifix/feature/workerFeature/main/Manager/cubit/worker_cubit_cubit.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Available Tasks',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '(${reports.length})',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
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
                  "See All",
                  style: GoogleFonts.cairo(color: ColorManger.primaryColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
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
