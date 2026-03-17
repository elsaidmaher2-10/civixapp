import 'package:animated_hint_textfield/animated_hint_textfield.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/StatusReport.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportResponseModel.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/reports/presentation/views/widget/GetReportCarditem.dart';
import 'package:citifix/feature/reports/presentation/views/widget/GetreportFiltring.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  final List<Map<String, dynamic>> filters = [
    {"title": "All", "selected": true},
    {"title": "Pending", "selected": false},
    {"title": "In Progress", "selected": false},
    {"title": "Resolved", "selected": false},
  ];

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _selectedFilter = "All";
  late ReportCubit _reportCubit;
  @override
  void dispose() {
    _controller.clear();
    _focusNode.dispose();
    _reportCubit.resetSearch();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _reportCubit = context.read<ReportCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: ColorManger.kPrimary,
        ),
        title: Text(
          Constantmanger.reports,
          style: TextStyle(
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
                // Real-time search as user types
                context.read<ReportCubit>().searchReport(query: value);
              },
              onSubmitted: (_) => _focusNode.unfocus(),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips Row
          SizedBox(
            height: 80.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              itemCount: filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {
                    for (var e in filters) e["selected"] = false;
                    filters[index]["selected"] = true;
                    _selectedFilter = filters[index]["title"];
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
              // Inside your BlocBuilder...
              builder: (context, state) {
                List<ReportResponseModel> displayList = [];

                // 1. Handle Loading States
                if (state is GetReportsLoading) {
                  return Center(
                    child: SpinKitWaveSpinner(color: ColorManger.lightColor),
                  );
                }

                if (state is SearchLoading) {
                  // Using Lottie for search is a nice touch!
                  return Center(
                    child: Lottie.asset(AssetValueManager.searchAnimation),
                  );
                }

                // 2. Handle Success States
                if (state is GetReportsSuccess) {
                  displayList = state.reports;
                } else if (state is SearchReportsSuccess) {
                  displayList = state.reports;
                }
                // 3. Handle Failure States
                else if (state is GetReportsFailure ||
                    state is SearchReportsFailure) {
                  final error = state is GetReportsFailure
                      ? state.errMessage
                      : (state as SearchReportsFailure).errMessage;

                  // Crucial: We return the text but the search bar remains on top
                  // so the user can backspace to recover.
                  return Center(child: Text(error));
                }

                // 4. Apply Category Filtering (All, Pending, etc.)
                final finalFiltered = _selectedFilter == "All"
                    ? displayList
                    : displayList
                          .where(
                            (r) =>
                                r.status.toLowerCase() ==
                                _selectedFilter.toLowerCase(),
                          )
                          .toList();

                if (finalFiltered.isEmpty && _controller.text.isEmpty) {
                  return const Center(child: Text("No reports available"));
                }

                return RefreshIndicator(
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
                          reportResponseModel: finalFiltered[index],
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
