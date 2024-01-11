import 'package:flutter/material.dart';
import 'package:flutter_examples/features/animated_list_view/presentation/widgets/custom_animated_list_widget.dart';
import 'package:flutter_examples/features/common/presentation/widgets/app_page_frame.dart';

class GoToEndWhenTapAnimationViewPage extends StatelessWidget {
  const GoToEndWhenTapAnimationViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: toString(),
      body: CustomAnimatedListView(),
    );
  }
}
