
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Controls extends StatelessWidget {
  final Function upPressed;
  final Function downPressed;
  final Function leftPressed;
  final Function rightPressed;

  const Controls({
    super.key,
    required this.upPressed,
    required this.downPressed,
    required this.leftPressed,
    required this.rightPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.2,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            "You can also use arrow keys to move and space to start/stop",
            style: TextStyle(
              color: Colors.lightBlue,
              fontSize: 10,
              fontFamily: GoogleFonts.robotoMono().fontFamily,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(
                width: 40,
              ),
              IconButton(
                onPressed: () => upPressed(),
                icon: SvgPicture.asset(
                  'assets/icons/arrow-up.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: () => leftPressed(),
                icon: SvgPicture.asset(
                  'assets/icons/arrow-left.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
                ),
              ),
              IconButton(
                onPressed: () => downPressed(),
                icon: SvgPicture.asset(
                  'assets/icons/arrow-down.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
                ),
              ),
              IconButton(
                onPressed: () => rightPressed(),
                icon: SvgPicture.asset(
                  'assets/icons/arrow-right.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.lightBlue, BlendMode.srcIn),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
