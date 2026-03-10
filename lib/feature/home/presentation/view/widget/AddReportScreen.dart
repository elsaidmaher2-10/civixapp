import 'dart:async';
import 'dart:io';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/core/widget/uploadimage.dart';
import 'package:citifix/feature/home/presentation/view/widget/Animatedmarker.dart';
import 'package:citifix/feature/home/presentation/view/widget/CustomMap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddReportScreen extends StatefulWidget {
  const AddReportScreen({super.key});

  @override
  State<AddReportScreen> createState() => _AddReportScreenState();
}

class _AddReportScreenState extends State<AddReportScreen> {
  final StreamController<List<File>> streamController = StreamController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    streamController.close();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> pickImages() async {
    ImagePicker imagePicker = ImagePicker();
    List<XFile>? images = await imagePicker.pickMultiImage();
    if (images != null) {
      streamController.add(images.map((e) => File(e.path)).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
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
                controller: titleController,
              ),
              SizedBox(height: 25.h),
              CustomTextfromfield(
                maxLines: 3,
                hinttext: "Describe the details of the Report.",
                lable: "Report Description",
                controller: descriptionController,
              ),
              SizedBox(height: 34),
              SizedBox(
                height: 140.h,
                child: Row(
                  children: [
                    Uploadimage(onTap: pickImages),
                    Expanded(
                      child: StreamBuilder<List<File>>(
                        initialData: [],
                        stream: streamController.stream,
                        builder: (context, snapshot) => ListView.separated(
                          clipBehavior: Clip.hardEdge,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
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
                          separatorBuilder: (_, __) => const SizedBox(width: 5),
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
              SizedBox(height: 10.h),

              const SizedBox(height: 10),
              CustomMap(),
            ],
          ),
        ),
      ),
    );
  }
}
