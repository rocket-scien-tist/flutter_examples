import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_examples/app/presentation/app_widget.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';
import 'package:mason/mason.dart';

void main() async {
  try {
    final brick = Brick.git(
      const GitPath(
        'https://github.com/felangel/mason',
        path: 'bricks/greeting',
      ),
    );
    coloredPrint('brick:', brick);
    final generator = await MasonGenerator.fromBrick(brick);
    final target = DirectoryGeneratorTarget(Directory.current);
    print(
      'current directory ${Directory.current}',
    );
    await generator.generate(target, vars: <String, dynamic>{'name': 'Dash'});
  } catch (e) {
    coloredPrint('catch rurrent directory: $e', Directory.current);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppWidget(),
    );
  }
}
