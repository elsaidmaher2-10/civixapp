import 'dart:async';
import 'dart:io';
import 'package:citifix/core/widget/mediapicker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  final ImagePicker _imagePicker = ImagePicker();

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
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) => PickerBottomSheet(
        onCameraPhoto: () async {
          Navigator.pop(context);
          await _pickFromCamera(isVideo: false);
        },
        onCameraVideo: () async {
          Navigator.pop(context);
          await _pickFromCamera(isVideo: true);
        },
        onFilesSelected: (files) {
          selectedFiles = [...files.reversed, ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        },
      ),
    );
  }

  Future<void> _pickFromCamera({required bool isVideo}) async {
    try {
      if (isVideo) {
        final XFile? video = await _imagePicker.pickVideo(
          source: ImageSource.camera,
        );
        if (video != null) {
          selectedFiles = [File(video.path), ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        }
      } else {
        final XFile? photo = await _imagePicker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) {
          selectedFiles = [File(photo.path), ...selectedFiles];
          streamController.add(selectedFiles);
          updateButtonStatus();
        }
      }
    } catch (e) {
      debugPrint('Camera error: $e');
    }
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
