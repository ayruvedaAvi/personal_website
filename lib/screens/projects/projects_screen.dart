import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/colors.dart';
import 'components/controls.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String text = "Projects Screen";

  upPressed() {
    setState(() {
      text = "Up Pressed";
    });
  }

  void downPressed() {
    setState(() {
      text = "Down Pressed";
    });
  }

  void leftPressed() {
    setState(() {
      text = "Left Pressed";
    });
  }

  void rightPressed() {
    setState(() {
      text = "Right Pressed";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (value) {
              if (value.logicalKey == LogicalKeyboardKey.arrowUp) {
                setState(() {
                  text = "Up Pressed";
                });
                upPressed();
              } else if (value.logicalKey == LogicalKeyboardKey.arrowDown) {
                downPressed();
              } else if (value.logicalKey == LogicalKeyboardKey.arrowLeft) {
                leftPressed();
              } else if (value.logicalKey == LogicalKeyboardKey.arrowRight) {
                rightPressed();
              }
            },
            child: Stack(
              children: [
                Center(
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                Controls(
                  downPressed: downPressed,
                  leftPressed: leftPressed,
                  rightPressed: rightPressed,
                  upPressed: upPressed,
                ),
              ],
            ),
          )),
    );
  }
}
