import 'dart:io';

extension FileTypeExtension on File {
  bool get isVideo {
    final extension = path.split('.').last.toLowerCase();
    return ['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv'].contains(extension);
  }

  bool get isImage {
    final extension = path.split('.').last.toLowerCase();
    return [
      'jpg',
      'jpeg',
      'png',
      'gif',
      'webp',
      'heic',
      'bmp',
    ].contains(extension);
  }
}
