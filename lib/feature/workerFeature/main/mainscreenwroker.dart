import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/Home.dart';
import 'package:citifix/feature/workerFeature/main/Manager/cubit/worker_cubit_cubit.dart';
import 'package:citifix/feature/workerFeature/profile/profle.dart';
import 'package:citifix/feature/workerFeature/tasks/taskScreen.dart';
import 'package:citifix/feature/workerFeature/taskDetails/TaskDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mainscreenwroker extends StatefulWidget {
  const Mainscreenwroker({super.key});

  @override
  State<Mainscreenwroker> createState() => _MainscreenwrokerState();
}

class _MainscreenwrokerState extends State<Mainscreenwroker> {
  final List<Widget> _pages = [
    const HomePage(),
    const TasksView(),
    const ProfileView(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkerCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _pages[state],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: ColorManger.white,
            currentIndex: state,
            selectedItemColor: ColorManger.workerprimary,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              context.read<WorkerCubit>().changeCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: Constantmanger.daSHBOARD,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assignment_outlined),
                activeIcon: Icon(Icons.assignment),
                label: Constantmanger.tasks,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: Constantmanger.proile,
              ),
            ],
          ),
        );
      },
    );
  }
}
