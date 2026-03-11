import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/home/presentation/manager/mangenavbar/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/home/presentation/view/widget/AddReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/widget/Customnavarbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: library_private_types_in_public_api
final GlobalKey<NavigatorState> mainscreenKey = GlobalKey<NavigatorState>();

class Mainscreen extends StatefulWidget {
  const Mainscreen({mainscreenKey});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MangeCustomBottomnavBarCubit(),
      child: Builder(
        builder: (BuildContext context) =>
            BlocBuilder<
              MangeCustomBottomnavBarCubit,
              MangeCustomBottomnavBarState
            >(
              builder: (context, state) {
                final cubit = context.read<MangeCustomBottomnavBarCubit>();
                return Scaffold(
                  backgroundColor: ColorManger.white,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: cubit.curindex == 0
                      ? SizedBox(
                          height: 62.h,
                          width: 62.w,
                          child: FloatingActionButton(
                            splashColor: ColorManger.Lightgrey3,
                            onPressed: () {
                              showModalBottomSheet(
                                useSafeArea: true,
                                backgroundColor: Colors.white,
                                context: context,
                                elevation: 0,
                                barrierColor: Colors.white,
                                isScrollControlled: true,
                                builder: (context) => const AddReportScreen(),
                              );
                            },
                            foregroundColor: ColorManger.white,
                            backgroundColor: ColorManger.kprimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(50),
                            ),
                            child: Icon(Icons.add, size: 28.sp),
                          ),
                        )
                      : null,

                  body: cubit.CurScreen(),
                  bottomNavigationBar: const CustomWaternavbar(),
                );
              },
            ),
      ),
    );
  }
}
