import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerController {
  static final ImagePickerController _instance =
      ImagePickerController._internal();
  factory ImagePickerController() => _instance;
  ImagePickerController._internal();

  final StreamController<File?> streamController =
      StreamController.broadcast();
  final ImagePicker _picker = ImagePicker();
  Stream<File?> get stream => streamController.stream;
  Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      streamController.add(imageFile);
      return imageFile;
    }
    return null;
  }

  void reset() => streamController.add(null);
  void dispose() => streamController.close();
}