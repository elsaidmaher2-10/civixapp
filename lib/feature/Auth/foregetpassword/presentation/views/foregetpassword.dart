import 'dart:async';

import 'package:civixapp/core/function/sinupvalidator.dart';
import 'package:civixapp/core/resource/colormanager.dart' show ColorManger;
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/foregetpassword/presentation/manager/ForgetpasswordState.dart';
import 'package:civixapp/feature/Auth/foregetpassword/presentation/manager/forgetpasswordcubit.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Foregetpassword extends StatefulWidget {
  Foregetpassword({super.key});

  @override
  State<Foregetpassword> createState() => _ForegetpasswordState();
}

class _ForegetpasswordState extends State<Foregetpassword> {
  bool isvalid = false;
  @override
  void initState() {
    emailController.addListener(() {});
    super.initState();
  }

  StreamController streamController = StreamController.broadcast();
  final TextEditingController emailController = TextEditingController();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Forgetpasswordcubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<Forgetpasswordcubit, Forgetpasswordstate>(
            listener: (context, state) {
              if (state is ForgetpasswordstatecontrollerFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.all(16.w),
                    duration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: ColorManger.red,
                    dismissDirection: DismissDirection.down,
                    content: Text(
                      state.message,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorManger.white,
                        fontSize: screeutilsManager.h16,
                      ),
                    ),
                  ),
                );
              } else if (state is ForgetpasswordstatecontrollerSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.all(16.w),
                    duration: Duration(seconds: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: ColorManger.green,
                    dismissDirection: DismissDirection.endToStart,
                    content: Text(
                      state.response,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: ColorManger.white,
                        fontSize: screeutilsManager.h16,
                      ),
                    ),
                  ),
                );

                Navigator.pushNamed(
                  context,
                  Routes.otpverficationc,
                  arguments: {
                    Constantmanger.email: emailController.text,
                   Constantmanger.screen: Constantmanger.forgetPassword,
                  },
                );
              }
            },

            builder: (context, state) {
              bool inAsyncCall = false;
              if (state is ForgetpasswordstatecontrollerLoading) {
                inAsyncCall = true;
              } else {
                inAsyncCall = false;
              }

              return ModalProgressHUD(
                inAsyncCall: inAsyncCall,
                blur: 7,
                progressIndicator: CupertinoActivityIndicator(
                  radius: 15,
                  color: ColorManger.kprimary,
                ),
                child: Scaffold(
                  backgroundColor: ColorManger.white,
                  appBar: foregetpasswordappbar(context),

                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screeutilsManager.w18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.h),
                        RichText(
                          text: TextSpan(
                            text:
                                "Please enter the email address associated with your account, and we'll send you OTP to reset your password.",
                            style: TextStyle(
                              color: ColorManger.Lightgrey2,
                              fontSize: screeutilsManager.s14,
                            ),
                          ),
                        ),
                        SizedBox(height: 58.h),

                        Email(
                          controller: emailController,
                          validator: (validator) {
                            isvalid = emailvalidator(validator) == null
                                ? true
                                : false;

                            streamController.add(isvalid);
                            return emailvalidator(validator);
                          },
                        ),
                        SizedBox(height: 151.h),

                        SizedBox(
                          width: double.infinity,

                          child: StreamBuilder(
                            initialData: false,
                            stream: streamController.stream,
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) =>
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorManger.kprimary,
                                        foregroundColor: ColorManger.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            screeutilsManager.r10,
                                          ),
                                        ),
                                      ),
                                      onPressed: isvalid == true
                                          ? () async {
                                              context
                                                  .read<Forgetpasswordcubit>()
                                                  .forgetpassword(
                                                    email: emailController.text,
                                                  );
                                            }
                                          : null,
                                      child: Text("Send  Code"),
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

PreferredSizeWidget foregetpasswordappbar(BuildContext context) {
  return AppBar(
    titleSpacing: 3.w,
    centerTitle: true,
    title: Text(
      "Forget Password",
      style: TextStyle(
        color: ColorManger.kprimary,
        fontSize: 20.sp,
        // fontFamily: FontFamily.Otama_ep,
      ),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 36.w,

    leading: Padding(
      padding: EdgeInsets.only(left: 10.w, bottom: screeutilsManager.h4),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(CupertinoIcons.back, color: ColorManger.kprimary),
      ),
    ),
  );
}
