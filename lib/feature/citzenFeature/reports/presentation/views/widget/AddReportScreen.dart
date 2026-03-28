import 'dart:async';
import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customButton.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_cubit.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/manager/reportManger/cubit/report_manager_state.dart';
import 'package:citifix/feature/citzenFeature/home/presentation/view/widget/CustomMap.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ImagePickerList.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/Report/CreateReportRequestModel.dart';
import 'package:citifix/feature/citzenFeature/reports/data/Models/catogory/categorymodels.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/ReportForms.dart';
import 'package:citifix/feature/citzenFeature/reports/presentation/views/widget/addreportAppbar.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
  Widget build(BuildContext context) {
    return BlocConsumer<ReportCubit, ReportManagerState>(
      listener: (context, state) async {
        if (state is CreateReportSuccess) {
          Customsnackbar.show(
            context: context,
            backgroundColor: ColorManger.green,
            message: S.of(context).reportSentSuccess,
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
        bool inAsyncCall = state is CreateReportLoading;

        return ModalProgressHUD(
          inAsyncCall: inAsyncCall,
          blur: 7,
          progressIndicator: customloading(),
          child: Scaffold(
            backgroundColor: ColorManger.white,
            appBar: AddReportAppbar(context),
            body: SafeArea(
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
                        S.of(context).location,
                        style: TextStyle(
                          color: ColorManger.kPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtilsManager.s16,
                        ),
                      ),

                      SizedBox(height: ScreenUtilsManager.h16),

                      CustomMap.fromDevice(
                        onmapCreated: (String street, LatLng latlang) {
                          selectedStreet = street;
                          selectedLatLng = latlang;
                        },
                      ),

                      SizedBox(height: ScreenUtilsManager.h24),

                      CustomButton(
                        onPressed: (isValid && state is! CreateReportLoading)
                            ? () {
                                context.read<ReportCubit>().createReport(
                                  request: CreateReportRequest(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    location:
                                        selectedStreet ??
                                        S.of(context).unknownLocation,
                                    latitude: selectedLatLng?.latitude ?? 0.0,
                                    longitude: selectedLatLng?.longitude ?? 0.0,
                                    categoryId: categoryitem,
                                    images:
                                        images?.map((e) => e.path).toList() ??
                                        [],
                                  ),
                                );
                              }
                            : null,
                        lable: S.of(context).sendReport,
                      ),

                      SizedBox(height: ScreenUtilsManager.h24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
