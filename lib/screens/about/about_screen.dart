import 'package:flutter/material.dart';
import 'package:personal_website/components/custom_appbar.dart';

import '../../core/constants/fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppbar(selectedPage: "About"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 119, 1, 91),
              Color.fromARGB(255, 5, 84, 127)
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildProfileSection(),
                const SizedBox(height: 20),
                _buildInfoGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      "Hello there!",
      style: titleTextStyle,
    );
  }

  Widget _buildProfileSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
        const SizedBox(width: 16),
        Expanded(
          flex: 1,
          child: Center(
            child: SizedBox(
              width: 250,
              height: 250,
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

  Widget _buildInfoGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      runAlignment: WrapAlignment.spaceBetween,
      children: [
        _buildInfoTile("Education", "California, USA\nWellington, NZ"),
        _buildInfoTile("Experience", "13 years"),
        _buildInfoTile("Superpower", "High fidelity prototyping"),
        _buildInfoTile("Reading", "Fair Weather\nHitchhiker"),
        _buildInfoTile(
            "Volunteering", "Mission High School,\nHiking Club Gear"),
        _buildInfoTile(
            "Spirit animal", "An inquisitive river\notter that designs"),
      ],
    );
  }

  Widget _buildInfoTile(String title, String content) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 200),
    child: Card(
      margin: EdgeInsets.zero,
      elevation: 2.0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              content,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
}
