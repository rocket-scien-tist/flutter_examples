import 'package:flutter/widgets.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';

class AppCustomKeyedSubtree extends StatelessWidget {
  /// Creates a widget that builds its child.
  const AppCustomKeyedSubtree({
    super.key,
    required this.child,
  });

  /// Creates a KeyedSubtree for child with a key that's based on the child's existing key or childIndex.
  factory AppCustomKeyedSubtree.wrap(Widget child, int childIndex) {
    final Key key = child.key != null
        ? ValueKey<Key>(child.key!)
        : ValueKey<int>(childIndex);
    return AppCustomKeyedSubtree(key: key, child: child);
  }

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// Wrap each item in a KeyedSubtree whose key is based on the item's existing key or
  /// the sum of its list index and `baseIndex`.
  static List<Widget> ensureUniqueKeysForList(List<Widget> items,
      {int baseIndex = 0}) {
    if (items.isEmpty) {
      return items;
    }

    final List<Widget> itemsWithUniqueKeys = <Widget>[];
    int itemIndex = baseIndex;
    for (final Widget item in items) {
      coloredPrint('keyilize', 'data');
      itemsWithUniqueKeys.add(AppCustomKeyedSubtree.wrap(item, itemIndex));
      itemIndex += 1;
    }

    assert(!debugItemsHaveDuplicateKeys(itemsWithUniqueKeys));
    return itemsWithUniqueKeys;
  }

  @override
  Widget build(BuildContext context) {
    coloredPrint('ket sub tree build', child.key);
    return child;
  }
}
