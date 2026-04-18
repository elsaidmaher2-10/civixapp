import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/controller/onbroadingprovider.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/on_broading_item.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Onbroading extends StatefulWidget {
  const Onbroading({super.key});

  @override
  State<Onbroading> createState() => _OnbroadingState();
}

class _OnbroadingState extends State<Onbroading> {
  @override
  void initState() {
    super.initState();
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
    return ChangeNotifierProvider(
      create: (context) => Onbroadingprovider(),
      child: Scaffold(
        backgroundColor: context.palette.reportsPageBackground,
        body: Consumer<Onbroadingprovider>(
          builder: (context, provider, child) {
            return PageView.builder(
              allowImplicitScrolling: true,
              physics: const BouncingScrollPhysics(),
              itemCount: Constantmanger.pages.length,
              controller: provider.controller,
              onPageChanged: (index) {
                provider.updateIndex(index);
              },
              itemBuilder: (context, index) {
                return Customonbroadingitem(index: index);
              },
            );
          },
        ),
      ),
    );
  }
}
