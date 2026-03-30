import 'dart:async';
import 'dart:io';
import 'package:citifix/core/function/passvlidatorrules.dart';
import 'package:citifix/core/function/sinupvalidator.dart';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:citifix/core/widget/CustomSnackBar.dart';
import 'package:citifix/core/widget/customloading.dart';
import 'package:citifix/feature/Auth/register/data/models/usermodel.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/ValidatebuttonCubit/validatebutton_cubit.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/cubit/signupcontroller_cubit.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/cubit/signupcontroller_state.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/imagepickercubit/singup_cubit.dart';
import 'package:citifix/feature/Auth/register/presentation/views/HaveAccountORLogin.dart';
import 'package:citifix/feature/Auth/register/presentation/views/selectRole.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/CustomDatePicker.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/Email.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/Lname.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/Phone.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/address.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/fname.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/nationalnumber.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/password_rules.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/signupbutton.dart';
import 'package:citifix/feature/Auth/register/presentation/views/widget/signuplogo.dart';
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
  final TextEditingController datecontroller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nationalnumbercontroller =
      TextEditingController();

  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  final StreamController<String> selectRoleController =
      StreamController<String>.broadcast();
  final StreamController<List> streamController =
      StreamController<List>.broadcast();

  File? image;
  String selectedRole = "";

  @override
  void initState() {
    super.initState();

    fnameController.addListener(_checkFormValidity);
    lnameController.addListener(_checkFormValidity);
    emailController.addListener(_checkFormValidity);
    passwordController.addListener(_checkFormValidity);
    nationalnumbercontroller.addListener(_checkFormValidity);
  }

  void _checkFormValidity() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFormValid.value =
          fnameController.text.trim().isNotEmpty &&
          lnameController.text.trim().isNotEmpty &&
          emailController.text.trim().isNotEmpty &&
          passwordController.text.isNotEmpty &&
          nationalnumbercontroller.text.trim().isNotEmpty;
    });
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
            listener: (context, state) async {
              if (state is Signupcontrollerfailure) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.red,
                  message: state.message,
                );
              } else if (state is Signupcontrollersucess) {
                Customsnackbar.show(
                  context: context,
                  backgroundColor: ColorManger.green,
                  message: state.message,
                );
                await Future.delayed(
                  const Duration(seconds: 2),
                  () async => Navigator.pushNamed(
                    context,
                    Routes.otpverficationc,
                    arguments: {
                      Constantmanger.email: emailController.text.trim(),
                      Constantmanger.screen: Constantmanger.Signup,
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              bool inAsyncCall = state is Signupcontrollerloading;

              return ModalProgressHUD(
                inAsyncCall: inAsyncCall,
                blur: 7,
                progressIndicator: customloading(),
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtilsManager.w18,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: ScreenUtilsManager.h20),
                              const signuplogo(),
                              SizedBox(height: ScreenUtilsManager.h20),
                              Fname(
                                controller: fnameController,
                                validator: (value) =>
                                    fnamevalidator(context, value),
                              ),
                              Lname(
                                controller: lnameController,
                                validator: (value) =>
                                    lnamevalidator(context, value),
                              ),
                              Email(
                                controller: emailController,
                                validator: (value) =>
                                    emailvalidator(context, value),
                              ),
                              Phone(
                                controller: phoneController,
                                validator: (value) =>
                                    phonevalidator(context, value),
                              ),
                              Nationalnumber(
                                controller: nationalnumbercontroller,
                              ),

                              SizedBox(height: ScreenUtilsManager.h6),
                              CustomDateField(controller: datecontroller),

                              SizedBox(height: ScreenUtilsManager.h20),
                              Address(
                                controller: addresscontroller,
                                onChanged: (value) {},
                              ),
                              PasswordField(
                                isNew: false,
                                controller: passwordController,
                                onChanged: (value) {
                                  streamController.add(
                                    passwordvalidatorrules(value),
                                  );
                                },
                              ),
                              PasswordRules(streamController: streamController),

                              SizedBox(height: ScreenUtilsManager.h16),

                              SelectRoleDropdown(
                                onChanged: (value) {
                                  selectRoleController.add(value ?? "");
                                  selectedRole = value?.toLowerCase() ?? "";
                                },
                                streamController: selectRoleController,
                              ),
                              SizedBox(height: ScreenUtilsManager.h20),
                              ValueListenableBuilder<bool>(
                                valueListenable: isFormValid,
                                builder: (context, isValid, child) {
                                  return SignUPButton(
                                    onPressed: isValid
                                        ? () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              FocusScope.of(context).unfocus();

                                              Usermodel user = Usermodel(
                                                nationalId:
                                                    nationalnumbercontroller
                                                        .text
                                                        .trim(),
                                                address: addresscontroller.text
                                                    .trim(),
                                                dateOfBirth: datecontroller.text
                                                    .trim(),
                                                role: selectedRole,
                                                firstName: fnameController.text
                                                    .trim(),
                                                lastName: lnameController.text
                                                    .trim(),
                                                email: emailController.text
                                                    .trim(),
                                                password:
                                                    passwordController.text,
                                                phone: phoneController.text
                                                    .trim(),
                                              );

                                              context
                                                  .read<SignupcontrollerCubit>()
                                                  .signupfunc(user);
                                            }
                                          }
                                        : null,
                                  );
                                },
                              ),
                              SizedBox(height: ScreenUtilsManager.h8),
                              HaveAccountOrLogin(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              SizedBox(height: ScreenUtilsManager.h30),
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

  String? confvalidator(String? value) {
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
    addresscontroller.dispose();
    datecontroller.dispose();

    isFormValid.dispose();
    selectRoleController.close();
    streamController.close();

    super.dispose();
  }
}
