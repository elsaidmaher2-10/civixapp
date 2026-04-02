import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Unknownroute extends StatelessWidget {
  const Unknownroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "unkown Route",
              style: GoogleFonts.cairo(color: Colors.red, fontSize: 22),
            ),
            Icon(Icons.route, size: 30),
          ],
        ),
      ),
    );
  }
}
