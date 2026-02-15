import 'package:flutter/material.dart';

class Unknownroute extends StatelessWidget {
  const Unknownroute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("unkown Route",style: TextStyle(color: Colors.red,fontSize: 22,)),
            Icon(Icons.route,size: 30,)
          ],
        ),
      ),
    );
  }
}
