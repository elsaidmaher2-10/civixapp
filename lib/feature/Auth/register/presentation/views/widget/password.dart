import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/core/widget/customtextfromfield.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/visblitypassword/visibleeye_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.controller,
    this.onChanged,
    this.isNew = false,
  });

  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VisibleeyeCubit(),
      child: BlocBuilder<VisibleeyeCubit, bool>(
        builder: (context, isHidden) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtilsManager.h12),
              CustomTextfromfield(
                maxLines: 1,
                controller: controller,
                onChanged: onChanged,
                obstext: isHidden,

                hinttext: isNew
                    ? S.of(context).enterNewPassword
                    : S.of(context).hintPassword,

                lable: isNew
                    ? S.of(context).newPassword
                    : S.of(context).password,

                prefix: Icon(
                  isNew ? Icons.lock : Icons.password,
                  color: ColorManger.lightGrey2,
                ),

                suffix: IconButton(
                  onPressed: () {
                    context.read<VisibleeyeCubit>().chanagevisbilitypassword();
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.remove_red_eye,
                    color: ColorManger.lightGrey2,
                  ),
                ),
              ),

              SizedBox(height: ScreenUtilsManager.h16),
            ],
          );
        },
      ),
    );
  }
}
