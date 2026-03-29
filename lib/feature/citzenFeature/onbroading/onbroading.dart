import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/feature/citzenFeature/onbroading/controller/onbroadingprovider.dart';
import 'package:citifix/feature/citzenFeature/onbroading/widget/on_broading_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onbroading extends StatelessWidget {
  const Onbroading({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Onbroadingprovider(),
      child: Scaffold(
        backgroundColor: ColorManger.reportsPageBackground,
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
