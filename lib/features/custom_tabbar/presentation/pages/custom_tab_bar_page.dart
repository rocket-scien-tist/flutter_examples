import 'package:flutter/material.dart';
import 'package:flutter_examples/features/common/presentation/widgets/app_page_frame.dart';
import 'package:flutter_examples/features/custom_tabbar/presentation/pages/custom_tabbar.dart';

class CustomTabBarPage extends StatelessWidget {
  const CustomTabBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: toString(),
      body: CustomTabBar(
        tabs: const [
          Tab(
            text: 'Tab 1',
          ),
          Tab(
            text: 'Tab 2',
          ),
          Tab(
            text: 'Tab 3',
          ),
        ],
        onChanged: (v) {},
      ),
    );
  }
}
