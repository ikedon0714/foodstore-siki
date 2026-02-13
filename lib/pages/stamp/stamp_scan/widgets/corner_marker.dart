import 'package:flutter/material.dart';

import 'package:foodstore_siki/core/theme/app_colors.dart';

class CornerMarkerSet extends StatelessWidget {
  const CornerMarkerSet({super.key});

  @override
  Widget build(BuildContext context) {
    const markerSize = 30.0;
    const markerThickness = 4.0;

    return Stack(
      children: const [
        Positioned(
          top: 0,
          left: 0,
          child: CornerMarker(
            size: markerSize,
            thickness: markerThickness,
            position: CornerMarkerPosition.topLeft,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: CornerMarker(
            size: markerSize,
            thickness: markerThickness,
            position: CornerMarkerPosition.topRight,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: CornerMarker(
            size: markerSize,
            thickness: markerThickness,
            position: CornerMarkerPosition.bottomLeft,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: CornerMarker(
            size: markerSize,
            thickness: markerThickness,
            position: CornerMarkerPosition.bottomRight,
          ),
        ),
      ],
    );
  }
}

enum CornerMarkerPosition {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}

class CornerMarker extends StatelessWidget {
  const CornerMarker({
    super.key,
    required this.size,
    required this.thickness,
    required this.position,
  });

  final double size;
  final double thickness;
  final CornerMarkerPosition position;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerMarkerPainter(
          color: AppColors.primary,
          thickness: thickness,
          position: position,
        ),
      ),
    );
  }
}

class _CornerMarkerPainter extends CustomPainter {
  _CornerMarkerPainter({
    required this.color,
    required this.thickness,
    required this.position,
  });

  final Color color;
  final double thickness;
  final CornerMarkerPosition position;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    switch (position) {
      case CornerMarkerPosition.topLeft:
        canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), paint);
        canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
        break;

      case CornerMarkerPosition.topRight:
        canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
        canvas.drawLine(
          Offset(size.width, 0),
          Offset(size.width, size.height),
          paint,
        );
        break;

      case CornerMarkerPosition.bottomLeft:
        canvas.drawLine(const Offset(0, 0), Offset(0, size.height), paint);
        canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width, size.height),
          paint,
        );
        break;

      case CornerMarkerPosition.bottomRight:
        canvas.drawLine(
          Offset(size.width, 0),
          Offset(size.width, size.height),
          paint,
        );
        canvas.drawLine(
          Offset(0, size.height),
          Offset(size.width, size.height),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
