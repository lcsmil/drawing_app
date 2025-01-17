import 'package:flutter/material.dart';

class DrawingPainterWidget extends CustomPainter {
  final List<List<Offset>> strokes;
  final List<Color> strokeColors;
  final double strokeWidth;

  DrawingPainterWidget({
    required this.strokes,
    required this.strokeColors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < strokes.length; i++) {
      final stroke = strokes[i];
      final paint = Paint()
        ..color = strokeColors[i]
        ..strokeCap = StrokeCap.round
        ..strokeWidth = strokeWidth;

      for (int j = 0; j < stroke.length - 1; j++) {
        canvas.drawLine(stroke[j], stroke[j + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
