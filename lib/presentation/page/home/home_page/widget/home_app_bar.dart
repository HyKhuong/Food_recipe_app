import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: Text(
            'What are you cooking for today?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: width * 0.07,
              height: 1,
            ),
          ),
        ),
      ],
    );
  }
}
