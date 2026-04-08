import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/resource/colormanager.dart';
import '../../../../../../generated/l10n.dart';
import '../../manager/reportManger/cubit/report_manager_cubit.dart';

Future<bool> showDeleteDialog(
  BuildContext context, {
  required int ReportID,
}) async {
  return await showCupertinoDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(
              S.of(context).confirmDelete,
              style: GoogleFonts.cairo(),
            ),
            content: Text(
              S.of(context).deleteConfirmationMessage,
              style: GoogleFonts.cairo(),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  S.of(context).cancel,
                  style: GoogleFonts.cairo(color: ColorManger.kPrimaryDark),
                ),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                onPressed: () {
                  context.read<ReportCubit>().deleteReport(ReportID: ReportID);
                  Navigator.of(context).pop(true);
                },
                child: Text(S.of(context).delete, style: GoogleFonts.cairo()),
              ),
            ],
          );
        },
      ) ??
      false;
}
