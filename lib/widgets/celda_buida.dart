import 'package:flutter/material.dart';

class CeldaBuida extends StatelessWidget {
  const CeldaBuida({super.key});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
    );
  }
}
