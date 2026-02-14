import 'dart:async';

import 'package:civixapp/core/function/passvlidatorrules.dart';
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/feature/Auth/confirmpassword/presentation/view/widget/confirmpassappbar.dart';
import 'package:civixapp/feature/Auth/otpverifcation/presentation/view/widget/otpappbar.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/confirmpassword.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  StreamController<List> streamController = StreamController.broadcast();
  bool isvalid = false;
  @override
  void initState() {
    super.initState();

    _confirmPasswordController.addListener(matchpassword);
    _passwordController.addListener(matchpassword);
  }

  void matchpassword() {
    setState(() {
      isvalid =
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
    streamController.close();
  }

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context)?.settings.arguments as Map? ?? {};
    print(args);
    return ModalProgressHUD(
      inAsyncCall: false,
      blur: 15,
      progressIndicator: CupertinoActivityIndicator(
        radius: 15,
        color: ColorManger.kprimary,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: confirmpassappbar(context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 18.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screeutilsManager.h16),

                  Password(
                    controller: _passwordController,
                    onChanged: (String value) {
                      streamController.add(passwordvalidatorrules(value));
                    },
                  ),
                  const SizedBox(height: 16),
                  PasswordRules(streamController: streamController),
                  const SizedBox(height: 8),
                  ConfirmPassword(
                    controller: _confirmPasswordController,
                    validator: (String? p1) {
                      if (p1 == null || p1.isEmpty) {
                        return "Enter confirm password";
                      }
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        return "Passwords do not match";
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: isvalid ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManger.kprimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        Constantmanger.submit,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
