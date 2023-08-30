import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 39,
      itemBuilder: (BuildContext context, int index) {
        return const DecoratedBox(
          decoration:
          BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        );
      },
    );
  }
}
