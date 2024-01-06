import 'package:flutter/foundation.dart';

coloredPrint(
  String sign, [
  dynamic data = '',
]) {
  if (kDebugMode) {
    // ignore: unused_local_variable
    String text =
        '\x1B[94m  \x1B[93m$sign => \x1B[96m${data.toString()}\x1B[0m';
    print(text);
  }
}
