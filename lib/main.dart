import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPainter(),
    );
  }
}

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<MyPainter> {
  var _lenth = 300.0;
  var _radius = 50.0;
  var _radians = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste foguete'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CustomPaint(
                painter: ShapePainter(_lenth, _radius, _radians),
                child: Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Comprimento'),
            ),
            Slider(
              value: _lenth,
              min: 50.0,
              max: 300.0,
              label: _lenth.toInt().toString(),
              onChanged: (value) {
                setState(() {
                  _lenth = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Raio'),
            ),
            Slider(
              value: _radius,
              min: 20.0,
              max: 75.0,
              onChanged: (value) {
                setState(() {
                  _radius = value;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Cone ' + _radius.toString()),
            ),
            Slider(
              value: _radians,
              min: 30.0,
              max: 200.0,
              
              onChanged: (value) {
                setState(() {
                  _radians = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// FOR PAINTING POLYGONS
class ShapePainter extends CustomPainter {
  final double lenth;
  final double radius;
  final double cone;
  ShapePainter(this.lenth, this.radius, this.cone);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint = Offset(300, 0);

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);
    path.lineTo(startPoint.dx + lenth, startPoint.dy + center.dy);
    path.lineTo(
        startPoint.dx + lenth - cone, startPoint.dy + center.dy + radius / 2);
    path.lineTo(startPoint.dx + lenth, startPoint.dy + center.dy + radius);
    path.lineTo(startPoint.dx + center.dx, startPoint.dy + center.dy + radius);
    canvas.drawPath(path, paint);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
