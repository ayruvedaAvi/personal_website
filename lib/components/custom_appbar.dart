import 'package:flutter/material.dart';

import '../screens/about/about_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/projects/projects_screen.dart';
import 'nav_component.dart';

// ignore: must_be_immutable
class CustomAppbar extends StatelessWidget {
  String selectedPage;
  CustomAppbar({
    super.key,
    this.selectedPage = "Home",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NavigationButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            selectedPage: "Home",
            isSelected: selectedPage == "Home" ? true : false,

          ),
          const SizedBox(width: 20),
          NavigationButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutScreen()));
            },
            selectedPage: "About",
            isSelected: selectedPage == "About" ? true : false,
          ),
          const SizedBox(width: 20),
          NavigationButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ProjectsScreen()));
            },
            selectedPage: "Projects",
            isSelected: selectedPage == "Projects" ? true : false,
          ),
        ],
      ),
    );
  }
}
