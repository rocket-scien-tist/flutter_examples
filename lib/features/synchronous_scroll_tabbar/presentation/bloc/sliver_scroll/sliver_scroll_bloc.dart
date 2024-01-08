import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/category/category_model.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/product/product_model.dart';

part 'sliver_scroll_event.dart';
part 'sliver_scroll_state.dart';

class SliverScrollBloc extends Bloc<SliverScrollEvent, SliverScrollState> {
  final List<CategoryModel> listCategory = List.generate(
    4,
    (cI) => CategoryModel(
      id: cI,
      name: 'Category $cI',
      products: List.generate(
        6,
        (pI) => ProductModel(
            price: 'price $pI 000',
            id: pI,
            name: 'Product $pI C: $cI',
            description: 'Description of P $pI C: $cI'),
      ),
    ),
  );

  SliverScrollBloc() : super(SliverScrollState()) {
    on<SliverScrollEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
