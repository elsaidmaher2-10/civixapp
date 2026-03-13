import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/DI/getit.dart';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/home/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/home/data/Repos/reports/reports.dart';
import 'package:citifix/feature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/home/presentation/view/widget/ImagePickerList.dart';
import 'package:citifix/feature/home/presentation/view/widget/ReportForms.dart';
import 'package:citifix/feature/home/presentation/view/widget/addreportAppbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final StreamController<List<File>> streamController = StreamController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  SingleSelectController controller = SingleSelectController(null);
  StreamController<bool> ButtonStatus = StreamController();
  bool isValid = false;
  List<XFile>? images;
  @override
  void dispose() {
    streamController.close();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void pickImages() async {
    ImagePicker imagePicker = ImagePicker();
    images = await imagePicker.pickMultiImage();
    if (images?.isNotEmpty ?? false) {
      streamController.add(images!.map((e) => File(e.path)).toList());
    }
    ;
  }

  Buttonstatus() {
    isValid =
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        controller.value != null;
    ButtonStatus.add(isValid);
  }

  @override
  void initState() {
    titleController.addListener(Buttonstatus);
    descriptionController.addListener(Buttonstatus);
    controller.addListener(Buttonstatus);
    super.initState();
  }

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
                  onCategoryChanged: (p1) {},
                  controller: controller,
                ),
                SizedBox(height: ScreenUtilsManager.h16),
                ImagePickerList(
                  images: images?.map((e) => File(e.path)).toList(),
                  onAddImage: () {
                    pickImages();
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
                CustomMap(onmapCreated: (String street, LatLng latlang) {}),
                SizedBox(height: ScreenUtilsManager.h16),
                StreamBuilder<bool>(
                  initialData: false,
                  stream: ButtonStatus.stream,
                  builder:
                      (
                        BuildContext context,
                        AsyncSnapshot<bool> snapshot,
                      ) => CustomButton(
                        onPressed: snapshot.data == true
                            ? null
                            : () async {
                                final result =
                                    await ReportRepository(
                                      service: getIt<Apiservice>(),
                                      internetChecker: getIt<InternetChecker>(),
                                    ).addReport(
                                      request: CreateReportRequest(
                                        title: 'جمبي واحد يدعي االحديدي',
                                        description:
                                            'هارب من استريم ارجو القبض عليه',
                                        location: 'Main Street',
                                        latitude: 30.0444,
                                        longitude: 31.2357,
                                        categoryId: 12,
                                        images: images!
                                            .map((e) => e.path)
                                            .toList(),
                                      ),
                                    );

                                result.fold(
                                  (failure) => print(failure.errors),
                                  (report) =>
                                      print('Report created: ${report}'),
                                );
                              },
                        lable: Constantmanger.sendReport,
                      ),
                ),
                SizedBox(height: ScreenUtilsManager.h16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
