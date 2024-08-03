import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  final double box1xPosition;
  final double box1yPosition;
  final double box2xPosition;
  final double box2yPosition;
  final double box3xPosition;
  final double box3yPosition;
  final double box4xPosition;
  final double box4yPosition;
  final double box5xPosition;
  final double box5yPosition;
  final double box6xPosition;
  final double box6yPosition;

  const Snake({
    super.key,
    required this.box1xPosition,
    required this.box1yPosition,
    required this.box2xPosition,
    required this.box2yPosition,
    required this.box3xPosition,
    required this.box3yPosition,
    required this.box4xPosition,
    required this.box4yPosition,
    required this.box5xPosition,
    required this.box5yPosition,
    required this.box6xPosition,
    required this.box6yPosition,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: box6xPosition,
          top: box6yPosition,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          left: box5xPosition,
          top: box5yPosition,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          left: box4xPosition,
          top: box4yPosition,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          left: box3xPosition,
          top: box3yPosition,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          left: box2xPosition,
          top: box2yPosition,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 20,
            height: 20,
          ),
        ),
        Positioned(
          left: box1xPosition,
          top: box1yPosition,
          child: Container(
            width: 20,
            height: 20,
            color: Colors.transparent,
            child: const Icon(
              Icons.donut_small_outlined,
              color: Colors.green,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
