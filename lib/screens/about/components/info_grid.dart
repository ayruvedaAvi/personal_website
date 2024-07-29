import 'package:flutter/material.dart';
import 'package:personal_website/screens/about/components/info_tile.dart';
import 'package:personal_website/screens/about/components/skills_section.dart';

class InfoGrid extends StatelessWidget {
  const InfoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          runAlignment: WrapAlignment.spaceBetween,
          children: [
            InfoTile(
                title: "Education",
                content:
                    "  SEE:   The rising star school, Charikot, Dolakha \n\n  High School:  NIST, Lainchaur, Kathmandu \n\n  BESE:    NCIT, Balkumari, Lalitpur"),
            InfoTile(
              title: "Experience",
              content:
                  "  Flutter: Jan-2024 to present (Infocom Solutions) \n\n  Laravel: March-2024 to present (Infocom Solutions) ",
            ),
            InfoTile(
                title: "Interests",
                content:
                    "  Traveling \n  Hiking  \n Mountain Biking  \n  Gaming \n  Programming"),
          ],
        ),
        SizedBox(height: 20),
        SkillsSection(),
      ],
    );
  }
}
