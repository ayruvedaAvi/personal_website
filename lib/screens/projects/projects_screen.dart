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

  //Legacy code
  // // boxes x ra y position (1 bhanya head and likewise)
  // double _box1xPosition = 0;
  // double _box1yPosition = 0;
  // double _box2xPosition = 0;
  // double _box2yPosition = 0;
  // double _box3xPosition = 0;
  // double _box3yPosition = 0;
  // double _box4xPosition = 0;
  // double _box4yPosition = 0;
  // double _box5xPosition = 0;
  // double _box5yPosition = 0;
  // double _box6xPosition = 0;
  // double _box6yPosition = 0;

  List<double> _boxXPositions = List.filled(6, 0);
  List<double> _boxYPositions = List.filled(6, 0);

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

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 16), // AI said this is equivalent to 60fps lol
    )..addListener(_updateSnakePosition);
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
    } else if (_isMovingHorizontally) {
      _handleHorizontalMovement();
    } else if (_isMovingVertically) {
      _handleVerticalMovement();
    }
  }

  void _handleTurning() {
    // I am trying to turn the snake in a way that it looks like it is bending
    // pachhi aafai birsinchhu k garya garya bhanera so I will write down what I am trying to do

    // since I have made the containers of 20x20, I am using 20 as the distance to turn
    double distanceToTurn = 20;

    // a flag to check if all boxes have turned
    bool allBoxesTurned = true;

    // loop through all the boxes
    for (int i = 0; i < 6; i++) {
      // particular box ko position
      double boxX = _boxXPositions[i];
      double boxY = _boxYPositions[i];

      if (_turnDirection == 1 || _turnDirection == 2) {
        // mathi ko if check is to know if the snake is turning left or right
        if ((boxX - _turnXPosition).abs() > 1) {
          // this checks if the box has exceeded the turning point
          _boxXPositions[i] += (boxX < _turnXPosition) ? 2 : -2;
          // this moves the box to the turning point
          allBoxesTurned = false;
          // as one is still moving so all boxes have not turned
        } else {
          // yaa aaipugnu bhanya box has reached the turning point
          _boxXPositions[i] = _turnXPosition;
          // since the box is turning left or right, x position is fixed
          // after it completes turning it should move on y axis so the following
          _boxYPositions[i] = _turnYPosition +
              i * distanceToTurn * (_turnDirection == 1 ? 1 : -1);
        }
      } else {
        // turning up or down
        if ((boxY - _turnYPosition).abs() > 1) {
          _boxYPositions[i] += (boxY < _turnYPosition) ? 2 : -2;
          allBoxesTurned = false;
        } else {
          _boxYPositions[i] = _turnYPosition;
          _boxXPositions[i] = _turnXPosition +
              i * distanceToTurn * (_turnDirection == 3 ? -1 : 1);
        }
      }
    }

    if (allBoxesTurned) {
      // sab box turn bhayo so 
      // the following is basically resetting the flags
      _isTurning = false;
      _isMovingHorizontally = _turnDirection == 1 || _turnDirection == 2;
      _isMovingVertically = _turnDirection == 3 || _turnDirection == 4;
      _turnDirection = 0;
    }
  }

  void _handleHorizontalMovement() {
    double distanceBetweenBoxes = 20;
    // legacy code
    // _box1xPosition = _snakeXPosition;
    // _box1yPosition = _snakeYPosition;
    // // _box2xPosition = _snakeXPosition - distanceBetweenBoxes; garne yesari tara loop ma
    _boxXPositions[0] = _snakeXPosition;
    _boxYPositions[0] = _snakeYPosition;

    for (int i = 1; i < 6; i++) {
      _boxXPositions[i] = _boxXPositions[0] - i * distanceBetweenBoxes;
      _boxYPositions[i] = _boxYPositions[0];
    }
  }

  void _handleVerticalMovement() {
    double distanceBetweenBoxes = 20;
    _boxXPositions[0] = _snakeXPosition;
    _boxYPositions[0] = _snakeYPosition;

    for (int i = 1; i < 6; i++) {
      _boxYPositions[i] = _boxYPositions[0] - i * distanceBetweenBoxes;
      _boxXPositions[i] = _boxXPositions[0];
    }
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
      _calculateSnakePosition();
    });
  }

  void _startMovingHorizontally(bool toRight) {
    if (!_isMovingHorizontally) {
      _turnDirection = toRight ? 1 : 2;
      _turnXPosition = _snakeXPosition;
      _turnYPosition = _snakeYPosition;
      _isTurning = true;
      _animationController.repeat();
    }
  }

  void _startMovingVertically(bool toDown) {
    if (!_isMovingVertically) {
      _turnDirection = toDown ? 4 : 3;
      _turnXPosition = _snakeXPosition;
      _turnYPosition = _snakeYPosition;
      _isTurning = true;
      _animationController.repeat();
    }
  }

  void _stopMoving() {
    _isMovingHorizontally = false;
    _isMovingVertically = false;
    _animationController.stop();
  }

  //  _startMoving(H/R) bolauda I am passing true if I want to move right or down

  void _upPressed() {
    setState(() {
      text = "Up Pressed";
    });
    _startMovingVertically(false);
  }

  void _downPressed() {
    setState(() {
      text = "Down Pressed";
    });
    _startMovingVertically(true);
  }

  void _leftPressed() {
    setState(() {
      text = "Left Pressed";
    });
    _startMovingHorizontally(false);
  }

  void _rightPressed() {
    setState(() {
      text = "Right Pressed";
    });
    _startMovingHorizontally(true);
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
                //legacy code
                // box1xPosition: _box1xPosition,
                // box1yPosition: _box1yPosition,
                // box2xPosition: _box2xPosition,
                // box2yPosition: _box2yPosition,
                // box3xPosition: _box3xPosition,
                // box3yPosition: _box3yPosition,
                // box4xPosition: _box4xPosition,
                // box4yPosition: _box4yPosition,
                // box5xPosition: _box5xPosition,
                // box5yPosition: _box5yPosition,
                // box6xPosition: _box6xPosition,
                // box6yPosition: _box6yPosition,
                boxXPositions: _boxXPositions,
                boxYPositions: _boxYPositions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
