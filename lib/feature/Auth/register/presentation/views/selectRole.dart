import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

StreamBuilder<String> selectRole(
  StreamController<String> stream, {
  void Function(String?)? onchanged,
}) {
  return StreamBuilder<String>(
    stream: stream.stream,
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return SizedBox(
        height: 46,
        child: DropdownButtonFormField<String>(
          initialValue: snapshot.data,
          isExpanded: false,
          padding: EdgeInsets.zero,

          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Image.asset("assets/user.png", height: 2, width: 4),
            ),
            contentPadding: EdgeInsets.zero,
            maintainHintHeight: true,
            maintainHintSize: true,
            filled: true,
            fillColor: Color(0xffF6F6F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),

          isDense: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select a role";
            }
            return null;
          },
          dropdownColor: Color(0xffF6F6F6),
          hint: Text(
            "Select a role",
            style: TextStyle(color: Colors.black, fontSize: 14.sp),
          ),
          items: [
            DropdownMenuItem(
              value: "WORKER",
              child: Text(
                "Worker",
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ),
            DropdownMenuItem(
              value: "CITIZEN",
              child: Text(
                "Citizen",
                style: TextStyle(color: Colors.black, fontSize: 12.sp),
              ),
            ),
          ],
          onChanged: onchanged,
        ),
      );
    },
  );
}
