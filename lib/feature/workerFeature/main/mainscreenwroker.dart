import 'package:citifix/core/cubit/theme/theme_cubit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/theme/app_theme.dart';
import 'package:citifix/feature/workerFeature/home/presentation/view/Home.dart';
import 'package:citifix/feature/workerFeature/main/Manager/cubit/worker_cubit_cubit.dart';
import 'package:citifix/feature/workerFeature/profile/profile_view.dart';
import 'package:citifix/feature/workerFeature/tasks/taskScreen.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Mainscreenwroker extends StatefulWidget {
  const Mainscreenwroker({super.key});

  @override
  State<Mainscreenwroker> createState() => _MainscreenwrokerState();
}

class _MainscreenwrokerState extends State<Mainscreenwroker> {
  final PageController _pageController = PageController();
  final List<Widget> _pages = [HomePage(), const TasksView(), ProfileView()];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return Theme(
          data: themeMode == ThemeMode.dark
              ? AppTheme.dark(AppRole.worker)
              : AppTheme.light(AppRole.worker),
          child: BlocConsumer<WorkerCubit, int>(
            listener: (context, state) {
              if (_pageController.hasClients &&
                  _pageController.page?.round() != state) {
                _pageController.animateToPage(
                  state,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            builder: (context, state) {
              return Scaffold(
                body: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<WorkerCubit>().changeCurrentIndex(index);
                  },
                  children: _pages,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  selectedLabelStyle: GoogleFonts.cairo(),
                  unselectedLabelStyle: GoogleFonts.cairo(),
                  backgroundColor: context.palette.surfaceContainerLowest,
                  currentIndex: state,
                  selectedItemColor: context.palette.workerprimary,
                  unselectedItemColor: context.palette.onSurfaceVariant,
                  type: BottomNavigationBarType.fixed,
                  onTap: (index) {
                    context.read<WorkerCubit>().changeCurrentIndex(index);
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard_outlined),
                      activeIcon: Icon(Icons.dashboard),
                      label: S.of(context).home,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.assignment_outlined),
                      activeIcon: Icon(Icons.assignment),
                      label: S.of(context).reports,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
                      label: S.of(context).profile,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
