import 'package:flutter/material.dart';
import 'package:flutter_examples/features/animated_list_view/presentation/widgets/app_custom_material_reorderable_list_view.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';

class CustomAnimatedListView extends StatefulWidget {
  const CustomAnimatedListView({super.key});

  @override
  CustomAnimatedListViewState createState() => CustomAnimatedListViewState();
}

class CustomAnimatedListViewState extends State<CustomAnimatedListView>
    with TickerProviderStateMixin {
  late List<String> items;

  @override
  void initState() {
    items = List.generate(10, (index) => 'Itemmm $index');
    super.initState();
  }

  final double appPaddingSize = 16;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ReorderableListView.builder(
            onReorderStart: (v) {
              coloredPrint('on reorder statrt', v);
            },
            anchor: 0,
            footer: const Text(
              'footer',
              style: TextStyle(color: Colors.red),
            ),
            header: const Text(
              'header',
              style: TextStyle(color: Color.fromRGBO(123, 231, 123, .5)),
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(appPaddingSize),
                key: ValueKey(items[index]),
                height: 50,
                width: 50,
                color: Colors.transparent,
                child: Text(items[index]),
              );
            },
            itemCount: items.length,
            onReorder: (a, b) {
              setState(() {
                final v = items.removeAt(a);
                items.insert(b, v);
              });
            },
          ),
        ),
        const Divider(
          height: 3,
          thickness: 3,
          color: Colors.tealAccent,
        ),
        Expanded(
          child: AppCustomMaterialReorderableListView.builder(
            onReorderStart: (v) {
              coloredPrint('on reorder statrt', v);
            },
            anchor: 0,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(appPaddingSize),
                key: ValueKey(items[index]),
                height: 50,
                width: 50,
                color: Colors.transparent,
                child: Text(items[index]),
              );
            },
            itemCount: items.length,
            onReorder: (a, b) {
              setState(() {
                final v = items.removeAt(a);
                items.insert(b, v);
              });
            },
          ),
        ),
      ],
    );
  }
}
