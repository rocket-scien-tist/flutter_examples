import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final EdgeInsets? padding;

  const AppScaffold(
      {super.key, required this.title, required this.body, this.padding});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: body,
      ),
    );
  }
}
