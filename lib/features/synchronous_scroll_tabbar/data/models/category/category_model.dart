import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/product/product_model.dart';

class CategoryModel extends Equatable {
  final String name;
  final int id;
  final List<ProductModel> products;
  final GlobalKey globalKey;

  const CategoryModel({
    this.id = -1,
    this.name = '',
    this.products = const [],
    required this.globalKey,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        products,
        globalKey,
      ];
}
