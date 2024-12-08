// comments are in mixed language (Nepali and English) as this is a personal project
// this was initially made with 3 months of work experience in flutter
// ignore_for_file: unused_field

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import 'components/controls.dart';
import 'components/snake.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String text = "Projects Screen";
  final FocusNode _focusNode = FocusNode();

  final List<double> _boxXPositions = List.filled(6, 0);
  final List<double> _boxYPositions = List.filled(6, 0);

  double _snakeXPosition = 0;
  double _snakeYPosition = 0;

  bool _isMovingHorizontally = false;
  final bool _isMovingVertically = false;
  
  Timer? _movementTimer;
  int _currentDirection = 1; // 1: right, 2: left, 3: up, 4: down
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();

    // Initialize snake position
    _snakeXPosition = 100;
    _snakeYPosition = 100;
    for (int i = 0; i < _boxXPositions.length; i++) {
      _boxXPositions[i] = _snakeXPosition - i * 20;
      _boxYPositions[i] = _snakeYPosition;
    }
    _isMovingHorizontally = true;

    // Start the snake's movement
    _startMovement();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _movementTimer?.cancel(); // Clean up the timer
    super.dispose();
  }

  void _startMovement() {
    _movementTimer?.cancel();
    _movementTimer = Timer.periodic(
      const Duration(milliseconds: 200),
      (timer) {
        if (!_isPaused) {
          setState(() {
            _moveSnake();
          });
        }
      },
    );
  }

  void _moveSnake() {
    // Move the body segments (from tail to head)
    for (int i = _boxXPositions.length - 1; i > 0; i--) {
      _boxXPositions[i] = _boxXPositions[i - 1];
      _boxYPositions[i] = _boxYPositions[i - 1];
    }

    // Move the head based on current direction
    switch (_currentDirection) {
      case 1: // right
        _boxXPositions[0] += 20;
        break;
      case 2: // left
        _boxXPositions[0] -= 20;
        break;
      case 3: // up
        _boxYPositions[0] -= 20;
        break;
      case 4: // down
        _boxYPositions[0] += 20;
        break;
    }

    // Wrap around screen
    _wrapAroundScreen();
  }

  void _changeDirection(int newDirection) {
    // Prevent 180-degree turns
    bool isValidTurn = (_currentDirection == 1 && newDirection == 2) ||
        (_currentDirection == 2 && newDirection == 1) ||
        (_currentDirection == 3 && newDirection == 4) ||
        (_currentDirection == 4 && newDirection == 3);

    // Ignore if it's an invalid turn
    if (isValidTurn) return;

    // Only change direction if not currently turning
    _currentDirection = newDirection;
  }

  void _wrapAroundScreen() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Wrap X position
    if (_boxXPositions[0] < 0) {
      _boxXPositions[0] = screenWidth;
    } else if (_boxXPositions[0] > screenWidth) {
      _boxXPositions[0] = 0;
    }

    // Wrap Y position
    if (_boxYPositions[0] < 0) {
      _boxYPositions[0] = screenHeight;
    } else if (_boxYPositions[0] > screenHeight) {
      _boxYPositions[0] = 0;
    }
  }

  // void _changeDirection(int newDirection) {
  //   if ((_currentDirection == 1 || _currentDirection == 2) &&
  //           (newDirection == 3 || newDirection == 4) ||
  //       (_currentDirection == 3 || _currentDirection == 4) &&
  //           (newDirection == 1 || newDirection == 2)) {
  //     if (!_isTurning) {
  //       _turnDirection = newDirection;
  //       _turnXPosition = _snakeXPosition;
  //       _turnYPosition = _snakeYPosition;
  //       _isTurning = true;
  //     }
  //   }
  // }

  void _upPressed() {
    setState(() {
      text = "Up Pressed";
    });
    _changeDirection(3);
  }

  void _downPressed() {
    setState(() {
      text = "Down Pressed";
    });
    _changeDirection(4);
  }

  void _leftPressed() {
    setState(() {
      text = "Left Pressed";
    });
    _changeDirection(2);
  }

  void _rightPressed() {
    setState(() {
      text = "Right Pressed";
    });
    _changeDirection(1);
  }

  void _stopMoving() {
    _isPaused = true;
  }

  void _resumeMoving() {
    _isPaused = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (value) {
            if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
              _upPressed();
            } else if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
              _downPressed();
            } else if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
              _leftPressed();
            } else if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
              _rightPressed();
            } else if (value.logicalKey == LogicalKeyboardKey.space) {
              if (_isPaused) {
                _resumeMoving();
              } else {
                _stopMoving();
              }
            }
          },
          child: GestureDetector(
            onDoubleTap: _isPaused ? _resumeMoving : _stopMoving,
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy < 0) {
                _upPressed();
              } else {
                _downPressed();
              }
            },
            onHorizontalDragDown: (details) {
              if (details.localPosition.dx < _snakeXPosition) {
                _leftPressed();
              } else {
                _rightPressed();
              }
            },
            child: Stack(
              children: [
                _generateProjects(title: text),
                Controls(
                  downPressed: _downPressed,
                  leftPressed: _leftPressed,
                  rightPressed: _rightPressed,
                  upPressed: _upPressed,
                ),
                Snake(
                  boxXPositions: _boxXPositions,
                  boxYPositions: _boxYPositions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _generateProjects({required String title}) {
    return Align(
      alignment: Alignment.topCenter,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
