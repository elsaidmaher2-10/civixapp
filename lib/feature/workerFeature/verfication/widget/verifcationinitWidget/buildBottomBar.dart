import 'dart:async';

import 'package:citifix/feature/workerFeature/verfication/Presentation/VerficationinitManger/VerificationInitCubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/resource/colormanager.dart';
import '../../../../../core/resource/constantmanger.dart';
import '../../../../../core/resource/screenutilsmaanger.dart';
import '../../data/model/VerificationrequestModel.dart';

Widget buildBottomBar(
  StreamController<bool> stream,
  VerificationrequestModel? request,
) {
  return StreamBuilder<bool>(
    stream: stream.stream,
    initialData: false,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      bool isEnabled = snapshot.data == true && request != null;
      return Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
        decoration: BoxDecoration(
          color: context.palette.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isEnabled
              ? () {
                  context.read<VerificationInitCubit>().sendVerificationRequest(
                    request: request,
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: context.palette.workerprimary,
            disabledBackgroundColor: context.palette.lightGrey.withOpacity(0.5),
            minimumSize: Size(double.infinity, ScreenUtilsManager.buttonHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: isEnabled ? 2 : 0,
          ),
          child: Text(
            Constantmanger.verifyButtonText,
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      );
    },
  );
}
