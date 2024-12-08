// comments are in mixed language (Nepali and English) as this is a personal project
// this was initially made with 3 months of work experience in flutter

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

class _ProjectsScreenState extends State<ProjectsScreen>
    with SingleTickerProviderStateMixin {
  String text = "Projects Screen";
  final FocusNode _focusNode = FocusNode();

  final List<double> _boxXPositions = List.filled(6, 0);
  final List<double> _boxYPositions = List.filled(6, 0);

  // while button pressed tauko ko position store garna ko lagi
  double _turnXPosition = 0;
  double _turnYPosition = 0;

  // actual animation le move garne snake ko position
  double _snakeXPosition = 0;
  double _snakeYPosition = 0;

  // to know if the snake is moving horizontally or vertically
  bool _isMovingHorizontally = false;
  bool _isMovingVertically = false;

  // snake turn garda chaiine flags
  bool _isTurning = false;
  int _turnDirection = 0;

  // rajesh dai ho yo animation controller
  // this shii is the khalnayak of this project
  late AnimationController _animationController;

  // New variables for snake movement
  int _currentDirection = 1; // 1: right, 2: left, 3: up, 4: down
  final double _speed = 2.0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 16), // AI said this is equivalent to 60fps lol
    )..addListener(_updateSnakePosition);

    // Initialize snake position
    _snakeXPosition = 100;
    _snakeYPosition = 100;
    for (int i = 0; i < _boxXPositions.length; i++) {
      _boxXPositions[i] = _snakeXPosition - i * 20;
      _boxYPositions[i] = _snakeYPosition;
    }
    _isMovingHorizontally = true;
    _animationController.repeat();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateSnakePosition() {
    if (_isTurning) {
      _handleTurning();
    } else {
      _moveSnake();
    }
  }

  void _handleTurning() {
    double distanceToTurn = 20;
    bool allBoxesTurned = true;

    for (int i = 0; i < 6; i++) {
      double boxX = _boxXPositions[i];
      double boxY = _boxYPositions[i];

      if (_turnDirection == 1 || _turnDirection == 2) {
        if ((boxX - _turnXPosition).abs() > 1) {
          _boxXPositions[i] += (boxX < _turnXPosition) ? _speed : -_speed;
          allBoxesTurned = false;
        } else {
          _boxXPositions[i] = _turnXPosition;
          _boxYPositions[i] = _turnYPosition +
              i * distanceToTurn * (_turnDirection == 1 ? 1 : -1);
        }
      } else {
        if ((boxY - _turnYPosition).abs() > 1) {
          _boxYPositions[i] += (boxY < _turnYPosition) ? _speed : -_speed;
          allBoxesTurned = false;
        } else {
          _boxYPositions[i] = _turnYPosition;
          _boxXPositions[i] = _turnXPosition +
              i * distanceToTurn * (_turnDirection == 3 ? -1 : 1);
        }
      }
    }

    if (allBoxesTurned) {
      _isTurning = false;
      _isMovingHorizontally = _turnDirection == 1 || _turnDirection == 2;
      _isMovingVertically = _turnDirection == 3 || _turnDirection == 4;
      _currentDirection = _turnDirection;
      _turnDirection = 0;
    }
  }

  void _moveSnake() {
    // Move the body
    for (int i = _boxXPositions.length - 1; i > 0; i--) {
      _boxXPositions[i] = _boxXPositions[i - 1];
      _boxYPositions[i] = _boxYPositions[i - 1];
    }

    // Move the head
    switch (_currentDirection) {
      case 1: // right
        _snakeXPosition += _speed;
        break;
      case 2: // left
        _snakeXPosition -= _speed;
        break;
      case 3: // up
        _snakeYPosition -= _speed;
        break;
      case 4: // down
        _snakeYPosition += _speed;
        break;
    }

    // Update head position
    _boxXPositions[0] = _snakeXPosition;
    _boxYPositions[0] = _snakeYPosition;

    // Wrap around screen
    _wrapAroundScreen();
  }

  void _wrapAroundScreen() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_snakeXPosition < -20) {
      _snakeXPosition = screenWidth;
    } else if (_snakeXPosition > screenWidth) {
      _snakeXPosition = -20;
    }

    if (_snakeYPosition < -20) {
      _snakeYPosition = screenHeight;
    } else if (_snakeYPosition > screenHeight) {
      _snakeYPosition = -20;
    }
  }

  void _updateSnakePosition() {
    setState(() {
      _calculateSnakePosition();
    });
  }

  void _changeDirection(int newDirection) {
    if ((_currentDirection == 1 || _currentDirection == 2) &&
            (newDirection == 3 || newDirection == 4) ||
        (_currentDirection == 3 || _currentDirection == 4) &&
            (newDirection == 1 || newDirection == 2)) {
      if (!_isTurning) {
        _turnDirection = newDirection;
        _turnXPosition = _snakeXPosition;
        _turnYPosition = _snakeYPosition;
        _isTurning = true;
      }
    }
  }

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
    _animationController.stop();
  }

  void _resumeMoving() {
    _isPaused = false;
    _animationController.repeat();
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
