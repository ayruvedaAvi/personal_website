import 'dart:math';

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
      children: List.generate(boxXPositions.length, (index) {
        return Positioned(
          left: boxXPositions[index],
          top: boxYPositions[index],
          child: Transform.rotate(
            angle: _calculateRotationAngle(index),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: index == 0 ? Colors.red : Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: index == 0
                  ? const Icon(
                      Icons.donut_small_outlined,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
          ),
        );
      }),
    );
  }

  // helper function to calculate angle for bending
  double _calculateRotationAngle(int index) {
    if (index == 0) return 0.0; // head has no rotation

    // calculate the angle between current and previous positions
    double dx = boxXPositions[index - 1] - boxXPositions[index];
    double dy = boxYPositions[index - 1] - boxYPositions[index];
    return atan2(dy, dx);
  }
}
