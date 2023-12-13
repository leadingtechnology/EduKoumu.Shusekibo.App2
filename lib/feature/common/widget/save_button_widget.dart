import 'package:flutter/material.dart';

class SaveButtonWidget extends StatelessWidget {

  const SaveButtonWidget({
    required this.label, this.onPressed, super.key,
  });
  
  final VoidCallback? onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save_alt_outlined), // 这里假设图标是固定的
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0056d2),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
