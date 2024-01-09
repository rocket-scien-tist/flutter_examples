import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/category/category_model.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/my_header/my_header_model.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/product/product_model.dart';

class SliverScrollController {
  late List<CategoryModel> listCategory;
  List<double> listOffSetItemHeader = [];

  /// Header notifier
  final headerNotifier = ValueNotifier<MyHeaderModel?>(null);

  /// Global offset Value
  final globalOffsetValue = ValueNotifier<double>(0);

  /// Indicator if we are going down or up in the application
  final goingDown = ValueNotifier<bool>(false);

  /// Value to do the validations of the top icons
  final valueScroll = ValueNotifier<double>(0);

  /// To move top items in sliver
  late ScrollController scrollControllerItemHeader;

  /// To have overall control of scrolling
  late ScrollController scrollControllerGlobally;

  /// Value that indicates if the header is visible
  final visibleHeader = ValueNotifier(false);

  void loadDataRandom() {
    final productsTwo = [...products];
    final productsThree = [...products];
    final productsFour = [...products];

    productsTwo.shuffle();
    productsThree.shuffle();
    productsFour.shuffle();

    listCategory = [
      CategoryModel(
        globalKey: GlobalKey(debugLabel: 'Order again'),
        name: 'Order again',
        products: products,
        id: 0,
      ),
      CategoryModel(
        globalKey: GlobalKey(debugLabel: 'Picked For You'),
        name: 'Picked For You',
        products: productsTwo,
        id: 1,
      ),
      CategoryModel(
        globalKey: GlobalKey(debugLabel: 'Startes'),
        name: 'Startes',
        products: productsThree,
        id: 2,
      ),
      CategoryModel(
        globalKey: GlobalKey(debugLabel: "Gimpub Sush"),
        name: 'Gimpub Sushi',
        products: productsFour,
        id: 3,
      ),
    ];
  }

  void init() {
    loadDataRandom();
    listOffSetItemHeader =
        List.generate(listCategory.length, (index) => index.toDouble());
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally.addListener(_listenScrollChange);
    headerNotifier.addListener(_listenHeaderNotifier);
    visibleHeader.addListener(_listenVisibleHeader);
  }

  void _listenVisibleHeader() {
    if (visibleHeader.value) {
      headerNotifier.value = const MyHeaderModel(index: 0, visible: false);
    }
  }

  void dispose() {
    scrollControllerItemHeader.dispose();
    scrollControllerGlobally.dispose();
  }

  void _listenHeaderNotifier() {
    if (visibleHeader.value) {
      for (int i = 0; i < listCategory.length; i++) {
        scrollAnimationHorizontal(index: i);
      }
    }
  }

  void scrollAnimationHorizontal({required int index}) {
    if (headerNotifier.value?.index == index && headerNotifier.value!.visible) {
      scrollControllerItemHeader.animateTo(
        listOffSetItemHeader[headerNotifier.value!.index] - 16,
        duration: const Duration(milliseconds: 1500),
        // curve: goingDown.value ? Curves.bounceOut : Curves.fastOutSlowIn,
        curve: Curves.linearToEaseOut,
      );
    }
  }

  void _listenScrollChange() {
    globalOffsetValue.value = scrollControllerGlobally.offset;
    goingDown.value = scrollControllerGlobally.position.userScrollDirection ==
        ScrollDirection.reverse;
  }

  void refreshHeader({
    required int index,
    required bool visible,
    int? lastIndex,
  }) {
    final headerValue = headerNotifier.value;
    final headerTitle = headerValue?.index ?? index;
    final headerVisible = headerValue?.visible ?? false;
    final condition =
        headerTitle != index || lastIndex != null || headerVisible != visible;
    if (condition) {
      Future.microtask(
        () {
          final condition2 = (!visible && lastIndex != null);
          if (condition2) {
            headerNotifier.value =
                MyHeaderModel(index: lastIndex!, visible: true);
          } else {
            headerNotifier.value = MyHeaderModel(index: index, visible: true);
          }
        },
      );
    }
  }
}

final products = List.generate(
  6,
  (pI) => ProductModel(
      image: 'https://source.unsplash.com/random/$pI',
      price: 'price $pI 000',
      id: pI,
      name: 'Product $pI',
      description: 'Description of P $pI'),
);
