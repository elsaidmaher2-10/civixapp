import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/home/presentation/manager/mangenavbar/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/home/presentation/view/ProfileScreen.dart';
import 'package:citifix/feature/home/presentation/view/ReportScreen.dart';
import 'package:citifix/feature/home/presentation/view/widget/Customnavarbar.dart';
import 'package:citifix/feature/home/presentation/view/widget/Homeview.dart';
import 'package:citifix/feature/home/presentation/view/widget/MainscreenAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

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
                return Scaffold(
                  body: context
                      .read<MangeCustomBottomnavBarCubit>()
                      .CurScreen(),
                  bottomNavigationBar: CustomWaternavbar(),
                  backgroundColor: Colors.white,
                  appBar: MainscreenAppbar(),
                );
              },
            ),
      ),
    );
  }
}
