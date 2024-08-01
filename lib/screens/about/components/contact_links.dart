import 'package:flutter/material.dart';

class ContactLinks extends StatelessWidget {
  const ContactLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 30,
        ),
        Row(
          children: [
            const Icon(
              Icons.email,
              color: Colors.orange,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
              ),
              child: const Text(
                ': neupaneabhishek20@gmail.com',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.green),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
              ),
              child: const Text(
                ': +977-9864274744',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.location_on, color: Colors.red),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
              ),
              child: const Text(
                ': Bhaktapur, Nepal',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 30,
        ),
      ],
    );
  }
}
