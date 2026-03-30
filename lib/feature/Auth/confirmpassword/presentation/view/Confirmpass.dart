import 'dart:async';
import 'package:citifix/core/database/remote/api/ApiService.dart';
import 'package:citifix/core/function/passvlidatorrules.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/service/networkchecker.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/confirmpassword/data/repo/confirmpasswordrepo.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordController.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/ConfirmPasswordState.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/manager/controller/Confirmpassword.dart';
import 'package:citifix/feature/Auth/confirmpassword/presentation/view/widget/confirmpassappbar.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:citifix/core/resource/constantmanger.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  late ConfirmpasswordController confirmPasswordController;
  bool _isProfileScreen = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    _isProfileScreen = args['screen'] == 'profile';

    confirmPasswordController = ConfirmpasswordController();
    confirmPasswordController.initState(isProfileScreen: _isProfileScreen);
  }

  Widget _buildForgotPasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtilsManager.h16),
        PasswordField(
          isNew: false,
          controller: confirmPasswordController.passwordController,
          onChanged: (value) {
            confirmPasswordController.forgotPasswordStreamController.add(
              passwordvalidatorrules(value),
            );
          },
        ),
        const SizedBox(height: 16),
        PasswordRules(
          streamController:
              confirmPasswordController.forgotPasswordStreamController,
        ),

        const SizedBox(height: 8),

        ConfirmPassword(
          controller: confirmPasswordController.confirmPasswordController,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return S.of(context).enterConfirmPassword;
            }
            if (confirmPasswordController.passwordController.text != value) {
              return S.of(context).passwordsDoNotMatch;
            }
            return null;
          },
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildChangePasswordFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtilsManager.h8),

        PasswordField(
          isNew: false,
          controller: confirmPasswordController.oldPasswordController,
          onChanged: (_) {},
        ),

        SizedBox(height: ScreenUtilsManager.h8),
        PasswordField(
          isNew: true,
          controller: confirmPasswordController.newPasswordController,
          onChanged: (value) {
            confirmPasswordController.changePasswordStreamController.add(
              passwordvalidatorrules(value),
            );
          },
        ),

        SizedBox(height: ScreenUtilsManager.h8),

        PasswordRules(
          streamController:
              confirmPasswordController.changePasswordStreamController,
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  @override
  void dispose() {
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    return BlocProvider(
      create: (context) => ConfirmPasswordController(
        Confirmpasswordrepo(
          service: Apiservice(Dio()),
          networkChecker: InternetChecker(),
        ),
      ),
      child: BlocConsumer<ConfirmPasswordController, ConfirmPasswordControllerState>(
        listener: (context, state) async {
          if (state is ConfirmPasswordControllerFailure) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.red,
              message: state.message,
            );
          } else if (state is ChangePasswordFailure) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.red,
              message: state.message,
            );
          } else if (state is ConfirmPasswordControllerSuccess) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.green,
              message: state.message,
            );
            await Future.delayed(
              const Duration(seconds: 3),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.login,
                (Route route) => false,
              ),
            );
          } else if (state is ChangePasswordSuccess) {
            Customsnackbar.show(
              context: context,
              backgroundColor: ColorManger.green,
              message: state.message,
            );
            await Future.delayed(
              const Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.citizenMain,
                (Route route) => false,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool inAsyncCall =
              state is ConfirmPasswordControllerLoading ||
              state is ChangePasswordLoading;

          return ModalProgressHUD(
            inAsyncCall: inAsyncCall,
            blur: 7,
            progressIndicator: customloading(),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: confirmpassappbar(context, () {
                Navigator.pop(context);
              }),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (args["screen"] == "profile")
                          _buildChangePasswordFields()
                        else
                          _buildForgotPasswordFields(),

                        SizedBox(
                          width: double.infinity,
                          height: 44.h,
                          child: StreamBuilder<bool>(
                            initialData: false,
                            stream:
                                confirmPasswordController.btnController.stream,
                            builder: (context, snapshot) {
                              return ElevatedButton(
                                onPressed: snapshot.data == true
                                    ? () {
                                        if (args["screen"] == "profile") {
                                          context
                                              .read<ConfirmPasswordController>()
                                              .changePassword(
                                                newPassword:
                                                    confirmPasswordController
                                                        .newPasswordController
                                                        .text,
                                                currentPassword:
                                                    confirmPasswordController
                                                        .oldPasswordController
                                                        .text,
                                              );
                                        } else {
                                          context
                                              .read<ConfirmPasswordController>()
                                              .createnewpassword(
                                                email:
                                                    args[Constantmanger.email],
                                                newPassword:
                                                    confirmPasswordController
                                                        .confirmPasswordController
                                                        .text,
                                                otp: args["otp"],
                                              );
                                        }
                                      }
                                    : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManger.kPrimary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  S.of(context).submit,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
