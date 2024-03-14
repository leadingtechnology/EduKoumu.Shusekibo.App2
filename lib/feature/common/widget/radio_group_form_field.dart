import 'package:flutter/material.dart';

class RadioGroupFormField extends FormField<String> {
  RadioGroupFormField({
    required Map<String, String> radioMap, 
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
  }) : super(
          builder: (FormFieldState<String> field) {
            return InputDecorator(
              decoration: InputDecoration(
                errorText: field.hasError ? field.errorText : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              child: Wrap(
                children: radioMap.entries.map((entry) {
                  return InkWell(
                    onTap: () {
                      field.didChange(entry.key);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Radio<String>(
                            value: entry.key,
                            groupValue: field.value,
                            onChanged: (String? value) {
                              field.didChange(value);
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              field.didChange(entry.key);
                            },
                            child: Text(entry.value),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
}
