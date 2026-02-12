import 'dart:async' show StreamController;

import 'package:civixapp/core/DI/getit.dart';
import 'package:civixapp/core/function/sinupvalidator.dart';
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
import 'package:civixapp/feature/Auth/Login/data/repo/Loginrepo.dart';
import 'package:civixapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:civixapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Loginpage extends StatefulWidget {
  Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormFieldState> key = GlobalKey();
  bool _isVisible = false;
  StreamController<bool> streamController = StreamController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  isvisible() {
    _isVisible = !_isVisible;
    streamController.add(!_isVisible);
  }

  bool isvalidpass = false;
  bool isvalidemail = false;

  bool ischeck = false;

  StreamController<bool> btnController = StreamController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return BlocConsumer<LoginmangerCubit, LogincontrollerState>(
          listener: (context, state) {},
          // if (state is LogincontrollerFailure) {
          //   AppSnackBar.show(
          //     context: context,
          //     message: state.message,
          //     onRetry: () {},
          //   );
          // } else if (state is LogincontrollerSuccess) {
          //   SharedPrefManager().setString(
          //     "access_token",
          //     state.response.access_token,
          //   );
          //   SharedPrefManager().setString(
          //     "refresh_token",
          //     state.response.refresh_token,
          //   );
          //   SharedPrefManager().setString(
          //     "access_token",
          //     state.response.access_token,
          //   );

          //   QuickAlert.show(
          //     text: state.response.message,
          //     headerBackgroundColor: ColorManger.kprimary,
          //     context: context,
          //     type: QuickAlertType.success,
          //     onConfirmBtnTap: () {
          //       Navigator.pushNamedAndRemoveUntil(
          //         context,
          //         RouteName.home,
          //         (Route<dynamic> routes) => false,
          //       );
          //     },
          builder: (context, state) {
            bool isasync = true;
            if (state is LogincontrollerLoading) {
              isasync = true;
            } else {
              isasync = false;
            }
            return ModalProgressHUD(
              inAsyncCall: isasync,

              blur: 15,
              progressIndicator: CupertinoActivityIndicator(
                radius: 15,
                color: ColorManger.kprimary,
              ),
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Form(
                            key: key,
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  AssetValueManager.Klog,
                                  width: screeutilsManager.w72,
                                ),
                                Text(
                                  Constantmanger.civix,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.OriginalSurfer,
                                    fontSize: screeutilsManager.s11,
                                    color: ColorManger.kprimary,
                                  ),
                                ),

                                SizedBox(height: screeutilsManager.h9),

                                Text(
                                  Constantmanger.logIn,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: FontFamily.Otama_ep,
                                    fontSize: screeutilsManager.s38,
                                    color: ColorManger.kprimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          Constantmanger.email,
                          style: TextStyle(
                            color: ColorManger.Lightgrey,
                            fontSize: screeutilsManager.s16,
                          ),
                        ),
                        SizedBox(height: screeutilsManager.h6),
                        CustomTextfromfield(
                          controller: email,

                          hinttext: Constantmanger.hinytextemail,
                          validator: (value) {
                            isvalidemail = emailvalidator(value) == null
                                ? true
                                : false;

                            btnController.add(isvalidemail && isvalidpass);
                          },
                        ),
                        SizedBox(height: screeutilsManager.h16),

                        Text(
                          Constantmanger.pass,
                          style: TextStyle(
                            color: ColorManger.Lightgrey,
                            fontSize: screeutilsManager.s16,
                          ),
                        ),
                        SizedBox(height: screeutilsManager.h6),
                        StreamBuilder<bool>(
                          stream: streamController.stream,
                          builder:
                              (
                                BuildContext context,
                                AsyncSnapshot<bool> snapshot,
                              ) {
                                return CustomTextfromfield(
                                  controller: password,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
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
                                  obstext: snapshot.data ?? false,
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
                                );
                              },
                        ),

                        Padding(padding: EdgeInsets.all(2.h)),
                        Row(
                          children: [
                            Row(
                              children: [
                                ConstrainedBox(
                                  constraints: BoxConstraints.tight(
                                    Size(30, 30),
                                  ),
                                  child: Checkbox(
                                    activeColor: ColorManger.kprimary,
                                    value: ischeck,
                                    onChanged: (onChanged) async {
                                      // ischeck = onChanged ?? false;
                                      // setState(() {});
                                      // await SharedPrefManager().setBool(
                                      //   "ischeck",
                                      //   ischeck,
                                      // );
                                    },
                                  ),
                                ),
                                Text("remember me view"),
                              ],
                            ),
                            Spacer(),
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
                                  fontSize: screeutilsManager.s10,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: screeutilsManager.h30),
                        Container(
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
                                        screeutilsManager.r10,
                                      ),
                                    ),
                                  ),
                                  onPressed: snapshot.data == true
                                      ? () {
                                          // if (key.currentState?.validate() ?? false) {
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

                bottomNavigationBar: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: RichText(
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
                              Navigator.of(context).pushNamed(Routes.signup);
                            },
                            child: Text(
                              Constantmanger.Signup,
                              style: TextStyle(color: ColorManger.kprimary),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
