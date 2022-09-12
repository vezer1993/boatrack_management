import 'package:boatrack_management/resources/colors.dart';
import 'package:boatrack_management/resources/styles/text_styles.dart';
import 'package:flutter/material.dart';

class MapsMarkerWidget extends StatefulWidget {
  final String name;

  const MapsMarkerWidget({Key? key, required this.name}) : super(key: key);

  @override
  State<MapsMarkerWidget> createState() => _MapsMarkerWidgetState();
}

class _MapsMarkerWidgetState extends State<MapsMarkerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: TrianglePainter(
            strokeColor: CustomColors().altBackgroundColor,
            strokeWidth: 1,
            paintingStyle: PaintingStyle.fill,
          ),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 3, 5, 8),
              child: Text(widget.name, style: CustomTextStyles.textStyleTableHeader(context)!.copyWith(color: Colors.white),),
            ),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(x, 0)
      ..lineTo(x, y * 0.8)
      ..lineTo(x * 0.6, y * 0.8)
      ..lineTo(x * 0.5, y)
      ..lineTo(x * 0.4, y * 0.8)
      ..lineTo(0, y * 0.8)
      ..lineTo(0, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
