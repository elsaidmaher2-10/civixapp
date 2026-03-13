import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/statusColorreport.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/home/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/home/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/home/presentation/view/GetReportCarditem.dart';
import 'package:citifix/feature/home/presentation/view/GetreportFiltring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List<Map<String, dynamic>> filters = [
    {"title": "All", "selected": true},
    {"title": "Pending", "selected": false},
    {"title": "In Progress", "selected": false},
    {"title": "Resolved", "selected": false},
  ];

  String selectedFilter = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: ColorManger.kprimary,
        ),
        title: Text(
          Constantmanger.reports,
          style: TextStyle(
            color: ColorManger.kprimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(ScreenUtilsManager.h80),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilsManager.w16,
              vertical: ScreenUtilsManager.h8,
            ),
            child: CustomTextfromfield(
              prefix: const Icon(Icons.search, color: Colors.black45),
              hinttext: Constantmanger.hsearch,
              lable: Constantmanger.search,
              controller: TextEditingController(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: filters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    for (var element in filters) {
                      element["selected"] = false;
                    }
                    filters[index]["selected"] = true;
                    selectedFilter = filters[index]["title"];
                  });
                },
                child: FliterCheap(
                  label: filters[index]["title"],
                  isActive: filters[index]["selected"],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<ReportCubit, ReportManagerState>(
              builder: (context, state) {
                if (state is GetReportsLoading) {
                  return SpinKitWaveSpinner(color: ColorManger.lightcolor);
                } else if (state is GetReportsSuccess) {
                  final filteredList = selectedFilter == "All"
                      ? state.reports
                      : state.reports
                            .where(
                              (r) =>
                                  r.status.toLowerCase() ==
                                  selectedFilter.toLowerCase(),
                            )
                            .toList();

                  if (filteredList.isEmpty) {
                    return const Center(child: Text("No reports found"));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ReportCardIem(
                          status: filteredList[index].status,
                          statusColor: StatusReport.fromString(
                            filteredList[index].status,
                          ).color,
                          title: filteredList[index].title,
                          location: filteredList[index].location,
                          date: DateFormat(
                            Constantmanger.dateformate,
                          ).format(filteredList[index].createdAt),
                          ref: filteredList[index].hashCode.toString(),
                          imageUrl: filteredList[index].imagesUrls.isNotEmpty
                              ? filteredList[index].imagesUrls.first
                              : Constantmanger.defualtImage,
                        ),
                      );
                    },
                  );
                } else if (state is GetReportsFailure) {
                  return Center(child: Text(state.errMessage));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
