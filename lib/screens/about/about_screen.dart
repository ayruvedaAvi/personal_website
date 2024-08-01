import 'package:flutter/material.dart';
import 'package:personal_website/screens/about/components/social_links.dart';

import '../../components/custom_appbar.dart';
import '../../core/constants/fonts.dart';
import 'components/contact_links.dart';
import 'components/info_grid.dart';
import 'components/profile_section.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Color> colorList = [
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];
  int index = 0;
  Color bottomColor = const Color.fromARGB(255, 5, 84, 127);
  Color topColor = const Color.fromARGB(255, 119, 1, 91);
  Alignment begin = Alignment.topLeft;
  Alignment end = Alignment.bottomRight;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _controller.addListener(() {
      if (_controller.isCompleted) {
        _controller.repeat();
      }
      setState(() {
        bottomColor = colorList[index % colorList.length];
        topColor = colorList[(index + 2) % colorList.length];
        begin = begin;
        end = end;
      });
      index++;
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomAppbar(selectedPage: "About"),
        automaticallyImplyLeading: false,
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: begin,
            end: end,
            colors: [topColor, bottomColor],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                const ProfileSection(),
                const SizedBox(height: 20),
                const InfoGrid(),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 20,
                  child: const Text(
                    "Reach me: ",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
                const SocialLinks(),
                const SizedBox(height: 30),
                const ContactLinks(),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 20,
                  child: const Text(
                    "© 2024 Abhishek Neupane",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
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
}
