import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:citifix/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResendCodeOpt extends StatefulWidget {
  const ResendCodeOpt({super.key, required this.resend});
  final Function() resend;

  @override
  State<ResendCodeOpt> createState() => _ResendCodeOptState();
}

class _ResendCodeOptState extends State<ResendCodeOpt> {
  int counter = 60;
  late Timer timer;

  StreamController<int> streamController =
      StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    counter = 60;
    streamController.add(counter);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter > 0) {
        counter--;
        streamController.add(counter);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: counter,
      stream: streamController.stream,
      builder: (context, snapshot) {
        final current = snapshot.data ?? 0;
        final canResend = current == 60 || current == 0;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSplash.splashFactory,
              ),
              onPressed: canResend
                  ? () {
                      startTimer();
                      widget.resend();
                    }
                  : null,
              child: Text(
                canResend
                    ? S.of(context).resendCode
                    : "${S.of(context).resendCodeIn} 00:${current.toString().padLeft(2, "0")}",
                style: TextStyle(color: ColorManger.lightGrey),
              ),
            ),
          ],
        );
      },
    );
  }
}