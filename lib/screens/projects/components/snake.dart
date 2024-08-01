import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  final double xPosition;
  final double yPosition;

  const Snake({super.key, required this.xPosition, required this.yPosition});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: xPosition - 90,
          top: yPosition,
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
          left: xPosition - 70,
          top: yPosition,
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
          left: xPosition - 50,
          top: yPosition,
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
          left: xPosition - 30,
          top: yPosition,
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
          left: xPosition - 10,
          top: yPosition,
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
          left: xPosition,
          top: yPosition,
          child: Container(
            width: 10,
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
