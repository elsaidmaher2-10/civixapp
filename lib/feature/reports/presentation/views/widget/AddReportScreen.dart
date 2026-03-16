import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/reports/presentation/views/widget/ImagePickerList.dart';
import 'package:citifix/feature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/reports/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/reports/presentation/views/widget/ReportForms.dart';
import 'package:citifix/feature/reports/presentation/views/widget/addreportAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final StreamController<List<File>> streamController =
      StreamController.broadcast();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  SingleSelectController<CategoryItem?>? controller;
  int categoryitem = -1;
  StreamController<bool> buttonStatusController = StreamController.broadcast();

  bool isValid = false;
  List<XFile>? images = [];
  String? selectedStreet;
  LatLng? selectedLatLng;

  @override
  void dispose() {
    streamController.close();
    titleController.dispose();
    descriptionController.dispose();
    buttonStatusController.close();
    super.dispose();
  }

  void pickImages() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages.isNotEmpty) {
      setState(() {
        images!.addAll(pickedImages);
      });
      streamController.add(images!.map((e) => File(e.path)).toList());
    }
  }

  void updateButtonStatus() {
    setState(() {
      isValid =
          titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          categoryitem != -1;
    });
    buttonStatusController.add(isValid);
  }

  @override
  void initState() {
    titleController.addListener(updateButtonStatus);
    descriptionController.addListener(updateButtonStatus);
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportManagerState>(
      listener: (context, state) async {
        if (state is CreateReportSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: state.message,
          );
          Navigator.pop(context);
        } else if (state is CreateReportFailure) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.red,
            message: state.errMessage,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorManger.white,
          appBar: AddReportAppbar(context),
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtilsManager.p23,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: ScreenUtilsManager.h40),
                        ReportFormFields(
                          titleController: titleController,
                          descriptionController: descriptionController,
                          onCategoryChanged: (p1) {
                            setState(() {
                              categoryitem = p1?.id ?? -1;
                              controller?.value = p1;
                              updateButtonStatus();
                            });
                          },
                          controller: controller,
                        ),
                        SizedBox(height: ScreenUtilsManager.h16),
                        ImagePickerList(
                          images: images?.map((e) => File(e.path)).toList(),
                          onAddImage: pickImages,
                          stream: streamController.stream,
                          onRemove: (int index) {
                            setState(() {
                              images?.removeAt(index);
                            });
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
                        CustomMap.fromDevice(
                          onmapCreated: (String street, LatLng latlang) {
                            selectedStreet = street;
                            selectedLatLng = latlang;
                          },
                        ),
                        SizedBox(height: ScreenUtilsManager.h16),
                        CustomButton(
                          onPressed:
                              (isValid && state is! CreateReportLoading)
                              ? () {
                                  context.read<ReportCubit>().createReport(
                                    request: CreateReportRequest(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      location:
                                          selectedStreet ??
                                          'Unknown Location',
                                      latitude:
                                          selectedLatLng?.latitude ?? 0.0,
                                      longitude:
                                          selectedLatLng?.longitude ?? 0.0,
                                      categoryId: categoryitem,
                                      images: images!
                                          .map((e) => e.path)
                                          .toList(),
                                    ),
                                  );
                                }
                              : null,
                          lable: Constantmanger.sendReport,
                        ),
                        SizedBox(height: ScreenUtilsManager.h16),
                      ],
                    ),
                  ),
                ),
              ),
    
              if (state is CreateReportLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CupertinoActivityIndicator(
                            radius: 20,
                            color: ColorManger.kprimary,
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Sending Report...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
