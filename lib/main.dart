import 'package:flutter/material.dart';
import 'package:flutter_examples/features/matrix_drawer_menu/presentation/pages/matrix_drawer_menu_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MatrixDrawerMenuPage(),
    );
  }
}
