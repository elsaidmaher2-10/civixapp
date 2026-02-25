import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Uploadimage extends StatelessWidget {
  const Uploadimage({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingupCubit, SingupState>(
      builder: (context, state) {
        Widget imageWidget;

        if (state is Singupimageselected) {
          imageWidget = Image.file(
            state.image,
            height: 120,
            width: 200.w,
            fit: BoxFit.cover,
          );
        } else if (state is Singupimagedosentselected) {
          imageWidget = Icon(
            Icons.upload_file,
            color: ColorManger.red,
            size: 40,
          );
        } else {
          imageWidget = Image.asset(
            AssetValueManager.uploadimage,
            fit: BoxFit.fill,
            height: 30,
          );
        }

        return Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Upload Image For Your Profile",
                  style: TextStyle(fontSize: 16.sp, color: Color(0xff505050)),
                ),
              ),

              SizedBox(height: 8.h),

              Align(
                alignment: AlignmentGeometry.topCenter,
                child: DottedBorder(
                  options: RoundedRectDottedBorderOptions(
                    color: state is Singupimageselected
                        ? ColorManger.green
                        : state is Singupimagedosentselected
                        ? ColorManger.red
                        : ColorManger.kprimary,
                    radius: Radius.circular(8),
                    dashPattern: [10, 5],
                    strokeWidth: 2,
                    padding: EdgeInsets.all(16),
                  ),
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          imageWidget,

                          SizedBox(height: 16.sp),
                          Text(
                            "Select file",
                            style: TextStyle(
                              color: state is Singupimageselected
                                  ? ColorManger.green
                                  : state is Singupimagedosentselected
                                  ? ColorManger.red
                                  : ColorManger.kprimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
