import 'dart:async';

import 'package:civixapp/core/function/sinupvalidator.dart';
import 'package:civixapp/core/resource/assetvaluemanger.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/core/widget/customtextfromfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  StreamController<bool> streamController = StreamController.broadcast();
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
        return ModalProgressHUD(
          inAsyncCall: false,
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
                            Image.asset(
                              AssetValueManager.Klog,
                              width: screeutilsManager.w100,
                            ),

                            SizedBox(height: screeutilsManager.h9),

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
                      controller: email,
                      prefix: Icon(Icons.email, color: ColorManger.Lightgrey2),

                      hinttext: Constantmanger.hinytextemail,
                      validator: (value) {
                        isvalidemail = emailvalidator(value) == null
                            ? true
                            : false;

                        btnController.add(isvalidemail && isvalidpass);
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
                      stream: streamController.stream,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                            return CustomTextfromfield(
                              prefix: Icon(
                                Icons.password_outlined,
                                color: ColorManger.Lightgrey2,
                              ),

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
                              lable: Constantmanger.pass,
                            );
                          },
                    ),

                    Padding(padding: EdgeInsets.all(6.h)),
                    Row(
                      children: [
                        Row(
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints.tight(Size(30, 30)),
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
                                    screeutilsManager.r10,
                                  ),
                                ),
                              ),
                              onPressed: snapshot.data == true ? () {} : null,
                              child: Text(Constantmanger.logIn),
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
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
  }
}
