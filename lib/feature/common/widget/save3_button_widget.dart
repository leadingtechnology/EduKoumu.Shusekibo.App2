import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Save3ButtonWidget extends ConsumerStatefulWidget  {

  const Save3ButtonWidget({
    required this.label, 
    this.onPressed, 
    this.debounceDuration = const Duration(seconds: 2),
    super.key,
  });
  
  final VoidCallback? onPressed;
  final String label;
  final Duration debounceDuration;

  @override
  ConsumerState<Save3ButtonWidget> createState() => _Save2ButtonWidgetState();
}

class _Save2ButtonWidgetState extends ConsumerState<Save3ButtonWidget> {
  bool _isButtonDisabled = false;
  
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 130,
      child: ElevatedButton.icon(
        onPressed: _isButtonDisabled || widget.onPressed == null
            ? null
            : () async {
                setState(() => _isButtonDisabled = true);

                widget.onPressed!();

                // ignore: inference_failure_on_instance_creation
                await Future.delayed(widget.debounceDuration);

                if (mounted) {
                  setState(() => _isButtonDisabled = false);
                }
              },
        icon: const Icon(Icons.send_outlined, size: 18,), // 这里假设图标是固定的
        label: Text(widget.label),
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
