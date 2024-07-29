import 'package:flutter/material.dart';

class InfoTile extends StatelessWidget {

  final String title;
  final String content;

  const InfoTile({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.black.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 231, 132, 208),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                content,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}