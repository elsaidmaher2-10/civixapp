import 'dart:async';
import 'dart:io';

import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/core/widget/uploadimage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

addReportScreen(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    isDismissible: true,
    context: context,
    builder: (BuildContext ctx) {
      StreamController<List<File>> streamController = StreamController();

      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              CupertinoIcons.back,
              size: 25.h,
              color: ColorManger.kprimary,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            "Add Report",
            style: TextStyle(
              color: ColorManger.kprimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              CustomTextfromfield(
                hinttext: "Street hole",
                lable: "Report title ",
                controller: TextEditingController(),
              ),
              SizedBox(height: 25.h),
              CustomTextfromfield(
                maxLines: 3,
                hinttext: "Describe the details of the Report.",
                lable: "Report Description",
                controller: TextEditingController(),
              ),
              SizedBox(height: 34),
              SizedBox(
                height: 140.h,
                child: Row(
                  children: [
                    Uploadimage(
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        List<XFile> iamges = await imagePicker.pickMultiImage();
                        streamController.add(
                          iamges.map((e) => File(e.path)).toList(),
                        );
                      },
                    ),
                    Expanded(
                      child: StreamBuilder<List<File>>(
                        initialData: [],
                        stream: streamController.stream,
                        builder: (BuildContext context, snapshot) =>
                            ListView.separated(
                              clipBehavior: Clip.hardEdge,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, index) => ClipRRect(
                                borderRadius: BorderRadiusGeometry.circular(
                                  8.r,
                                ),
                                child: SizedBox(
                                  height: 125.h,
                                  width: 125.w,
                                  child: Image.file(
                                    fit: BoxFit.fill,
                                    snapshot.data![index],
                                  ),
                                ),
                              ),
                              itemCount: snapshot.data?.length ?? 0,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(width: 5),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                "Location",
                style: TextStyle(
                  color: ColorManger.kprimary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(
                height: 140,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}