import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const CircleButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        CircleAvatar(
          radius: w * .06,
          backgroundColor: const Color.fromARGB(255, 97, 231, 73),
          child: Center(child: Icon(icon, color: Colors.white)),
        ),
        SizedBox(height: h * .01),
        Text(label)
      ],
    );
  }
}
