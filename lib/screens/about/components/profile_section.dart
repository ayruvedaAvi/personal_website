import 'package:flutter/material.dart';

import '../../../core/constants/fonts.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("I really enjoy programming and writing clean codes.",
                      style: profileTextStyle),
                  const SizedBox(height: 10),
                  Text(
                      "I maynot be the best programmer in the world but I am a fast learner and I am always willing to learn new things.",
                      style: profileTextStyle),
                  const SizedBox(height: 10),
                  Text(
                      "Outside of work I enjoy travel, hiking, riding mountain bikes and gaming.",
                      style: profileTextStyle),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Center(
            child: SizedBox(
              width: 350,
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/profile_image.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}