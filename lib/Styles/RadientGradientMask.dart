import 'package:flutter/material.dart';

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [
          //darkMidgroundColor,
          //darkBackgroundColor,

          Color(0xff06B88B),
          Color(0xff00C2B0),
          Color(0xff009CA8),
          Color(0xff0098C2),
          //Color(0xff064AB8),
          Color(0xff0676B8),
          Color(0xff06B88B),
          //firstColor,
          //secondColor,
          //Color(0xFF832685),
          //Color(0xFFC81379),
        ],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}
