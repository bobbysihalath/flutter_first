import 'package:flutter/material.dart';

class BillWrapper extends StatelessWidget {
  BillWrapper({this.headerHeight = 160, this.bodyHeight, @required this.header, @required this.body});

  final double headerHeight, bodyHeight;
  final Widget header, body;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BoxShadowPainter(headerHeight),
      child: ClipPath(
        clipper: MyCustomClipper(headerHeight),
        child: Container(
          // color: Colors.pink,
          decoration: BoxDecoration(
            // image: DecorationImage(image: AssetImage('assets/images/bill_background.webp'), fit: BoxFit.cover),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 8)]
          ),
          child: Column(
            children: [
              Container(
                height: headerHeight,
                child: header,
              ),
              MySeparator(height: 2, color: Colors.grey),
              Container(
                height: bodyHeight,
                child: body,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key key, this.height = 1, this.color = Colors.grey}) : super(key: key);

  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final boxWidth = constraints.constrainWidth();
      final dashWidth = 4.0;
      final dashCount = (boxWidth / (2 * dashWidth)).floor();

      return Flex(
        children: List.generate(dashCount, (index) {
          return SizedBox(
            width: dashWidth,
            height: height,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
            ),
          );
        }),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
      );
    });
  }
}

class BoxShadowPainter extends CustomPainter {
  BoxShadowPainter(this.cutOffSet);

  final double cutOffSet;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = drawPath(size, cutOffSet, isDrawingShadow: true);

    canvas.drawShadow(path, Colors.black45, 8.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  MyCustomClipper(this.headerHeight);

  final double headerHeight;

  @override
  Path getClip(Size size) {
    Path path = drawPath(size, headerHeight);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

Path drawPath(Size size, double curveHeight, {bool isDrawingShadow = false}) {
  final bottom = isDrawingShadow ? size.height - 8 : size.height;

  final borderRadius = 16.0;
  final curve = 16.0;
  final curveYAdjust = 1.6;
  final curveXAdjust = 1.3;
  final controlPoint1 = Offset(size.width - (curve * curveXAdjust), curveHeight - ((curve / 2) * curveYAdjust));
  final controlPoint2 = Offset(size.width - (curve * curveXAdjust), curveHeight + ((curve / 2) * curveYAdjust));
  final controlPoint3 = Offset((curve * curveXAdjust), curveHeight + ((curve / 2) * curveYAdjust));
  final controlPoint4 = Offset((curve * curveXAdjust), curveHeight - ((curve / 2) * curveYAdjust));
  final endPoint1 = Offset(size.width, curveHeight + curve);
  final endPoint2 = Offset(0, curveHeight - curve);

  Path path = Path()
    ..moveTo(borderRadius, 0)
    ..lineTo(size.width - borderRadius, 0)
    ..arcToPoint(Offset(size.width, 0 + borderRadius), radius: Radius.circular(borderRadius))
    ..lineTo(size.width, curveHeight - curve)
    ..cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx, controlPoint2.dy, endPoint1.dx, endPoint1.dy)
  // ..arcToPoint(Offset(size.width - curve, curve), radius: Radius.circular(curve), clockwise: false)
    ..lineTo(size.width, bottom - borderRadius)
    ..arcToPoint(Offset(size.width - borderRadius, bottom), radius: Radius.circular(borderRadius))
    ..lineTo(0 + borderRadius, bottom)
    ..arcToPoint(Offset(0, bottom - borderRadius), radius: Radius.circular(borderRadius))
    ..lineTo(0, curveHeight + curve)
    ..cubicTo(controlPoint3.dx, controlPoint3.dy, controlPoint4.dx, controlPoint4.dy, endPoint2.dx, endPoint2.dy)
    ..lineTo(0, 0 + borderRadius)
    ..arcToPoint(Offset(0 + borderRadius, 0), radius: Radius.circular(borderRadius))
    ..close();
  return path;
}
