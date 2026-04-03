import 'dart:async';
import 'dart:io';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;
import 'package:latlong2/latlong.dart';

class ReportScreenController {
  final StreamController<List<File>> streamController =
      StreamController.broadcast();
  final StreamController<bool> btnController = StreamController.broadcast();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<AssetEntity> results = [];
  int categoryItem = -1;
  bool isValid = false;
  List<File> selectedFiles = [];
  String? selectedStreet;
  LatLng? selectedLatLng;

  bool isAnonymous = false;

  void init() {
    titleController.addListener(updateButtonStatus);
    descriptionController.addListener(updateButtonStatus);
  }

  void dispose() {
    streamController.close();
    btnController.close();
    titleController.dispose();
    descriptionController.dispose();
  }

  void pickImages(BuildContext context) async {
    results =
        await AssetPicker.pickAssets(
          context,
          pickerConfig: AssetPickerConfig(
            gridCount: 3,
            pageSize: 30,
            pickerTheme: ThemeData(
              brightness: Brightness.light,
              primaryColor: ColorManger.primary,
              secondaryHeaderColor: ColorManger.primary,
              textTheme: TextTheme(),
              bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ) ??
        [];

    if (results.isNotEmpty) {
      List<File> files = [];
      for (var entity in results) {
        final file = await entity.file;
        if (file != null) {
          files.add(file);
        }
      }
      selectedFiles = files;
      streamController.add(selectedFiles);
      updateButtonStatus();
    } else {
      selectedFiles = [];
      streamController.add(selectedFiles);
      updateButtonStatus();
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedFiles.length) {
      selectedFiles.removeAt(index);
      results.removeAt(index);
      streamController.add(selectedFiles);
      updateButtonStatus();
    }
  }

  void setCategory(int id) {
    categoryItem = id;
    updateButtonStatus();
  }

  void updateButtonStatus() {
    isValid =
        titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        categoryItem != -1 &&
        selectedFiles.isNotEmpty;
    if (!btnController.isClosed) {
      btnController.add(isValid);
    }
    btnController.add(isValid);
  }
}
