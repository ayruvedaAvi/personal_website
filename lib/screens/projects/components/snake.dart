import 'package:flutter/material.dart';

class Snake extends StatelessWidget {
  // legacy code
  // final double box1xPosition;
  // final double box1yPosition;
  // final double box2xPosition;
  // final double box2yPosition;
  // final double box3xPosition;
  // final double box3yPosition;
  // final double box4xPosition;
  // final double box4yPosition;
  // final double box5xPosition;
  // final double box5yPosition;
  // final double box6xPosition;
  // final double box6yPosition;
  final List<double> boxXPositions;
  final List<double> boxYPositions;

  const Snake({
    super.key,
    required this.boxXPositions,
    required this.boxYPositions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: boxXPositions[5],
          top: boxYPositions[5],
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
          left: boxXPositions[4],
          top: boxYPositions[4],
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
          left: boxXPositions[3],
          top:  boxYPositions[3],
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
          left: boxXPositions[2],
          top: boxYPositions[2],
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
          left: boxXPositions[1],
          top: boxYPositions[1],
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
          left: boxXPositions[0],
          top: boxYPositions[0],
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
