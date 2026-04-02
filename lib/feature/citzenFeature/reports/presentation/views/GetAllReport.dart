import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/core/widget/CustomAnimatedSearch.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/GetReportModel.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/GetReportCarditem.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/GetreportFiltring.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final List<Map<String, dynamic>> filters = [
    {"key": "All", "selected": true},
    {"key": "Pending", "selected": false},
    {"key": "InProgress", "selected": false},
    {"key": "Resolved", "selected": false},
  ];

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _selectedFilterKey = "All";
  late ReportCubit _reportCubit;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _reportCubit.resetSearch();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reportCubit = context.read<ReportCubit>();
  }

  String _getFilterTitle(BuildContext context, String key) {
    switch (key) {
      case "All":
        return S.of(context).all;
      case "Pending":
        return S.of(context).pending;
      case "InProgress":
        return S.of(context).inProgress;
      case "Resolved":
        return S.of(context).resolved;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManger.reportsPageBackground,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Directionality.of(context) == TextDirection.ltr
                ? CupertinoIcons.back
                : CupertinoIcons.back,
          ),
          color: ColorManger.kPrimary,
        ),
        title: Text(
          S.of(context).reports,
          style: GoogleFonts.cairo(
            color: ColorManger.kPrimary,
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
              controller: _controller,
              focusNode: _focusNode,
              onChanged: (value) {
                context.read<ReportCubit>().searchReport(query: value);
              },
              onSubmitted: (_) => _focusNode.unfocus(),
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
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    for (var e in filters) {
                      e["selected"] = false;
                    }
                    filters[index]["selected"] = true;
                    _selectedFilterKey = filters[index]["key"];
                  });
                },
                child: FliterCheap(
                  label: _getFilterTitle(context, filters[index]["key"]),
                  isActive: filters[index]["selected"],
                ),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<ReportCubit, ReportManagerState>(
              builder: (context, state) {
                List<ReportItem> displayList = [];

                if (state is GetReportsLoading) {
                  return Center(
                    child: SpinKitWaveSpinner(
                      color: ColorManger.lightColor,
                      size: 50.sp,
                    ),
                  );
                }

                if (state is SearchLoading) {
                  return Center(
                    child: Lottie.asset(
                      AssetValueManager.searchAnimation,
                      width: 200.w,
                    ),
                  );
                }

                if (state is GetReportsSuccess) {
                  displayList = state.reports;
                } else if (state is SearchReportsSuccess) {
                  displayList = state.reports;
                } else if (state is GetReportsFailure ||
                    state is SearchReportsFailure) {
                  final error = state is GetReportsFailure
                      ? state.errMessage
                      : (state as SearchReportsFailure).errMessage;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        AssetValueManager.notFoundsearchAnimation,
                        height: 200.h,
                      ),
                      Text(
                        error,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cairo(
                          fontWeight: FontWeight.w500,
                          color: ColorManger.lightGrey.withOpacity(0.8),
                          fontSize: ScreenUtilsManager.s16,
                        ),
                      ),
                    ],
                  );
                }

                final finalFiltered = _selectedFilterKey == "All"
                    ? displayList
                    : displayList
                          .where(
                            (r) =>
                                r.status.toLowerCase() ==
                                _selectedFilterKey.toLowerCase(),
                          )
                          .toList();

                if (finalFiltered.isEmpty) {
                  return Center(
                    child: Text(
                      S.of(context).noReportsAvailable,
                      style: GoogleFonts.cairo(color: Colors.grey),
                    ),
                  );
                }

                return RefreshIndicator(
                  color: ColorManger.kPrimary,
                  backgroundColor: Colors.white,
                  onRefresh: () => context.read<ReportCubit>().fetchReports(),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: finalFiltered.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: ReportCardIem(
                          statusColor: StatusReport.fromString(
                            finalFiltered[index].status,
                          ).color,
                          report: finalFiltered[index],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
