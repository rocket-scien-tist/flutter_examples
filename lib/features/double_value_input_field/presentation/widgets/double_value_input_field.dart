import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_examples/utils/formatters/double_value_input_filtering_formatter.dart';

class DoubleValueInputField extends StatelessWidget {
  final TextEditingController controller;
  final String suffixText;
  final ValueChanged<String> onChanged;

  const DoubleValueInputField({
    super.key,
    required this.controller,
    required this.suffixText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: Colors.blueGrey,
      textAlign: TextAlign.start,
      controller: controller,
      magnifierConfiguration: const TextMagnifierConfiguration(
          shouldDisplayHandlesInMagnifier: false),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 2.6,
      ),
      dragStartBehavior: DragStartBehavior.start,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [DoubleValueInputFormatter()],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        focusedErrorBorder: InputBorder.none,
        filled: false,
        suffixIconConstraints: const BoxConstraints.tightForFinite(height: 45),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                suffixText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 2.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
