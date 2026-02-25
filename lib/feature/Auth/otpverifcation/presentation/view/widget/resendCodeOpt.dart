import 'dart:async';
import 'package:citifix/core/resource/colormanager.dart';
import 'package:flutter/material.dart';

class ResendCodeOpt extends StatefulWidget {
  ResendCodeOpt({super.key, required this.resend});
  Function() resend;
  @override
  State<ResendCodeOpt> createState() => _ResendCodeOptState();
}

class _ResendCodeOptState extends State<ResendCodeOpt> {
  int counter = 60;
  late Timer timer;

  StreamController<int> streamController = StreamController<int>.broadcast();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    counter = 60;
    streamController.add(counter);
    timer = Timer.periodic(Duration(milliseconds: 800), (timer) {
      if (counter > 0) {
        counter--;
        streamController.add(counter);
      } else {
        timer.cancel(); // وقف التيمر لما يوصل صفر
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                splashFactory: InkSplash.splashFactory,
              ),
              onPressed: snapshot.data == 60 || snapshot.data == 0
                  ? () {
                      startTimer();
                      widget.resend();
                    }
                  : null,
              child: Text(
                style: TextStyle(color: ColorManger.Lightgrey),
                snapshot.data == 60 || snapshot.data == 0
                    ? "Resend Code"
                    : "Resend Code In 00:${snapshot.data.toString().padLeft(2, "0")}",
              ),
            ),
          ],
        );
      },
    );
  }
}
