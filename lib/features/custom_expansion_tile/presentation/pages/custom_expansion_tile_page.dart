import 'package:flutter/material.dart';
import 'package:flutter_examples/features/common/presentation/widgets/app_page_frame.dart';
import 'package:flutter_examples/features/custom_expansion_tile/presentation/widgets/custom_expansion_tile_widget.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';

class CustomExpansionTilePage extends StatelessWidget {
  const CustomExpansionTilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: toString(),
      body: Center(
        child: AppCustomExpansionTile(
          onItemTap: (v) {
            coloredPrint('custom expansion tile item tap:', v);
          },
          title: 'Title',
          children: List.generate(
            5,
            (index) => Text(
              'item ${index + 1}',
            ),
          ),
        ),
      ),
    );
  }
}
