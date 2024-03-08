import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    super.key,
    bool? initialValue,
    String? text,
    super.onSaved,
  }) : super(
          initialValue: initialValue ?? false,
          builder: (FormFieldState<bool> state) {
            return SizedBox(
              width: 120,
              child: CheckboxListTile(
                title:Text('$text', style: const TextStyle(fontSize: 14),),
                value: state.value,
                onChanged: (bool? value) {
                  state.didChange(value);
                },
              ),
            );
          },
        );
}
