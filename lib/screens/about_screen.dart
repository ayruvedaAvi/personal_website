import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: baseColor,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text("Experience", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          Text(
                            "Lorem Ipsum dolor dsa  fds fads fd af asd fdsa f sdaf sdaf sda fasd fsda fsdaf sda fsad f asdf sda fsda f sdaf sad fdsaa f dasf sda f ads f dsa fa sd fasdf dasf asdf a sdf sda",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        children: [
                          Text("Education", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          Text(
                            "Lorem Ipsum dolor dsa  fds fads fd af asd fdsa f sdaf sdaf sda fasd fsda fsdaf sda fsad f asdf sda fsda f sdaf sad fdsaa f dasf sda f ads f dsa fa sd fasdf dasf asdf a sdf sda",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CustomAppbar(selectedPage: "About"),
            ],
          ),
        ),
      ),
    );
  }
}
