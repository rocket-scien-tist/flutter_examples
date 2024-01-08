import 'package:flutter/material.dart';

const headerTitle = 80.0;

typedef OnHeaderChanged = void Function(bool visible);

class MyHeaderTitle extends SliverPersistentHeaderDelegate {
  final OnHeaderChanged onHeaderChanged;
  final String title;

  const MyHeaderTitle({required this.onHeaderChanged, required this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    onHeaderChanged(shrinkOffset > 0);

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => headerTitle;

  @override
  double get minExtent => headerTitle;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
