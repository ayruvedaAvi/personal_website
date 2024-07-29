import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/custom_appbar.dart';

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