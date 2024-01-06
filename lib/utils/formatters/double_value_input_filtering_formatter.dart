import 'package:flutter/services.dart';

class DoubleValueInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // final vOld = oldValue;
    // final vNew = newValue;
    // final v = 0;
    // Allow digits and dots
    if (RegExp(r'^[0-9.]*$').hasMatch(newValue.text)) {
      // Allow only one dot
      if (newValue.text.endsWith('.') &&
          oldValue.text.contains('.') &&
          newValue.text.length > oldValue.text.length) {
        return oldValue;
      }
      return newValue;
    } else {
      return oldValue;
    }
  }
}
