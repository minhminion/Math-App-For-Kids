import 'package:flutter/material.dart';

class DrawTriangleShape extends CustomPainter {
  Paint painter;
  Color color;
  PaintingStyle paintingStyle;
  double strokeWidth;

  DrawTriangleShape(
      {this.color = Colors.purpleAccent,
      this.paintingStyle = PaintingStyle.stroke,
      this.strokeWidth = 3}) {
    painter = Paint()
      ..color = color
      ..style = paintingStyle
      ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.height, size.width)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
