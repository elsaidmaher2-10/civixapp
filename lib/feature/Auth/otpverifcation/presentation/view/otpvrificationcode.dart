// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/core/widget/CustomSnackBar.dart';
import 'package:civixapp/feature/Auth/otpverifcation/data/models/otpmodel.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/manager/cubit/otp_verication_cubit.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/manager/cubit/otp_verication_state.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/view/widget/resendCodeOpt.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Otpvrificationcode extends StatefulWidget {
  const Otpvrificationcode({super.key});

  @override
  State<Otpvrificationcode> createState() => _OtpvrificationcodeState();
}

class _OtpvrificationcodeState extends State<Otpvrificationcode> {
  final int otpLength = 6;

  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(otpLength, (_) => TextEditingController());
    focusNodes = List.generate(otpLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus();
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  String getOtpCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    return BlocProvider(
      create: (BuildContext context) => OtpVericationCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<OtpVericationCubit, OtpVericationState>(
            listener: (context, state) async {
              if (state is OtpVericationFailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.red,
                  message: state.failureResponse.errors.join("-"),
                );
              } else if (state is OtpVericationSucces) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.green,
                  message:
                      args[Constantmanger.screen] ==
                          Constantmanger.forgetPassword
                      ? Constantmanger.msgresetingpass
                      : state.otpsuccessmodel.message,
                );

                if (Constantmanger.forgetPassword ==
                    args[Constantmanger.screen]) {
                  await Future.delayed(
                    Duration(seconds: 2),
                    () async => Navigator.pushNamed(
                      context,
                      Routes.confirmPassword,
                      arguments: {
                        Constantmanger.email: args[Constantmanger.email],
                        Constantmanger.otp: getOtpCode(),
                      },
                    ),
                  );
                } else {
                  await Future.delayed(
                    Duration(seconds: 2),
                    () async => Navigator.pushNamed(context, Routes.login),
                  );
                }
              }
            },

            builder: (context, state) {
              log(state.toString());
              bool inAsyncCall = false;
              if (state is OtpVericationLoading) {
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
                  appBar: otpappbar(context, () {}),
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screeutilsManager.w18,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6.h),
                        Text(
                          args[Constantmanger.screen] ==
                                  Constantmanger.forgetPassword
                              ? Constantmanger.msgforResetpassword
                              : Constantmanger.msgforregister,
                          style: TextStyle(
                            color: ColorManger.Lightgrey2,
                            fontSize: 14.sp,
                            // fontFamily: FontFamily.Otama_ep,
                          ),
                        ),
                        SizedBox(height: 48.h),

                        Row(
                          children: List.generate(otpLength, (index) {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: TextFormField(
                                  controller: controllers[index],
                                  focusNode: focusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  onChanged: (value) =>
                                      onOtpChanged(value, index),
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        SizedBox(height: 21.h),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManger.kprimary,
                              foregroundColor: ColorManger.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  screeutilsManager.r10,
                                ),
                              ),
                            ),
                            onPressed: () {
                              final otp = getOtpCode();
                              print(args[Constantmanger.email]);
                              context.read<OtpVericationCubit>().verifyOtp(
                                OtpModel(
                                  Email: args[Constantmanger.email],
                                  code: otp,
                                ),
                                isReset:
                                    args[Constantmanger.screen] ==
                                        Constantmanger.forgetPassword
                                    ? true
                                    : false,
                              );
                            },
                            child: const Text("Confirm"),
                          ),
                        ),

                        ResendCodeOpt(
                          resend: () {
                            context.read<OtpVericationCubit>().sendOtp(
                              args[Constantmanger.email],
                            );
                          },
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
