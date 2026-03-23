import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectRoleDropdown extends StatelessWidget {
  final StreamController<String> streamController;
  final void Function(String?)? onChanged;

  const SelectRoleDropdown({
    super.key,
    required this.streamController,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: streamController.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return DropdownButtonFormField<String>(
          value: snapshot.data,
          isExpanded: true, // يمنع تجاوز النص (Overflow) إذا كان طويلاً
          autovalidateMode: AutovalidateMode.onUserInteraction,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),

          borderRadius: BorderRadius.circular(8.r),
          dropdownColor: const Color(0xffF6F6F6),

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF6F6F6),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Image.asset("assets/user.png", height: 20.h, width: 20.w),
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 40.w,
              minHeight: 40.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: ColorManger.kPrimary, width: 1.5),
            ),
          ),

          hint: Text(
            "Select a role",
            style: TextStyle(color: Colors.black54, fontSize: 14.sp),
          ),

          items: [
            DropdownMenuItem(
              value: "WORKER",
              child: Text(
                "Worker",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ),
            DropdownMenuItem(
              value: "CITIZEN",
              child: Text(
                "Citizen",
                style: TextStyle(color: Colors.black, fontSize: 14.sp),
              ),
            ),
          ],

          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a role";
            }
            return null;
          },
        );
      },
    );
  }
}
