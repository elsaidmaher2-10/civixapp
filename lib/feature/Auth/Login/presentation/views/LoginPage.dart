// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:civixapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_cubit.dart';
import 'package:civixapp/feature/Auth/Login/presentation/manager/cubit/loginmanger_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:civixapp/core/function/sinupvalidator.dart';
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';

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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.all(16.w),
                    duration: Duration(seconds: 3),
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
              } else if (state is LogincontrollerSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.only(top: 8, left: 8, bottom: 20),

                    duration: Duration(seconds: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    backgroundColor: ColorManger.green,
                    dismissDirection: DismissDirection.endToStart,
                    content: Text(
                      state.response.message,
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
                    Constantmanger.email: email.text,
                    "screen": Constantmanger.Signup,
                  },
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
                  resizeToAvoidBottomInset: true, // مهم للكيبود

                  extendBody: true,
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.96,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Form(
                                      key: key,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AssetValueManager.Klog,
                                            width: screeutilsManager.w100,
                                          ),

                                          SizedBox(
                                            height: screeutilsManager.h9,
                                          ),

                                          Text(
                                            Constantmanger.logIn,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              // fontFamily: FontFamily.Otama_ep,
                                              fontSize: screeutilsManager.s34,
                                              color: ColorManger.kprimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   Constantmanger.email,
                                  //   style: TextStyle(
                                  //     color: ColorManger.Lightgrey,
                                  //     fontSize: screeutilsManager.s16,
                                  //   ),
                                  // ),
                                  SizedBox(height: screeutilsManager.h6),
                                  CustomTextfromfield(
                                    obstext: _isVisible,
                                    controller: email,
                                    prefix: Icon(
                                      Icons.email,
                                      color: ColorManger.Lightgrey2,
                                    ),

                                    hinttext: Constantmanger.hinytextemail,
                                    validator: (value) {
                                      isvalidemail =
                                          emailvalidator(value) == null
                                          ? true
                                          : false;
                                      btnController.add(
                                        isvalidemail && isvalidpass,
                                      );

                                      return emailvalidator(value);
                                    },
                                    lable: Constantmanger.email,
                                  ),
                                  SizedBox(height: screeutilsManager.h16),

                                  // Text(
                                  //   Constantmanger.pass,
                                  //   style: TextStyle(
                                  //     color: ColorManger.Lightgrey,
                                  //     fontSize: screeutilsManager.s16,
                                  //   ),
                                  // ),
                                  SizedBox(height: screeutilsManager.h6),
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
                                            hinttext:
                                                Constantmanger.hinytextpass,
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

                                  Padding(padding: EdgeInsets.all(6.h)),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                            fontSize: screeutilsManager.s14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: screeutilsManager.h30),
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
                                              backgroundColor:
                                                  ColorManger.kprimary,
                                              foregroundColor:
                                                  ColorManger.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      screeutilsManager.r10,
                                                    ),
                                              ),
                                            ),
                                            onPressed: snapshot.data == true
                                                ? () {
                                                    context
                                                        .read<
                                                          LoginmangerCubit
                                                        >()
                                                        .login(
                                                          email: email.text,
                                                          password:
                                                              password.text,
                                                        );
                                                  }
                                                : null,
                                            child: Text(Constantmanger.logIn),
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        
                                        children: [
                                          TextSpan(
                                            text:
                                                "${Constantmanger.donthaveaccount} ",
                                            style: TextStyle(
                                              color: ColorManger.Lightgrey2,
                                            ),
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
                            ],
                          ),
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
