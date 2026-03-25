import 'dart:async';

import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/colormanager.dart' show ColorManger;
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/foregetpassword/presentation/manager/ForgetpasswordState.dart';
import 'package:citifix/feature/Auth/foregetpassword/presentation/manager/forgetpasswordcubit.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Foregetpassword extends StatefulWidget {
  const Foregetpassword({super.key});

  @override
  State<Foregetpassword> createState() => _ForegetpasswordState();
}

class _ForegetpasswordState extends State<Foregetpassword> {
  bool isvalid = false;
  final StreamController streamController = StreamController.broadcast();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    streamController.close();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Forgetpasswordcubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<Forgetpasswordcubit, Forgetpasswordstate>(
            listener: (context, state) async {
              if (state is ForgetpasswordstatecontrollerFailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.red,
                  message: state.message,
                );
              } else if (state is ForgetpasswordstatecontrollerSuccess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.green,
                  message: state.response,
                );
                Future.delayed(
                  const Duration(seconds: 3),
                  () => Navigator.pushNamed(
                    context,
                    Routes.otpverficationc,
                    arguments: {
                      Constantmanger.email: emailController.text.trim(),
                      Constantmanger.screen: Constantmanger.forgetPassword,
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              bool inAsyncCall = state is ForgetpasswordstatecontrollerLoading;

              return ModalProgressHUD(
                inAsyncCall: inAsyncCall,
                blur: 7,
                color: Colors.white,
                opacity: 0.5,
                progressIndicator: customloading(),
                child: Scaffold(
                  backgroundColor: ColorManger.white,
                  appBar: foregetpasswordappbar(context),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),

                          Center(
                            child: Icon(
                              Icons.lock_reset_rounded,
                              size: 80.r,
                              color: ColorManger.kPrimary.withOpacity(0.8),
                            ),
                          ),
                          SizedBox(height: 30.h),

                          Text(
                            "Please enter the email address associated with your account, and we'll send you an OTP to reset your password.",
                            style: TextStyle(
                              color: ColorManger.lightGrey2,
                              fontSize: ScreenUtilsManager.s14,
                              height: 1.5,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40.h),

                          Email(
                            controller: emailController,
                            validator: (validator) {
                              isvalid =
                                  emailvalidator(context, validator) == null
                                  ? true
                                  : false;
                              streamController.add(isvalid);
                              return emailvalidator(context, validator);
                            },
                          ),
                          SizedBox(height: 60.h),

                          SizedBox(
                            width: double.infinity,
                            child: StreamBuilder(
                              initialData: false,
                              stream: streamController.stream,
                              builder: (context, snapshot) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManger.kPrimary,
                                  foregroundColor: ColorManger.white,
                                  disabledForegroundColor: Colors.white70,
                                  elevation: 2,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      ScreenUtilsManager.r10,
                                    ),
                                  ),
                                ),
                                onPressed: snapshot.data == true
                                    ? () async {
                                        FocusScope.of(context).unfocus();
                                        context
                                            .read<Forgetpasswordcubit>()
                                            .forgetpassword(
                                              isreset: true,
                                              email: emailController.text
                                                  .trim(),
                                              purpose: "reset your password",
                                            );
                                      }
                                    : null,
                                child: Text(
                                  "Send Code",
                                  style: TextStyle(
                                    fontSize: ScreenUtilsManager.s16,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
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
    elevation: 0,
    scrolledUnderElevation: 0,
    title: Text(
      "Forget Password",
      style: TextStyle(
        color: ColorManger.kPrimary,
        fontSize: ScreenUtilsManager.s20,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: ColorManger.white,
    leadingWidth: 50.w,
    leading: Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: IconButton(
        splashRadius: 24,

        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          CupertinoIcons.back,
          color: ColorManger.kPrimary,
          size: 28.r,
        ),
      ),
    ),
  );
}
