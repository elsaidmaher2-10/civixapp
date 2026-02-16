import 'dart:async';
import 'dart:io';
import 'package:civixapp/core/database/remote/api/ApiService.dart';
import 'package:civixapp/core/function/passvlidatorrules.dart';
import 'package:civixapp/core/function/sinupvalidator.dart';
import 'package:civixapp/core/resource/colormanager.dart';
import 'package:civixapp/core/resource/constantmanger.dart';
import 'package:civixapp/core/resource/screenutilsmaanger.dart';
import 'package:civixapp/core/routing/routes.dart';
import 'package:civixapp/feature/Auth/register/data/models/usermodel.dart';
import 'package:civixapp/feature/Auth/register/data/repo/SignupRepo.dart';
import 'package:civixapp/feature/Auth/register/presentation/manager/ValidatebuttonCubit/validatebutton_cubit.dart';
import 'package:civixapp/feature/Auth/register/presentation/manager/cubit/signupcontroller_cubit.dart';
import 'package:civixapp/feature/Auth/register/presentation/manager/cubit/signupcontroller_state.dart';
import 'package:civixapp/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/HaveAccountORLogin.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/selectRole.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Lname.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/Phone.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/address.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/fname.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/nationalnumber.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/signupbutton.dart';
import 'package:civixapp/feature/Auth/register/presentation/views/widget/signuplogo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Singnup extends StatefulWidget {
  const Singnup({super.key});

  @override
  State<Singnup> createState() => _SingnupState();
}

class _SingnupState extends State<Singnup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  StreamController<String> selectole = StreamController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nationalnumbercontroller =
      TextEditingController();
  ValueNotifier<bool> isFormValid = ValueNotifier(false);
  StreamController<List> streamController = StreamController.broadcast();
  File? image;
  String selectedRole = "";

  @override
  void initState() {
    super.initState();

    void listener() {
      print(isFormValid.value);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isFormValid.value =
            fnameController.text.isNotEmpty &&
            lnameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            nationalnumbercontroller.text.isNotEmpty;
      });
    }

    fnameController.addListener(listener);
    lnameController.addListener(listener);
    emailController.addListener(listener);
    passwordController.addListener(listener);
    nationalnumbercontroller.addListener(listener);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SingupCubit>(
          create: (BuildContext context) => SingupCubit(),
        ),
        BlocProvider<SignupcontrollerCubit>(
          create: (BuildContext context) => SignupcontrollerCubit(),
        ),

        BlocProvider<ValidatebuttonCubit>(
          create: (BuildContext context) => ValidatebuttonCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocConsumer<SignupcontrollerCubit, SignupcontrollerState>(
            listener: (context, state) {
              if (state is Signupcontrollerfailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.only(top: 8, left: 8),
                    duration: Duration(seconds: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    behavior: SnackBarBehavior.fixed,
                    backgroundColor: ColorManger.red,
                    dismissDirection: DismissDirection.endToStart,
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
              } else if (state is Signupcontrollersucess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.only(top: 8, left: 8),

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
                      state.message,
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
                    Constantmanger.screen: Constantmanger.Signup,
                  },
                );
              }
            },

            builder: (context, state) {
              bool inAsyncCall = false;
              if (state is Signupcontrollerloading) {
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
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Builder(
                            builder: (BuildContext context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: screeutilsManager.h30),
                                  signuplogo(),
                                  SizedBox(height: screeutilsManager.h20),
                                  Fname(
                                    controller: fnameController,
                                    validator: fnamevalidator,
                                  ),
                                  Lname(
                                    controller: lnameController,
                                    validator: lnamevalidator,
                                  ),
                                  Email(
                                    controller: emailController,
                                    validator: emailvalidator,
                                  ),
                                  Phone(
                                    controller: phoneController,
                                    validator: phonevalidator,
                                  ),
                                  Nationalnumber(
                                    controller: nationalnumbercontroller,
                                    onChanged: (value) {},
                                  ),
                                  Address(
                                    controller: addresscontroller,
                                    onChanged: (value) {},
                                  ),
                                  Password(
                                    controller: passwordController,
                                    onChanged: (value) {
                                      streamController.add(
                                        passwordvalidatorrules(value),
                                      );
                                    },
                                  ),
                                  PasswordRules(
                                    streamController: streamController,
                                  ),
                                  SizedBox(height: screeutilsManager.h16),
                                  selectRole(
                                    selectole,
                                    onchanged: (value) {
                                      selectole.add(value ?? "");
                                      selectedRole = value?.toLowerCase() ?? "";
                                    },
                                  ),
                                  SizedBox(height: screeutilsManager.h16),
                                  SizedBox(height: screeutilsManager.h30),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: isFormValid,
                                    builder: (context, isValid, child) {
                                      return SignUPButton(
                                        onPressed: isValid
                                            ? () async {
                                                print(selectole);
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  Usermodel user = Usermodel(
                                                    nationalId:
                                                        nationalnumbercontroller
                                                            .text,
                                                    address:
                                                        addresscontroller.text,
                                                    dateOfBirth: "2024-06-22",
                                                    role: selectedRole,
                                                    firstName:
                                                        fnameController.text,
                                                    lastName:
                                                        lnameController.text,
                                                    email: emailController.text,
                                                    password:
                                                        passwordController.text,
                                                    phone: phoneController.text,
                                                  );

                                                  context
                                                      .read<
                                                        SignupcontrollerCubit
                                                      >()
                                                      .signupfunc(user);
                                                }
                                              }
                                            : null,
                                      );
                                    },
                                  ),

                                  HaveAccountORLogin(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SizedBox(height: screeutilsManager.h30),
                                ],
                              );
                            },
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

  String? confvalidator(value) {
    if (value == null || value.isEmpty) {
      return "Please confirm your password";
    }
    if (value != passwordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  @override
  void dispose() {
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    nationalnumbercontroller.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
// }

// class Selectcountry extends StatefulWidget {
//   Selectcountry({super.key, required this.name});
//   String name;
//   @override
//   State<Selectcountry> createState() => _SelectcountryState();
// }

// class _SelectcountryState extends State<Selectcountry> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text("Select nationality"),
//         SizedBox(height: 4),
//         Container(
//           decoration: BoxDecoration(
//             color: Color(0xffF6F6F6),
//             borderRadius: BorderRadius.circular(8),
//             border: BoxBorder.all(color: ColorManger.kprimary),
//           ),
//           height: 45,
//           width: double.infinity,
//           child: InkWell(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Align(
//                 alignment: AlignmentGeometry.centerLeft,

//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.name,
//                       style: TextStyle(color: ColorManger.Lightgrey2),
//                     ),
//                     Icon(
//                       color: ColorManger.Lightgrey2,
//                       size: 30,
//                       Icons.keyboard_arrow_down,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             onTap: () {
//               setState(() {});
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
