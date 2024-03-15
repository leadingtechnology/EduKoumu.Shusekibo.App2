import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kyoumutechou/feature/common/provider/common_provider.dart';
import 'package:kyoumutechou/feature/common/provider/tokobis_provider.dart';

class SaveButtonWidget extends ConsumerStatefulWidget  {

  const SaveButtonWidget({
    required this.label, 
    this.onPressed, 
    this.debounceDuration = const Duration(seconds: 2),
    super.key,
  });
  
  final VoidCallback? onPressed;
  final String label;
  final Duration debounceDuration;

  @override
  ConsumerState<SaveButtonWidget> createState() => _SaveButtonWidgetState();
}

class _SaveButtonWidgetState extends ConsumerState<SaveButtonWidget> {
  bool _isButtonDisabled = false;
  
  @override
  Widget build(BuildContext context) {
    final buttonEnable = ref.watch(buttonEnableProvider);
    final isTokobi = ref.watch(isTokobiProvider);

    return SizedBox(
      width: 130,
      child: ElevatedButton.icon(
        onPressed: _isButtonDisabled ||
                !buttonEnable ||
                !isTokobi ||
                widget.onPressed == null
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
        icon: const Icon(Icons.save_alt_outlined), 
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
