import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../components/custom_appbar.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        children: [
          const Center(
            child: Text("Contact Screen"),
          ),
          CustomAppbar(selectedPage: "Contact"),
        ],
      ),
    );
  }
}