import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/core/resource/screenutilsmaanger.dart';
import 'package:citifix/feature/Auth/register/presentation/manager/ValidatebuttonCubit/validatebutton_cubit.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUPButton extends StatelessWidget {
  const SignUPButton({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ValidatebuttonCubit, bool>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: state == true
                  ? context.palette.kPrimary
                  : context.palette.lightGrey3,
              foregroundColor: context.palette.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilsManager.r10),
              ),
            ),
            onPressed: state == true ? onPressed : null,
            child: Text(S.of(context).signUp, style: GoogleFonts.cairo()),
          );
        },
      ),
    );
  }
}
