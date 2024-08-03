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
  double _box1xPosition = 0;
  double _box1yPosition = 0;
  double _box2xPosition = 0;
  double _box2yPosition = 0;
  double _box3xPosition = 0;
  double _box3yPosition = 0;
  double _box4xPosition = 0;
  double _box4yPosition = 0;
  double _box5xPosition = 0;
  double _box5yPosition = 0;
  double _box6xPosition = 0;
  double _box6yPosition = 0;
  double _turnXPosition = 0;
  double _turnYPosition = 0;
  double _snakeXPosition = 0;
  double _snakeYPosition = 0;
  bool _isMovingHorizontally = false;
  bool _isMovingVertically = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16), // ~60 FPS
    )..addListener(_updateSnakePosition);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateSnakePosition() {
    if (_isMovingHorizontally) {
      if (_snakeXPosition > _turnXPosition) {
        _box1xPosition = _snakeXPosition;
        _box1yPosition = _snakeYPosition;
        _box2xPosition = _snakeXPosition - 20;
        _box2yPosition = _snakeYPosition;
        _box3xPosition = _snakeXPosition - 40;
        _box3yPosition = _snakeYPosition;
        _box4xPosition = _snakeXPosition - 60;
        _box4yPosition = _snakeYPosition;
        _box5xPosition = _snakeXPosition - 80;
        _box5yPosition = _snakeYPosition;
        _box6xPosition = _snakeXPosition - 100;
        _box6yPosition = _snakeYPosition;
      } else {
        _box1xPosition = _snakeXPosition;
        _box1yPosition = _snakeYPosition;
        _box2xPosition = _snakeXPosition + 20;
        _box2yPosition = _snakeYPosition;
        _box3xPosition = _snakeXPosition + 40;
        _box3yPosition = _snakeYPosition;
        _box4xPosition = _snakeXPosition + 60;
        _box4yPosition = _snakeYPosition;
        _box5xPosition = _snakeXPosition + 80;
        _box5yPosition = _snakeYPosition;
        _box6xPosition = _snakeXPosition + 100;
        _box6yPosition = _snakeYPosition;
      }
    }
  }

  void _updateSnakePosition() {

    // flag 1 = right
    // flag 2 = left
    // flag 3 = up
    // flag 4 = down

    setState(() {
      if (_isMovingHorizontally) {
         _snakeXPosition += 2;
         _calculateSnakePosition();
        if (_snakeXPosition > MediaQuery.of(context).size.width) {
          _snakeXPosition = -100;
        }
      }
      if (_isMovingVertically) {
        _snakeYPosition += 2;
        _calculateSnakePosition();
        if (_snakeYPosition > MediaQuery.of(context).size.height) {
          _snakeYPosition = -100;
        }
      }
    });
  }

  void _startMovingHorizontally() {
    if (!_isMovingHorizontally) {
      _isMovingHorizontally = true;
      _isMovingVertically = false;
      _animationController.repeat();
    }
  }

  void _startMovingVertically() {
    if (!_isMovingVertically) {
      _isMovingVertically = true;
      _isMovingHorizontally = false;
      _animationController.repeat();
    }
  }

  void _stopMoving() {
    _isMovingHorizontally = false;
    _isMovingVertically = false;
    _animationController.stop();
  }

  void _upPressed() {
    setState(() {
      text = "Up Pressed";
    });
    _snakeYPosition -= 10;
  }

  void _downPressed() {
    setState(() {
      text = "Down Pressed";
    });
    _startMovingVertically();
  }

  void _leftPressed() {
    setState(() {
      text = "Left Pressed";
    });
    _snakeXPosition -= 10;
  }

  void _rightPressed() {
    setState(() {
      text = "Right Pressed";
    });
    _startMovingHorizontally();
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
              _stopMoving();
            }
          },
          child: Stack(
            children: [
              Center(
                child: Text(
                  "Projects section is still under construction $text",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              Controls(
                downPressed: _downPressed,
                leftPressed: _leftPressed,
                rightPressed: _rightPressed,
                upPressed: _upPressed,
              ),
              Snake(
                box1xPosition: _box1xPosition,
                box1yPosition: _box1yPosition,
                box2xPosition: _box2xPosition,
                box2yPosition: _box2yPosition,
                box3xPosition: _box3xPosition,
                box3yPosition: _box3yPosition,
                box4xPosition: _box4xPosition,
                box4yPosition: _box4yPosition,
                box5xPosition: _box5xPosition,
                box5yPosition: _box5yPosition,
                box6xPosition: _box6xPosition,
                box6yPosition: _box6yPosition,
              ),
            ],
          ),
        ),
      ),
    );
  }
}