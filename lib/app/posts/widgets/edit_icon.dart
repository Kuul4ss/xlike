import 'package:flutter/material.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.edit),
    );
  }
}
