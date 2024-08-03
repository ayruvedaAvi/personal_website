import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/projects/projects_screen.dart';

void main() {
  runApp(const MyApp());
}


final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 143, 69, 211),
    brightness: Brightness.dark,
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: theme,
      home:  const Scaffold(
        body: ProjectsScreen(),
      ),
    );
  }
}
