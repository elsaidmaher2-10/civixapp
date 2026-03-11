import 'dart:async';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/feature/Auth/Login/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:citifix/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormFieldState> key = GlobalKey();
  bool _isVisible = true;
  StreamController<bool> streamController = StreamController.broadcast();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  isvisible() {
    _isVisible = !_isVisible;
    streamController.add(_isVisible);
  }

  bool isvalidpass = false;
  bool isvalidemail = false;
  bool ischeck = false;

  StreamController<bool> btnController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginmangerCubit(),
      child: Builder(
        builder: (context) {
          return BlocConsumer<LoginmangerCubit, LogincontrollerState>(
            listener: (context, state) {
              if (state is LogincontrollerFailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.red,
                  message: state.message,
                );
              } else if (state is LogincontrollerSuccess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.green,
                  message: state.response.message,
                );
              }
            },

            builder: (context, state) {
              bool inAsyncCall = false;
              if (state is LogincontrollerLoading) {
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
                  bottomNavigationBar: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "${Constantmanger.donthaveaccount} ",
                                style: TextStyle(color: ColorManger.Lightgrey2),
                              ),
                              WidgetSpan(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(Routes.signup);
                                  },
                                  child: Text(
                                    Constantmanger.Signup,
                                    style: TextStyle(
                                      color: ColorManger.kprimary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  resizeToAvoidBottomInset: true, // مهم للكيبود
                  extendBody: true,
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: ScreenUtilsManager.h20),
                            SizedBox(
                              width: double.infinity,
                              child: Form(
                                key: key,
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      AssetValueManager.Klog,
                                      height: ScreenUtilsManager.w90,
                                    ),
                                    SizedBox(height: ScreenUtilsManager.h9),
                                    Text(
                                      Constantmanger.logIn,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtilsManager.s34,
                                        color: ColorManger.kprimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: ScreenUtilsManager.h20),
                            CustomTextfromfield(
                              controller: email,
                              prefix: Icon(
                                Icons.email,
                                color: ColorManger.Lightgrey2,
                              ),

                              hinttext: Constantmanger.hinytextemail,
                              validator: (value) {
                                isvalidemail = emailvalidator(value) == null
                                    ? true
                                    : false;
                                btnController.add(isvalidemail && isvalidpass);

                                return emailvalidator(value);
                              },
                              lable: Constantmanger.email,
                            ),
                            SizedBox(height: ScreenUtilsManager.h20),
                            StreamBuilder<bool>(
                              initialData: _isVisible,
                              stream: streamController.stream,
                              builder:
                                  (
                                    BuildContext context,
                                    AsyncSnapshot<bool> snapshot,
                                  ) {
                                    return CustomTextfromfield(
                                      prefix: Icon(
                                        Icons.password_outlined,
                                        color: ColorManger.Lightgrey2,
                                      ),
                                      maxLines: 1,
                                      controller: password,
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          isvalidpass = false;

                                          btnController.add(
                                            isvalidemail && isvalidpass,
                                          );
                                          return "Please Enter password";
                                        } else {
                                          isvalidpass = true;
                                          btnController.add(
                                            isvalidemail && isvalidpass,
                                          );
                                          return null;
                                        }
                                      },
                                      obstext: snapshot.data ?? true,
                                      hinttext: Constantmanger.hinytextpass,
                                      suffix: IconButton(
                                        onPressed: () {
                                          isvisible();
                                        },
                                        icon: Icon(
                                          snapshot.data == true
                                              ? Icons.remove_red_eye
                                              : Icons.visibility_off,
                                          color: ColorManger.Lightgrey3,
                                        ),
                                      ),
                                      lable: Constantmanger.pass,
                                    );
                                  },
                            ),
                            SizedBox(height: ScreenUtilsManager.h20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tight(
                                        Size(30, 30),
                                      ),
                                      child: Checkbox(
                                        activeColor: ColorManger.kprimary,
                                        value: ischeck,
                                        onChanged: (onChanged) async {
                                          setState(() {});
                                          ischeck = onChanged ?? false;
                                        },
                                      ),
                                    ),
                                    Text(
                                      "Remember me view",
                                      style: TextStyle(
                                        fontSize: ScreenUtilsManager.s14,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.foregetpassword,
                                    );
                                  },
                                  child: Text(
                                    Constantmanger.forgetPassword,
                                    style: TextStyle(
                                      color: ColorManger.kprimary,
                                      fontSize: ScreenUtilsManager.s14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: ScreenUtilsManager.h30),
                            SizedBox(
                              width: double.infinity,
                              child: StreamBuilder<bool>(
                                initialData: false,
                                stream: btnController.stream,
                                builder:
                                    (
                                      BuildContext context,
                                      AsyncSnapshot<bool> snapshot,
                                    ) => ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ColorManger.kprimary,
                                        foregroundColor: ColorManger.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            ScreenUtilsManager.r10,
                                          ),
                                        ),
                                      ),
                                      onPressed: snapshot.data == true
                                          ? () {
                                              context
                                                  .read<LoginmangerCubit>()
                                                  .login(
                                                    email: email.text,
                                                    password: password.text,
                                                  );
                                            }
                                          : null,
                                      child: Text(Constantmanger.logIn),
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
            },
          );
        },
      ),
    );
  }
}
