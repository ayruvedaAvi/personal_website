import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../components/custom_appbar.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        children: [
          const Center(
            child: Text("Projects Screen"),
          ),
          CustomAppbar(selectedPage: "Projects"),
        ],
      ),
    );
  }
}