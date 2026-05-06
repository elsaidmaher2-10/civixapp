import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/citzenFeature/Profile/data/repos/UserProfileRepos/userprofileRepos.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/manager/navbarManger/mange_custom_bottomnav_bar_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/core/cubit/userinfoManger/user_profile_info_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/AddReportScreen.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/Customnavarbar.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CitizenMainScreen extends StatefulWidget {
  const CitizenMainScreen({super.key, CitizenMainScreenKey});

  @override
  State<CitizenMainScreen> createState() => _CitizenMainScreenState();
}

class _CitizenMainScreenState extends State<CitizenMainScreen> {
  @override
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ReportCubit>().fetchReports());
    _checkForUpdates();
  }

  Future<void> _checkForUpdates() async {
    try {
      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 0),
        ),
      );

      await remoteConfig.fetchAndActivate();

      String requiredVersion = remoteConfig.getString('min_version');
      String updateUrl = remoteConfig.getString('update_url');

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      if (requiredVersion.isNotEmpty && currentVersion != requiredVersion) {
        _showForceUpdateDialog(updateUrl);
      }
    } catch (e) {
      print("Error checking updates: $e");
    }
  }

  void _showForceUpdateDialog(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text("تحديث هام متاح! 🚀"),
          content: const Text(
            "تم إطلاق نسخة جديدة من التطبيق. يجب عليك التحديث للاستمرار في الاستخدام.",
          ),
          actions: [
            ElevatedButton(
              child: const Text("تحميل التحديث"),
              onPressed: () async {
                final Uri updateUri = Uri.parse(url);
                if (await canLaunchUrl(updateUri)) {
                  await launchUrl(
                    updateUri,
                    mode: LaunchMode.externalApplication,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
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
                  backgroundColor: context.palette.reportsPageBackground,
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.endFloat,
                  floatingActionButton: cubit.curindex == 0
                      ? SizedBox(
                          height: 62.h,
                          width: 62.w,
                          child: FloatingActionButton(
                            splashColor: context.palette.lightGrey3,
                            onPressed: () async {
                              final reportCubit = context.read<ReportCubit>();
                              await showModalBottomSheet(
                                useSafeArea: false,
                                backgroundColor: context.palette.bgBackground,
                                context: context,
                                elevation: 0,
                                isScrollControlled: true,
                                builder: (context) => BlocProvider.value(
                                  value: reportCubit,
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: const AddReportScreen(),
                                  ),
                                ),
                              );
                            },
                            foregroundColor: context.palette.white,
                            backgroundColor: context.palette.kPrimary,
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
