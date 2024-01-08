import 'package:flutter/material.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/product/product_model.dart';

class SliverBodyItems extends StatelessWidget {
  final List<ProductModel> listItems;

  const SliverBodyItems({super.key, required this.listItems});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = listItems[index];
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.price,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              'https://source.unsplash.com/random/',
                            ),
                          ),
                        ),
                        height: 140,
                        width: 130,
                      ),
                    ],
                  ),
                ),
                if (index == listItems.length - 1) ...[
                  const SizedBox(height: 32),
                  Container(
                    height: .5,
                    color: Colors.white.withOpacity(.3),
                  ),
                ]
              ],
            ),
          );
        },
        childCount: listItems.length,
      ),
    );
  }
}
