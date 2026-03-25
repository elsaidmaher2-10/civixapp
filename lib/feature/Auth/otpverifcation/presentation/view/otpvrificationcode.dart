import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/otpverifcation/data/models/otpmodel.dart';
import 'package:citifix/feature/Auth/otpverifcation/presentation/manager/cubit/otp_verication_cubit.dart';
import 'package:citifix/feature/Auth/otpverifcation/presentation/manager/cubit/otp_verication_state.dart';
import 'package:citifix/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:citifix/feature/Auth/otpverifcation/presentation/view/widget/resendCodeOpt.dart';
import 'package:citifix/generated/l10n.dart';
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
  final ValueNotifier<bool> isOtpComplete = ValueNotifier(false);

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
    isOtpComplete.dispose();
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
    isOtpComplete.value = getOtpCode().length == otpLength;
  }

  String getOtpCode() {
    return controllers.map((e) => e.text).join();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
        {};

    final String email = args[Constantmanger.email] ?? "";
    final String currentScreen = args[Constantmanger.screen] ?? "";
    final bool isResetPassword = currentScreen == Constantmanger.forgetPassword;

    return BlocProvider(
      create: (BuildContext context) => OtpVericationCubit(),
      child: BlocConsumer<OtpVericationCubit, OtpVericationState>(
        listener: (context, state) async {
          if (state is OtpVericationFailure) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.red,
              message: state.failureResponse.errors.join("\n"),
            );
          } else if (state is OtpVericationSucces) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.green,
              message: state.otpsuccessmodel,
            );

            if (isResetPassword) {
              await Future.delayed(
                const Duration(seconds: 2),
                () async => Navigator.pushReplacementNamed(
                  context,
                  Routes.confirmPassword,
                  arguments: {
                    Constantmanger.email: email,
                    Constantmanger.otp: getOtpCode(),
                  },
                ),
              );
            } else {
              await Future.delayed(
                const Duration(seconds: 2),
                () async =>
                    Navigator.pushReplacementNamed(context, Routes.login),
              );
            }
          }
        },
        builder: (context, state) {
          final inAsyncCall = state is OtpVericationLoading;

          return ModalProgressHUD(
            inAsyncCall: inAsyncCall,
            blur: 7,
            progressIndicator: customloading(),
            child: Scaffold(
              backgroundColor: ColorManger.white,
              appBar: otpappbar(context, () {}),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilsManager.w18,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 6.h),

                    Text(
                      isResetPassword
                          ? S.of(context).otpMsgResetPassword
                          : S.of(context).otpMsgRegister,
                      style: TextStyle(
                        color: ColorManger.lightGrey2,
                        fontSize: 14.sp,
                      ),
                    ),

                    SizedBox(height: 48.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(otpLength, (index) {
                        return SizedBox(
                          width: 45.w,
                          child: TextFormField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            onChanged: (value) => onOtpChanged(value, index),
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: const Color(0xffF6F6F6),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 14.h,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                borderSide: BorderSide(
                                  color: ColorManger.kPrimary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 32.h),

                    ValueListenableBuilder<bool>(
                      valueListenable: isOtpComplete,
                      builder: (context, isComplete, child) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorManger.kPrimary,
                              foregroundColor: ColorManger.white,
                              disabledBackgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ScreenUtilsManager.r10,
                                ),
                              ),
                            ),
                            onPressed: isComplete
                                ? () {
                                    FocusScope.of(context).unfocus();

                                    context
                                        .read<OtpVericationCubit>()
                                        .verifyOtp(
                                          OtpModel(
                                            Email: email,
                                            code: getOtpCode(),
                                          ),
                                          isReset: isResetPassword,
                                        );
                                  }
                                : null,
                            child: Text(
                              S.of(context).confirm,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 16.h),

                    ResendCodeOpt(
                      resend: () {
                        for (var controller in controllers) {
                          controller.clear();
                        }
                        isOtpComplete.value = false;
                        FocusScope.of(context).requestFocus(focusNodes[0]);

                        context.read<OtpVericationCubit>().sendOtp(
                          email: email,
                          isreset: isResetPassword,
                          ctx: context,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
