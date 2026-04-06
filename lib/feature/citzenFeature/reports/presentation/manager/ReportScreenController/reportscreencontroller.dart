import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' hide LatLng;
import 'package:latlong2/latlong.dart';

class ReportScreenController {
  final StreamController<List<File>> streamController =
      StreamController<List<File>>.broadcast();

  final StreamController<bool> btnController =
      StreamController<bool>.broadcast();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  List<File> selectedFiles = [];

  int categoryItem = -1;

  bool isValid = false;

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

  Future<void> pickImages(BuildContext context) async {
    final provider = DefaultAssetPickerProvider(
      maxAssets: 10,
      requestType: RequestType.all,
    );
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: AssetPicker<AssetEntity, AssetPathEntity>(
            permissionRequestOption: const PermissionRequestOption(),
            builder: DefaultAssetPickerBuilderDelegate(
              specialPickerType: SpecialPickerType.wechatMoment,
              keepScrollOffset: true,
              shouldRevertGrid: true,
              locale: Localizations.localeOf(context),
              pickerTheme: ThemeData(
                colorScheme: ColorScheme.light(),
                useMaterial3: true,
              ),
              provider: provider,
              initialPermission: PermissionState.authorized,
              gridCount: 3,
            ),
          ),
        );
      },
    );

    final selectedAssets = provider.selectedAssets;
    if (selectedAssets.isNotEmpty) {
      List<File> files = [];
      for (final entity in selectedAssets) {
        final file = await entity.file;
        if (file != null) {
          files.add(file);
        }
      }
      selectedFiles = selectedFiles + files;
    } else {
      selectedFiles = [];
    }
    streamController.add(selectedFiles);
    updateButtonStatus();
  }

  void removeImage(int index) {
    if (index >= 0 && index < selectedFiles.length) {
      selectedFiles.removeAt(index);
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
  }
}
