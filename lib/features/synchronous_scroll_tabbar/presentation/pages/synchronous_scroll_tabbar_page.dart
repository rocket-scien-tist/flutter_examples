import 'package:flutter/material.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/controller/scroll_controller.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/background_sliver.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/list_item_header_sliver.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/my_header_title.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/sliver_body_items.dart';
import 'package:flutter_examples/features/synchronous_scroll_tabbar/presentation/widgets/sliver_header_data.dart';
import 'package:flutter_examples/utils/delete_it/colored_print.dart';

class SynchronousScrollTabBarPage extends StatefulWidget {
  const SynchronousScrollTabBarPage({super.key});

  @override
  State<SynchronousScrollTabBarPage> createState() =>
      _SynchronousScrollTabBarPageState();
}

class _SynchronousScrollTabBarPageState
    extends State<SynchronousScrollTabBarPage> {
  late SliverScrollController bloc;

  @override
  void initState() {
    bloc = SliverScrollController()..init();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        radius: const Radius.circular(8),
        notificationPredicate: (scroll) {
          bloc.valueScroll.value = scroll.metrics.extentInside;
          return true;
        },
        child: ValueListenableBuilder(
            valueListenable: bloc.globalOffsetValue,
            builder: (context, double valueCurrentScroll, snapshot) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                controller: bloc.scrollControllerGlobally,
                slivers: [
                  _FlexibleSpaceBarHeader(
                    valueScroll: valueCurrentScroll,
                    bloc: bloc,
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _HeaderSliver(bloc: bloc),
                  ),
                  for (int i = 0; i < bloc.listCategory.length; i++) ...[
                    SliverPersistentHeader(
                      delegate: MyHeaderTitle(
                        onHeaderChanged: (visible) {
                          final lastIndex = i > 0 ? i - 1 : null;
                          coloredPrint('refresh header by condition that:',
                              'index: $i, visible: $visible, lastIndex: $lastIndex');
                          bloc.refreshHeader(
                            index: i,
                            visible: visible,
                            lastIndex: lastIndex,
                          );
                        },
                        title: bloc.listCategory[i].name,
                      ),
                    ),
                    SliverBodyItems(
                      listItems: bloc.listCategory[i].products,
                    ),
                  ],
                ],
              );
            }),
      ),
    );
  }
}

class _FlexibleSpaceBarHeader extends StatelessWidget {
  final double valueScroll;
  final SliverScrollController bloc;

  const _FlexibleSpaceBarHeader(
      {required this.valueScroll, required this.bloc});

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      stretch: true,
      expandedHeight: 250,
      pinned: valueScroll < 90,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            const BackgroundSliver(),
            Positioned(
              right: 10,
              top: (sizeHeight + 20) - bloc.valueScroll.value,
              child: const Icon(
                Icons.favorite,
                size: 30,
              ),
            ),
            Positioned(
              left: 10,
              top: (sizeHeight + 20) - bloc.valueScroll.value,
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _maxHeaderExtend = 100.0;

class _HeaderSliver extends SliverPersistentHeaderDelegate {
  final SliverScrollController bloc;

  _HeaderSliver({required this.bloc});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percent = shrinkOffset / _maxHeaderExtend;
    bloc.visibleHeader.value = percent > .1;
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: _maxHeaderExtend,
            color: Colors.blue,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      AnimatedOpacity(
                          opacity: percent > .1 ? 1 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: const Icon(Icons.arrow_back)),
                      AnimatedSlide(
                        duration: const Duration(milliseconds: 300),
                        offset: Offset(percent < .1 ? -.18 : .1, 0),
                        curve: Curves.easeIn,
                        child: const Text(
                          'Kavsoft Bakery',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: percent > .1
                          ? ListItemHeaderSliver(bloc: bloc)
                          : const SliverHeaderData()),
                )
              ],
            ),
          ),
        ),
        if (percent > .1)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: percent > .1
                  ? Container(
                      height: 2,
                      color: Colors.red,
                    )
                  : null,
            ),
          ),
      ],
    );
  }

  @override
  double get maxExtent => _maxHeaderExtend;

  @override
  double get minExtent => _maxHeaderExtend;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
