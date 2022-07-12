import 'package:flutter/material.dart';
import 'package:tugasakhir_app/main_screens/home/custompaint/mypainter.dart';

class BorderCircleWidget extends StatelessWidget {
  final double? diameter;
  final double? sweepAngle;
  final Color? color;

  const BorderCircleWidget({ 
    Key? key,
    this.diameter = 160,
    @required this.sweepAngle,
    @required this.color,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(sweepAngle, color),
      size: Size(diameter!, diameter!),
    );
  }
}