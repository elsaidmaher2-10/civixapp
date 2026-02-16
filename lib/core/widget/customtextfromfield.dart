import 'package:civixapp/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextfromfield extends StatelessWidget {
  CustomTextfromfield({
    this.readonly = false,
    super.key,
    this.initialValue,
    required this.hinttext,
    this.suffix,
    required this.lable,
    this.validator,
    this.obstext = false,
    required this.controller,
    this.prefix,
    this.onChanged,
    this.ktype = TextInputType.text,
    this.onTap,
  });
  Function()? onTap;
  bool readonly;
  String hinttext;
  IconButton? suffix;
  TextInputType ktype;
  bool obstext;
  Function(String)? onChanged;
  TextEditingController controller;
  String? Function(String?)? validator;
  Widget? prefix;
  String lable;
  String? initialValue;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onTap: onTap,
      readOnly: readonly,
      keyboardType: ktype,
      onChanged: onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      validator: validator,
      obscureText: obstext,
      decoration: InputDecoration(
        prefixIcon: prefix,
        labelStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
        alignLabelWithHint: true,
        labelText: lable,
        isDense: false,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        contentPadding: EdgeInsets.only(
          left: 2,
          bottom: 10,
          top: 10,
          right: 10,
        ),
        fillColor: Color(0xffF6F6F6),
        filled: true,
        suffixIcon: suffix,
        hintText: hinttext,
        hintStyle: TextStyle(color: Color(0xff6C6C6C), fontSize: 12.sp),
        border: OutlineInputBorder(

          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.r),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 15,
          borderSide: BorderSide(color: Color(0xff04332D), width: 1),
          borderRadius: BorderRadius.circular(10.r),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Color(0xffFC1B1A), width: 2),
        ),
      ),
    );
  }
}
