import 'package:flutter/material.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/data/models/my_header/my_header_model.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/controller/scroll_controller.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/get_box_offset.dart';

class ListItemHeaderSliver extends StatelessWidget {
  const ListItemHeaderSliver({super.key, required this.bloc});

  final SliverScrollController bloc;

  @override
  Widget build(BuildContext context) {
    final itemsOffsets = bloc.listOffSetItemHeader;
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: NotificationListener<ScrollNotification>(
        onNotification: (v) => true,
        child: ValueListenableBuilder(
          valueListenable: bloc.headerNotifier,
          builder: (context, MyHeaderModel? snapshot, __) {
            return Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 2500),
                      key: UniqueKey(),
                      margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: index == 0 ? Colors.white : null,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        bloc.listCategory[snapshot?.index ?? 0].name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(right: 500
                        // right: size.width - itemsOffsets[itemsOffsets.length - 1],
                        ),
                    controller: bloc.scrollControllerItemHeader,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        bloc.listCategory.length,
                        (index) => GetBoxOffset(
                          offset: ((offset) => itemsOffsets[index] = offset.dx),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            key: UniqueKey(),
                            margin: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              // color: index == snapshot?.index
                              //     ? Colors.white
                              //     : null,
                              // color: index == 0 ? Colors.white : null,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              bloc.listCategory[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                                  // color: index == snapshot?.index
                                  //     ? Colors.black
                                  //     : Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
