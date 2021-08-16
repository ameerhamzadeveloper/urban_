import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class AppProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SpinKitSquareCircle(
        color: Colors.purpleAccent,
        size: 50.0,
      ),
    );
  }
}
