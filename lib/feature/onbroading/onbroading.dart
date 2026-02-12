import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/feature/onbroading/controller/onbroadingprovider.dart';
import 'package:civixapp/feature/onbroading/widget/on_broading_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onbroading extends StatefulWidget {
  Onbroading({super.key});
  @override
  State<Onbroading> createState() => _OnbroadingState();
}

class _OnbroadingState extends State<Onbroading> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => Onbroadingprovider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: PageView(
              onPageChanged: (value) {
                context.read<Onbroadingprovider>().updateIndex(value);
              },
              controller: context.read<Onbroadingprovider>().controller,
              children: List.generate(
                Constantmanger.pages.length,
                (x) => Customonbroadingitem(
                  value: context.read<Onbroadingprovider>().value,
                  pages: Constantmanger.pages,
                  controller: context.read<Onbroadingprovider>().controller,
                  x: x,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
