import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

StreamBuilder<String> selectRole(StreamController<String> stream) {
  return StreamBuilder<String>(
    stream: stream.stream,
    builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      return SizedBox(
        height: 46,
        child: DropdownButtonFormField<String>(
          value: snapshot.data, // ده عشان يظهر القيمة المحددة
          isExpanded: false,
          padding: EdgeInsets.zero,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
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
          onChanged: (value) {
            stream.add(value ?? "");
          },
        ),
      );
    },
  );
}
