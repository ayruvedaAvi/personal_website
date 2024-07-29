import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isSelected;
  final String selectedPage;
  const NavigationButton({
    required this.onPressed,
    required this.isSelected,
    required this.selectedPage,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
          isSelected ? const Color.fromARGB(114, 33, 149, 243) : Colors.transparent,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        selectedPage,
        style: TextStyle(
          fontSize: 16,
          color: isSelected ? Colors.white : Colors.grey,
        ),
      ),
    );
  }
}
