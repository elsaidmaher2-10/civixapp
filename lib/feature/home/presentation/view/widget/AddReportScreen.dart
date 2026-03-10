import 'dart:async';
import 'dart:io';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/imagepickerservice.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/home/presentation/view/widget/ImagePickerList.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportForms.dart';
import 'package:citifix/feature/home/presentation/view/widget/addreportAppbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final StreamController<List<File>> streamController = StreamController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<XFile>? images;
  @override
  void dispose() {
    streamController.close();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  final List<String> _list = ['Developer', 'Designer', 'Consultant', 'Student'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AddReportAppbar(context),
        backgroundColor: ColorManger.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtilsManager.p23),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtilsManager.h40),
                ReportFormFields(
                  titleController: titleController,
                  descriptionController: descriptionController,
                  categories: _list,
                  onCategoryChanged: (p1) {},
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                ImagePickerList(
                  images: images?.map((e) => File(e.path)).toList(),
                  onAddImage: () {
                    pickImages(images, streamController);
                  },
                  stream: streamController.stream,
                  onRemove: (int index) {
                    images?.removeAt(index);
                    streamController.add(
                      images?.map((e) => File(e.path)).toList() ?? [],
                    );
                  },
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                Text(
                  Constantmanger.location,
                  style: TextStyle(
                    color: ColorManger.kprimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                CustomMap(),
                SizedBox(height: ScreenUtilsManager.h16),
                CustomButton(onPressed: () {}),
                SizedBox(height: ScreenUtilsManager.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
