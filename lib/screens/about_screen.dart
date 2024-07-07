import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        children: [
          const Center(
            child: Text("About Screen"),
          ),
          CustomAppbar(selectedPage: "About"),
        ],
      ),
    );
  }
}