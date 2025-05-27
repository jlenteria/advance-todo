import 'package:advance_todo/core/themes/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  const CustomCircularProgressIndicator({super.key, required this.percentage});
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularProgressPainter(percentage: percentage),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
        child: Text(
          '${(percentage * 100).toInt()}%',
            style: AppFonts.body10B(),
          ),
        ),
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  _CircularProgressPainter({required this.percentage});
  final double percentage;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paintBackground = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3) // Background color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final Paint paintForeground = Paint()
      ..color = Colors.blue // Progress color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Rounded ends for a cleaner look

    double startAngle = -3.14 / 2; // Start from the top of the circle
    double sweepAngle = 2 * 3.14 * percentage; // Calculate the sweep angle based on the percentage

    // Draw the background circle
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, paintBackground);

    // Draw the progress arc (border)
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2),
      startAngle,
      sweepAngle,
      false,
      paintForeground,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
