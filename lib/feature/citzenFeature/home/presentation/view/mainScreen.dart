import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/Profile/presentation/manager/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/AddReportScreen.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/Customnavarbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class CitizenMainScreen extends StatefulWidget {
  const CitizenMainScreen({CitizenMainScreenKey});

  @override
  State<CitizenMainScreen> createState() => _CitizenMainScreenState();
}

class _CitizenMainScreenState extends State<CitizenMainScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ReportCubit>().fetchReports());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MangeCustomBottomnavBarCubit()),

        BlocProvider(
          create: (context) => UserProfileInfoCubit(getIt<Userprofilerepos>()),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) =>
            BlocBuilder<
              MangeCustomBottomnavBarCubit,
              MangeCustomBottomnavBarState
            >(
              builder: (context, state) {
                final cubit = context.read<MangeCustomBottomnavBarCubit>();
                return Scaffold(
                  backgroundColor: ColorManger.reportsPageBackground,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: cubit.curindex == 0
                      ? SizedBox(
                          height: 62.h,
                          width: 62.w,
                          child: FloatingActionButton(
                            splashColor: ColorManger.lightGrey3,
                            onPressed: () {
                              final reportCubit = context.read<ReportCubit>();
                              showModalBottomSheet(
                                useSafeArea: true,
                                backgroundColor: ColorManger.bgLight,
                                context: context,
                                elevation: 0,
                                barrierColor: Colors.white,
                                isScrollControlled: true,
                                builder: (context) => BlocProvider.value(
                                  value: reportCubit,
                                  child: const AddReportScreen(),
                                ),
                              );
                            },
                            foregroundColor: ColorManger.white,
                            backgroundColor: ColorManger.kPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(50),
                            ),
                            child: Icon(Icons.add, size: 28.sp),
                          ),
                        )
                      : null,

                  body: cubit.CurScreen(),
                  bottomNavigationBar: CustomSnakeNavbar(),
                );
              },
            ),
      ),
    );
  }
}
