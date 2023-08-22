

import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  StarPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height;
    double sw = size.width;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(sw / 2, 0)
      ..lineTo(sw * 0.6495, sh * 0.3775)
      ..lineTo(sw, sh * 0.3775)
      ..lineTo(sw * 0.7205, sh * 0.6225)
      ..lineTo(sw * 0.825, sh)
      ..lineTo(sw * 0.5, sh * 0.7675)
      ..lineTo(sw * 0.175, sh)
      ..lineTo(sw * 0.2795, sh * 0.6225)
      ..lineTo(0, sh * 0.3775)
      ..lineTo(sw * 0.3505, sh * 0.3775)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}