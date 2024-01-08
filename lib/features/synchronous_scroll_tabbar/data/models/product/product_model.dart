import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String name;
  final String description;
  final String price;
  final String image;

  const ProductModel({
    this.id = -1,
    this.name = '',
    this.description = '',
    this.price = '',
    this.image = '',
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        image,
      ];
}
