import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatters {
  static final phoneFormatter = MaskTextInputFormatter(
    mask: '(##) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );
}
