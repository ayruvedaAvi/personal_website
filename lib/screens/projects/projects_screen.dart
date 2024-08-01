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

class _ProjectsScreenState extends State<ProjectsScreen> with SingleTickerProviderStateMixin {
  String text = "Projects Screen";
  final FocusNode _focusNode = FocusNode();
  double _snakePosition = 0;
  bool _isMoving = false;
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
    if (_isMoving) {
      setState(() {
        _snakePosition += 2; // Adjust this value to change speed
        if (_snakePosition > MediaQuery.of(context).size.width) {
          _snakePosition = -100; // Reset position when off-screen
        }
      });
    }
  }

  void _startMoving() {
    if (!_isMoving) {
      _isMoving = true;
      _animationController.repeat();
    }
  }

  void _stopMoving() {
    if (_isMoving) {
      _isMoving = false;
      _animationController.stop();
    }
  }

  void _upPressed() {
    setState(() {
      text = "Up Pressed";
    });
  }

  void _downPressed() {
    setState(() {
      text = "Down Pressed";
    });
  }

  void _leftPressed() {
    setState(() {
      text = "Left Pressed";
    });
  }

  void _rightPressed() {
    setState(() {
      text = "Right Pressed";
    });
    _startMoving();
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
            if(_isMoving) {
              _stopMoving();
            } else {
              _startMoving();
            }
          }
        },
        child: Stack(
          children: [
            Center(
              child: Text(
                "Pojects section is still under construction $text",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Controls(
              downPressed: _downPressed,
              leftPressed: _leftPressed,
              rightPressed: _rightPressed,
              upPressed: _upPressed,
            ),
            Snake(xPosition: _snakePosition),
          ],
        ),
      )),
    );
  }
}
