import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  const HomeIcon({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.home),
    );
  }
}
