import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/reports/presentation/views/widget/GetReportCarditem.dart';
import 'package:citifix/feature/reports/presentation/views/widget/GetreportFiltring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
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
            child: CustomSearchField(
              controller: controller,
              focusNode: focusNode,
              onSubmitted: (p0) {
                focusNode.unfocus();
              },
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
                          statusColor: StatusReport.fromString(
                            filteredList[index].status,
                          ).color,
                          reportResponseModel: filteredList[index],
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

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  const CustomSearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextField(
      controller: controller,
      focusNode: focusNode ?? FocusNode(),
      animationType: Animationtype.typer,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hintTexts: const [
        'Search for "Water leak"',
        'Search for "Broken streetlight"',
        'Search for "Waste accumulation"',
        'Search for "Pothole repair"',
        'Describe the issue...',
      ],
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Color(0xff475569)),
        isDense: true,
        fillColor: const Color(0xffF1F5F9), // Matching your app's palette
        filled: true,
        hintStyle: TextStyle(
          color: const Color(0xff94A3B8),
          fontSize: ScreenUtilsManager.s14,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: ScreenUtilsManager.h10,
          horizontal: 12,
        ),
        // Normal Border
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8),
        ),
        // Active/Focus Border
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xff475569), width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        // Error Border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
      ),
    );
  }
}
