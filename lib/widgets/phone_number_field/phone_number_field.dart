import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_examples/widgets/phone_number_field/formatters/mask_text_input_formatter.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;
  final EdgeInsets margin;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final bool? autoFocus;
  final bool? isObSecure;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;

  const PhoneNumberField({
    super.key,
    required this.controller,
    required this.margin,
    this.suffixIcon,
    this.focusNode,
    this.onChanged,
    this.autoFocus,
    this.isObSecure,
    this.inputFormatters,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      focusNode: focusNode,
      obscuringCharacter: '⦿',
      obscureText: isObSecure ?? false,
      style: Theme.of(context).textTheme.headlineMedium,
      autofocus: autoFocus ?? false,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '+998',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
            minWidth: 46, minHeight: 46, maxWidth: 46, maxHeight: 46),
        prefixIconConstraints: const BoxConstraints(
            minWidth: 46, minHeight: 46, maxWidth: 46, maxHeight: 46),
      ),
      controller: controller,
      inputFormatters: inputFormatters ?? [InputFormatters.phoneFormatter],
    );
  }
}
