import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../about/about_screen.dart';
import '../projects/projects_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _leftCircleController;
  late final AnimationController _rightCircleController;

  @override
  void initState() {
    super.initState();
    _leftCircleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _rightCircleController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _leftCircleController.dispose();
    _rightCircleController.dispose();
    super.dispose();
  }

  final List<Widget> _navButtons = [
    const _NavButton(text: 'HOME', screen: HomeScreen()),
    const _NavButton(
      text: 'PROJECTS',
      screen: ProjectsScreen(),
    ),
    const _NavButton(text: 'CONTACT', screen: AboutScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text('Abhishek', style: GoogleFonts.delius()),
        ),
        backgroundColor: Colors.black,
        actions: [
          ..._navButtons,
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(
        children: [
          // Animated circles
          _buildAnimatedCircle(
            controller: _leftCircleController,
            color: Colors.greenAccent,
            screenWidth: screenWidth,
            isLeft: true,
          ),
          _buildAnimatedCircle(
            controller: _rightCircleController,
            color: Colors.redAccent,
            screenWidth: screenWidth,
            isLeft: false,
          ),
          // Backdrop blur
          const Positioned.fill(
            child: _BackdropBlur(),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _MainContent(isMobile: isMobile, screenWidth: screenWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedCircle({
    required AnimationController controller,
    required Color color,
    required double screenWidth,
    required bool isLeft,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final double position = isLeft
            ? Tween<double>(begin: -100, end: screenWidth)
                .animate(CurvedAnimation(
                  parent: controller,
                  curve: Curves.slowMiddle,
                ))
                .value
            : Tween<double>(
                begin: screenWidth + 100,
                end: screenWidth - screenWidth + 100,
              )
                .animate(CurvedAnimation(
                  parent: controller,
                  curve: Curves.slowMiddle,
                ))
                .value;

        return Positioned(
          left: position,
          bottom: -30,
          child: child!,
        );
      },
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 120, sigmaY: 80),
        child: Container(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String text;
  final Widget screen;

  const _NavButton({required this.text, required this.screen});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}

class _BackdropBlur extends StatelessWidget {
  const _BackdropBlur();

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
      child: Container(
        color: Colors.black.withOpacity(0.3),
      ),
    );
  }
}

class _MainContent extends StatelessWidget {
  final bool isMobile;
  final double screenWidth;

  const _MainContent({
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildContentItems(),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _buildContentItems(),
                ),
        ),
      ],
    );
  }

  List<Widget> _buildContentItems() {
    return [
      Expanded(
        flex: isMobile ? 1 : 2,
        child: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: _IntroSection(isMobile: isMobile),
        ),
      ),
      if (!isMobile)
        Expanded(
          flex: 3,
          child: _ImageSection(
            isMobile: isMobile,
            screenWidth: screenWidth,
          ),
        ),
      Expanded(
        flex: isMobile ? 1 : 4,
        child: _HeadlineSection(isMobile: isMobile),
      ),
    ];
  }
}

class _IntroSection extends StatelessWidget {
  final bool isMobile;

  const _IntroSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Blending my passion for Flutter development and mountain biking,\n"
          "I'm driven to create dynamic, responsive apps that perform\n"
          "smoothly on any terrain. Just like on the trails, I navigate\n"
          "the challenges of coding with agility and persistence.",
          style: GoogleFonts.hiMelody(
            color: Colors.white70,
            fontSize: 20,
          ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          child: const Text("LET'S CONTACT"),
        ),
      ],
    );
  }
}

class _ImageSection extends StatelessWidget {
  final bool isMobile;
  final double screenWidth;

  const _ImageSection({
    required this.isMobile,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: Container(
        width: isMobile ? screenWidth * 0.8 : 500,
        height: isMobile ? screenWidth * 0.8 : 500,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/mtb.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class _HeadlineSection extends StatelessWidget {
  final bool isMobile;

  const _HeadlineSection({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMobile
          ? const EdgeInsets.symmetric(vertical: 20)
          : const EdgeInsets.only(right: 40),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: Alignment.centerRight,
        child: Text(
          "Driven by \nDESIGN, \nFocus on \nFUNCTIONALITY",
          textAlign: TextAlign.right,
          style: GoogleFonts.hiMelody(
            color: Colors.white,
            fontSize: isMobile ? 30 : 70,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
