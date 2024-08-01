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
  double _snakeXPosition = 90;
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

  void _updateSnakePosition() {
    setState(() {
      if (_isMovingHorizontally) {
        _snakeXPosition += 2;
        if (_snakeXPosition > MediaQuery.of(context).size.width) {
          _snakeXPosition = -100;
        }
      }
      if (_isMovingVertically) {
        _snakeYPosition += 2;
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
              Snake(xPosition: _snakeXPosition, yPosition: _snakeYPosition),
            ],
          ),
        ),
      ),
    );
  }
}