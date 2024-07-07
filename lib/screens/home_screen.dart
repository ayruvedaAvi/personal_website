import 'dart:math';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<Dot> dots = [];
  late AnimationController _controller;
  Offset? mousePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat();
    for (int i = 0; i < 100; i++) {
      dots.add(Dot());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        children: [
          MouseRegion(
            onHover: (event) {
              setState(() {
                mousePosition = event.position;
              });
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                for (var dot in dots) {
                  dot.move(context, mousePosition);
                }
                return CustomPaint(
                  painter: DotsPainter(dots),
                  size: Size.infinite,
                );
              },
            ),
          ),
          CustomAppbar(),
        ],
      ),
    );
  }
}

class Dot {
  late double x, y;
  late Color color;
  late double speedX, speedY;
  late double size;

  Dot() {
    Random random = Random();
    x = random.nextDouble() * 1000;
    y = random.nextDouble() * 1000;
    color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    speedX = (random.nextDouble() - 0.5) * 2;
    speedY = (random.nextDouble() - 0.5) * 2;
    size = 3 + random.nextDouble() * 5;
  }

  void move(BuildContext context, Offset? mousePosition) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    x += speedX;
    y += speedY;

    if (mousePosition != null) {
      double dx = mousePosition.dx - x;
      double dy = mousePosition.dy - y;
      double distance = sqrt(dx * dx + dy * dy);
      if (distance < 100) {
        x -= dx / distance * 2;
        y -= dy / distance * 2;
      }
    }

    if (x < 0 || x > screenWidth) speedX *= -1;
    if (y < 0 || y > screenHeight) speedY *= -1;

    x = x.clamp(0, screenWidth);
    y = y.clamp(0, screenHeight);
  }
}

class DotsPainter extends CustomPainter {
  final List<Dot> dots;

  DotsPainter(this.dots);

  @override
  void paint(Canvas canvas, Size size) {
    for (var dot in dots) {
      canvas.drawCircle(
        Offset(dot.x, dot.y),
        dot.size,
        Paint()..color = dot.color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}