import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerController {
  static final ImagePickerController _instance =
      ImagePickerController._internal();
  factory ImagePickerController() => _instance;
  ImagePickerController._internal();

  final StreamController<File?> _streamController =
      StreamController.broadcast();
  final StreamController<bool> _loadingController =
      StreamController<bool>.broadcast();
  final ImagePicker _picker = ImagePicker();

  Stream<File?> get stream => _streamController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<File?> pickImage(ImageSource source) async {
    _setLoading(true);

    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        _streamController.add(imageFile);
        _setLoading(false);
        return imageFile;
      }
      _setLoading(false);
      return null;
    } catch (e) {
      _setLoading(false);
      rethrow;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    _loadingController.add(loading);
  }

  void reset() {
    _streamController.add(null);
    _setLoading(false);
  }

  void dispose() {
    _streamController.close();
    _loadingController.close();
  }
}
