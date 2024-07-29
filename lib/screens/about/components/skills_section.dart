import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/fonts.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
              fontFamily: GoogleFonts.robotoMono().fontFamily,
            ),
          ),
          const SizedBox(height: 10),
          _buildSkillBar('Flutter', 0.8),
          const SizedBox(height: 10),
          _buildSkillBar('Laravel', 0.6),
          const SizedBox(height: 10),
          _buildSkillBar('Node-JS', 0.5),
        ],
      ),
    );
  }

  Widget _buildSkillBar(String skillName, double level) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          skillName,
          style: profileTextStyle,
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: List.generate(
              10,
              (index) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: index < (level * 10).round()
                        ? const Color.fromARGB(255, 11, 133, 29)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
