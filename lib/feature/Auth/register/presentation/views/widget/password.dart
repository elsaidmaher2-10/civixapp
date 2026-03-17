import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/visblitypassword/visibleeye_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Password extends StatelessWidget {
  const Password({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   Constantmanger.pass,
        //   style: TextStyle(
        //     color: ColorManger.lightGrey,
        //     fontSize: ScreenUtilsManager.s16,
        //   ),
        // ),
        SizedBox(height: ScreenUtilsManager.h6),
        BlocProvider(
          create: (BuildContext context) => VisibleeyeCubit(),
          child: BlocBuilder<VisibleeyeCubit, bool>(
            builder: (BuildContext context, state) {
              return CustomTextfromfield(
                maxLines: 1,
                prefix: Icon(
                  Icons.password_sharp,
                  color: ColorManger.lightGrey2,
                ),
                onChanged: onChanged,
                controller: controller,
                obstext: state,
                hinttext: Constantmanger.hinytextpass,
                suffix: IconButton(
                  onPressed: () {
                    context.read<VisibleeyeCubit>().chanagevisbilitypassword();
                  },
                  icon: Icon(
                    state == true ? Icons.remove_red_eye : Icons.visibility_off,
                    color: ColorManger.lightGrey2,
                  ),
                ),
                lable: Constantmanger.pass,
              );
            },
          ),
        ),
        SizedBox(height: ScreenUtilsManager.h16),
      ],
    );
  }
}
