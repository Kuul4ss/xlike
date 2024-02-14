import 'package:flutter/material.dart';

class AccountIcon extends StatelessWidget {
  const AccountIcon({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.login),
    );
  }
}
