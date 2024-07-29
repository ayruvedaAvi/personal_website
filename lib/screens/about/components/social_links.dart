import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

final iconButtonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.all(
    Colors.black.withOpacity(0.3),
  ),
);

class SocialLinks extends StatefulWidget {
  const SocialLinks({super.key});

  @override
  State<SocialLinks> createState() => _SocialLinksState();
}

class _SocialLinksState extends State<SocialLinks> {
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    Future<void>? launched;

    final Uri githubUrl = Uri.parse('https://github.com/ayruvedaAvi');
    final Uri twitterUrl = Uri.parse('https://x.com/abhishek_wubs');
    final Uri instagramUrl = Uri.parse('https://www.instagram.com/__abhishek.neupane/');
    final Uri linkedinUrl = Uri.parse('https://www.linkedin.com/in/abhishek-neupane-05a9b82ab/');

    Future<void> launchTheUrl(url) async {
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Could not launch $url'),
              width: 200,
            ),
          );
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            style: iconButtonStyle,
            onPressed: () => setState(() {
              launched = launchTheUrl(githubUrl);
            }),
            icon: SvgPicture.asset(
              'assets/icons/github.svg',
              colorFilter: const ColorFilter.mode(
                Colors.purple,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            style: iconButtonStyle,
            onPressed: () {
              setState(() {
                launched = launchTheUrl(twitterUrl);
              });
            },
            icon: SvgPicture.asset(
              'assets/icons/twitter.svg',
              colorFilter: const ColorFilter.mode(
                Colors.blue,
                BlendMode.srcIn,
              ),
            ),
          ),
          IconButton(
            style: iconButtonStyle,
            onPressed: () {
              setState(() {
                launched = launchTheUrl(instagramUrl);
              });
            },
            icon: SvgPicture.asset('assets/icons/instagram.svg',
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                )),
          ),
          IconButton(
            style: iconButtonStyle,
            onPressed: () {
              setState(() {
                launched = launchTheUrl(linkedinUrl);
              });
            },
            icon: SvgPicture.asset(
              'assets/icons/linkedin.svg',
              colorFilter: const ColorFilter.mode(
                Colors.blue,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
