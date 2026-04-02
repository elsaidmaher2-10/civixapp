import 'dart:io';

class VerificationrequestModel {
  int? AreaId;
  int? DepartmentId;
  File? NationalIdFrontImage;
  File? NationalIdBackImage;
  String? Notes;
  VerificationrequestModel({
    required this.AreaId,
    required this.DepartmentId,
    required this.NationalIdBackImage,
    required this.NationalIdFrontImage,
    required this.Notes,
  });
}
