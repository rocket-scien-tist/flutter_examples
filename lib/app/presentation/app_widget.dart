import 'package:flutter/material.dart';
import 'package:flutter_examples/features/animated_list_view/presentation/pages/go_to_end_whet_tap_animated_list_view_page.dart';
import 'package:flutter_examples/features/custom_expansion_tile/presentation/pages/custom_expansion_tile_page.dart';
import 'package:flutter_examples/features/custom_tabbar/presentation/pages/custom_tab_bar_page.dart';
import 'package:flutter_examples/features/double_value_input_field/presentation/pages/double_value_input_field_page.dart';
import 'package:flutter_examples/features/matrix_drawer_menu/presentation/pages/matrix_drawer_menu_page.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/pages/synchronous_scroll_tabbar_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  final List<Widget> pages = const [
    MatrixDrawerMenuPage(),
    DoubleValueInputFieldPage(),
    CustomExpansionTilePage(),
    SynchronousScrollTabBarPage(),
    CustomTabBarPage(),
    GoToEndWhenTapAnimationViewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Go to page'),
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) => ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => pages[index],
                ),
              );
            },
            child: Text(
              pages[index].toString(),
            ),
          ),
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: pages.length,
        ),
      ),
    );
  }
}
