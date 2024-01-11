// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show lerpDouble;

import 'package:flutter/gestures.dart' as gestures;
import 'package:flutter/material.dart' as material;
import 'package:flutter_examples/features/animated_list_view/presentation/widgets/custom_key_subtree.dart';
import 'package:flutter_examples/features/animated_list_view/presentation/widgets/widgets/app_custom_widgets_reorderable_list.dart';
// import 'package:flutter/widgets.dart';

/// A list whose items the user can interactively reorder by dragging.
///
/// {@youtube 560 315 https://www.youtube.com/watch?v=3fB1mxOsqJE}
///
/// This sample shows by dragging the user can reorder the items of the list.
/// The [onReorder] parameter is required and will be called when a child
/// widget is dragged to a new position.
///
/// {@tool dartpad}
///
/// ** See code in examples/api/lib/material/reorderable_list/reorderable_list_view.0.dart **
/// {@end-tool}
///
/// By default, on [TargetPlatformVariant.desktop] platforms each item will
/// have a drag handle added on top of it that will allow the user to grab it
/// to move the item. On [TargetPlatformVariant.mobile], no drag handle will be
/// added, but when the user long presses anywhere on the item it will start
/// moving the item. Displaying drag handles can be controlled with
/// [AppCustomMaterialReorderableListView.buildDefaultDragHandles].
///
/// All list items must have a key.
///
/// This example demonstrates using the [AppCustomMaterialReorderableListView.proxyDecorator] callback
/// to customize the appearance of a list item while it's being dragged.
///
/// {@tool dartpad}
/// While a drag is underway, the widget returned by the [AppCustomMaterialReorderableListView.proxyDecorator]
/// callback serves as a "proxy" (a substitute) for the item in the list. The proxy is
/// created with the original list item as its child. The [AppCustomMaterialReorderableListView.proxyDecorator]
/// callback in this example is similar to the default one except that it changes the
/// proxy item's background color.
///
/// ** See code in examples/api/lib/material/reorderable_list/reorderable_list_view.1.dart **
/// {@end-tool}
///
/// This example demonstrates using the [AppCustomMaterialReorderableListView.proxyDecorator] callback to
/// customize the appearance of a [Card] while it's being dragged.
///
/// {@tool dartpad}
/// The default [proxyDecorator] wraps the dragged item in a [Material] widget and animates
/// its elevation. This example demonstrates how to use the [AppCustomMaterialReorderableListView.proxyDecorator]
/// callback to update the dragged card elevation without inserted a new [Material] widget.
///
/// ** See code in examples/api/lib/material/reorderable_list/reorderable_list_view.2.dart **
/// {@end-tool}
class AppCustomMaterialReorderableListView extends material.StatefulWidget {
  /// Creates a reorderable list from a pre-built list of widgets.
  ///
  /// This constructor is appropriate for lists with a small number of
  /// children because constructing the [List] requires doing work for every
  /// child that could possibly be displayed in the list view instead of just
  /// those children that are actually visible.
  ///
  /// See also:
  ///
  ///   * [ReorderableListView.builder], which allows you to build a reorderable
  ///     list where the items are built as needed when scrolling the list.
  AppCustomMaterialReorderableListView({
    super.key,
    required List<material.Widget> children,
    required this.onReorder,
    this.onReorderStart,
    this.onReorderEnd,
    this.itemExtent,
    this.prototypeItem,
    this.proxyDecorator,
    this.buildDefaultDragHandles = true,
    this.padding,
    this.header,
    this.footer,
    this.scrollDirection = material.Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.anchor = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = gestures.DragStartBehavior.start,
    this.keyboardDismissBehavior =
        material.ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = material.Clip.hardEdge,
    this.autoScrollerVelocityScalar,
  })  : assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        ),
        assert(
          children.every((material.Widget w) => w.key != null),
          'All children of this widget must have a key.',
        ),
        itemBuilder =
            ((material.BuildContext context, int index) => children[index]),
        itemCount = children.length;

  /// Creates a reorderable list from widget items that are created on demand.
  ///
  /// This constructor is appropriate for list views with a large number of
  /// children because the builder is called only for those children
  /// that are actually visible.
  ///
  /// The `itemBuilder` callback will be called only with indices greater than
  /// or equal to zero and less than `itemCount`.
  ///
  /// The `itemBuilder` should always return a non-null widget, and actually
  /// create the widget instances when called. Avoid using a builder that
  /// returns a previously-constructed widget; if the list view's children are
  /// created in advance, or all at once when the [AppCustomMaterialReorderableListView] itself
  /// is created, it is more efficient to use the [AppCustomMaterialReorderableListView]
  /// constructor. Even more efficient, however, is to create the instances
  /// on demand using this constructor's `itemBuilder` callback.
  ///
  /// This example creates a list using the
  /// [ReorderableListView.builder] constructor. Using the [IndexedWidgetBuilder], The
  /// list items are built lazily on demand.
  /// {@tool dartpad}
  ///
  /// ** See code in examples/api/lib/material/reorderable_list/reorderable_list_view.reorderable_list_view_builder.0.dart **
  /// {@end-tool}
  /// See also:
  ///
  ///   * [AppCustomMaterialReorderableListView], which allows you to build a reorderable
  ///     list with all the items passed into the constructor.
  const AppCustomMaterialReorderableListView.builder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.onReorder,
    this.onReorderStart,
    this.onReorderEnd,
    this.itemExtent,
    this.prototypeItem,
    this.proxyDecorator,
    this.buildDefaultDragHandles = true,
    this.padding,
    this.header,
    this.footer,
    this.scrollDirection = material.Axis.vertical,
    this.reverse = false,
    this.scrollController,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.anchor = 0.0,
    this.cacheExtent,
    this.dragStartBehavior = gestures.DragStartBehavior.start,
    this.keyboardDismissBehavior =
        material.ScrollViewKeyboardDismissBehavior.manual,
    this.restorationId,
    this.clipBehavior = material.Clip.hardEdge,
    this.autoScrollerVelocityScalar,
  })  : assert(itemCount >= 0),
        assert(
          itemExtent == null || prototypeItem == null,
          'You can only pass itemExtent or prototypeItem, not both',
        );

  /// {@macro flutter.widgets.reorderable_list.itemBuilder}
  final material.IndexedWidgetBuilder itemBuilder;

  /// {@macro flutter.widgets.reorderable_list.itemCount}
  final int itemCount;

  /// {@macro flutter.widgets.reorderable_list.onReorder}
  final material.ReorderCallback onReorder;

  /// {@macro flutter.widgets.reorderable_list.onReorderStart}
  final void Function(int index)? onReorderStart;

  /// {@macro flutter.widgets.reorderable_list.onReorderEnd}
  final void Function(int index)? onReorderEnd;

  /// {@macro flutter.widgets.reorderable_list.proxyDecorator}
  final material.ReorderItemProxyDecorator? proxyDecorator;

  /// If true: on desktop platforms, a drag handle is stacked over the
  /// center of each item's trailing edge; on mobile platforms, a long
  /// press anywhere on the item starts a drag.
  ///
  /// The default desktop drag handle is just an [Icons.drag_handle]
  /// wrapped by a [ReorderableDragStartListener]. On mobile
  /// platforms, the entire item is wrapped with a
  /// [ReorderableDelayedDragStartListener].
  ///
  /// To change the appearance or the layout of the drag handles, make
  /// this parameter false and wrap each list item, or a widget within
  /// each list item, with [ReorderableDragStartListener] or
  /// [ReorderableDelayedDragStartListener], or a custom subclass
  /// of [ReorderableDragStartListener].
  ///
  /// The following sample specifies `buildDefaultDragHandles: false`, and
  /// uses a [Card] at the leading edge of each item for the item's drag handle.
  ///
  /// {@tool dartpad}
  ///
  ///
  /// ** See code in examples/api/lib/material/reorderable_list/reorderable_list_view.build_default_drag_handles.0.dart **
  ///{@end-tool}
  final bool buildDefaultDragHandles;

  /// {@macro flutter.widgets.reorderable_list.padding}
  final material.EdgeInsets? padding;

  /// A non-reorderable header item to show before the items of the list.
  ///
  /// If null, no header will appear before the list.
  final material.Widget? header;

  /// A non-reorderable footer item to show after the items of the list.
  ///
  /// If null, no footer will appear after the list.
  final material.Widget? footer;

  /// {@macro flutter.widgets.scroll_view.scrollDirection}
  final material.Axis scrollDirection;

  /// {@macro flutter.widgets.scroll_view.reverse}
  final bool reverse;

  /// {@macro flutter.widgets.scroll_view.controller}
  final material.ScrollController? scrollController;

  /// {@macro flutter.widgets.scroll_view.primary}

  /// Defaults to true when [scrollDirection] is [Axis.vertical] and
  /// [scrollController] is null.
  final bool? primary;

  /// {@macro flutter.widgets.scroll_view.physics}
  final material.ScrollPhysics? physics;

  /// {@macro flutter.widgets.scroll_view.shrinkWrap}
  final bool shrinkWrap;

  /// {@macro flutter.widgets.scroll_view.anchor}
  final double anchor;

  /// {@macro flutter.rendering.RenderViewportBase.cacheExtent}
  final double? cacheExtent;

  /// {@macro flutter.widgets.scrollable.dragStartBehavior}
  final gestures.DragStartBehavior dragStartBehavior;

  /// {@macro flutter.widgets.scroll_view.keyboardDismissBehavior}
  ///
  /// The default is [ScrollViewKeyboardDismissBehavior.manual]
  final material.ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  /// {@macro flutter.widgets.scrollable.restorationId}
  final String? restorationId;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final material.Clip clipBehavior;

  /// {@macro flutter.widgets.list_view.itemExtent}
  final double? itemExtent;

  /// {@macro flutter.widgets.list_view.prototypeItem}
  final material.Widget? prototypeItem;

  /// {@macro flutter.widgets.EdgeDraggingAutoScroller.velocityScalar}
  ///
  /// {@macro flutter.widgets.SliverReorderableList.autoScrollerVelocityScalar.default}
  final double? autoScrollerVelocityScalar;

  @override
  material.State<AppCustomMaterialReorderableListView> createState() =>
      _AppCustomMaterialReorderableListViewState();
}

class _AppCustomMaterialReorderableListViewState
    extends material.State<AppCustomMaterialReorderableListView> {
  material.Widget _itemBuilder(material.BuildContext context, int index) {
    // coloredPrint('_itemBuilder', index);
    final material.Widget item = widget.itemBuilder(context, index);
    assert(() {
      if (item.key == null) {
        throw material.FlutterError(
          'Every item of ReorderableListView must have a key.',
        );
      }
      return true;
    }());

    final material.Key itemGlobalKey =
        _ReorderableListViewChildGlobalKey(item.key!, this);

    if (widget.buildDefaultDragHandles) {
      // coloredPrint('if buildDefaultDragHandles $index',
      //     material.Theme.of(context).platform);
      switch (material.Theme.of(context).platform) {
        case material.TargetPlatform.linux:
        case material.TargetPlatform.windows:
        case material.TargetPlatform.macOS:
          switch (widget.scrollDirection) {
            case material.Axis.horizontal:
              return material.Stack(
                key: itemGlobalKey,
                children: <material.Widget>[
                  item,
                  material.Positioned.directional(
                    textDirection: material.Directionality.of(context),
                    start: 0,
                    end: 0,
                    bottom: 8,
                    child: material.Align(
                      alignment: material.AlignmentDirectional.bottomCenter,
                      child: material.ReorderableDragStartListener(
                        index: index,
                        child: const material.Icon(material.Icons.drag_handle),
                      ),
                    ),
                  ),
                ],
              );
            case material.Axis.vertical:
              return material.Container(
                color: material.Colors.red,
                child: material.Stack(
                  key: itemGlobalKey,
                  children: <material.Widget>[
                    item,
                    material.Positioned.directional(
                      textDirection: material.Directionality.of(context),
                      top: 0,
                      bottom: 0,
                      end: 8,
                      child: material.Align(
                        alignment: material.AlignmentDirectional.centerEnd,
                        child: material.ReorderableDragStartListener(
                          index: index,
                          child:
                              const material.Icon(material.Icons.drag_handle),
                        ),
                      ),
                    ),
                  ],
                ),
              );
          }

        case material.TargetPlatform.iOS:
        case material.TargetPlatform.android:
        case material.TargetPlatform.fuchsia:
          return AppCustomReorderableDelayedDragStartListener(
            key: itemGlobalKey,
            index: index,
            child: item,
          );
      }
    }

    return AppCustomKeyedSubtree(
      key: itemGlobalKey,
      child: item,
    );
  }

  material.Widget _proxyDecorator(
      material.Widget child, int index, material.Animation<double> animation) {
    return material.AnimatedBuilder(
      animation: animation,
      builder: (material.BuildContext context, material.Widget? child) {
        final double animValue =
            material.Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return material.Material(
          elevation: elevation,
          color: material.Color(0x00000000),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  material.Widget build(material.BuildContext context) {
    assert(material.debugCheckHasMaterialLocalizations(context));
    assert(material.debugCheckHasOverlay(context));

    // If there is a header or footer we can't just apply the padding to the list,
    // so we break it up into padding for the header, footer and padding for the list.
    final material.EdgeInsets padding =
        widget.padding ?? material.EdgeInsets.zero;
    late final material.EdgeInsets headerPadding;
    late final material.EdgeInsets footerPadding;
    late final material.EdgeInsets listPadding;

    if (widget.header == null && widget.footer == null) {
      headerPadding = material.EdgeInsets.zero;
      footerPadding = material.EdgeInsets.zero;
      listPadding = padding;
    } else if (widget.header != null || widget.footer != null) {
      switch (widget.scrollDirection) {
        case material.Axis.horizontal:
          if (widget.reverse) {
            headerPadding = material.EdgeInsets.fromLTRB(
                0, padding.top, padding.right, padding.bottom);
            listPadding = material.EdgeInsets.fromLTRB(
                widget.footer != null ? 0 : padding.left,
                padding.top,
                widget.header != null ? 0 : padding.right,
                padding.bottom);
            footerPadding = material.EdgeInsets.fromLTRB(
                padding.left, padding.top, 0, padding.bottom);
          } else {
            headerPadding = material.EdgeInsets.fromLTRB(
                padding.left, padding.top, 0, padding.bottom);
            listPadding = material.EdgeInsets.fromLTRB(
                widget.header != null ? 0 : padding.left,
                padding.top,
                widget.footer != null ? 0 : padding.right,
                padding.bottom);
            footerPadding = material.EdgeInsets.fromLTRB(
                0, padding.top, padding.right, padding.bottom);
          }
        case material.Axis.vertical:
          if (widget.reverse) {
            headerPadding = material.EdgeInsets.fromLTRB(
                padding.left, 0, padding.right, padding.bottom);
            listPadding = material.EdgeInsets.fromLTRB(
                padding.left,
                widget.footer != null ? 0 : padding.top,
                padding.right,
                widget.header != null ? 0 : padding.bottom);
            footerPadding = material.EdgeInsets.fromLTRB(
                padding.left, padding.top, padding.right, 0);
          } else {
            headerPadding = material.EdgeInsets.fromLTRB(
                padding.left, padding.top, padding.right, 0);
            listPadding = material.EdgeInsets.fromLTRB(
                padding.left,
                widget.header != null ? 0 : padding.top,
                padding.right,
                widget.footer != null ? 0 : padding.bottom);
            footerPadding = material.EdgeInsets.fromLTRB(
                padding.left, 0, padding.right, padding.bottom);
          }
      }
    }

    return material.CustomScrollView(
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.scrollController,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      anchor: widget.anchor,
      cacheExtent: widget.cacheExtent,
      dragStartBehavior: widget.dragStartBehavior,
      keyboardDismissBehavior: widget.keyboardDismissBehavior,
      restorationId: widget.restorationId,
      clipBehavior: widget.clipBehavior,
      slivers: <material.Widget>[
        if (widget.header != null)
          material.SliverPadding(
            padding: headerPadding,
            sliver: material.SliverToBoxAdapter(child: widget.header),
          ),
        material.SliverPadding(
          padding: listPadding,
          sliver: AppCustomSliverReorderableList(
            itemBuilder: _itemBuilder,
            itemExtent: widget.itemExtent,
            prototypeItem: widget.prototypeItem,
            itemCount: widget.itemCount,
            onReorder: widget.onReorder,
            onReorderStart: widget.onReorderStart,
            onReorderEnd: widget.onReorderEnd,
            proxyDecorator: widget.proxyDecorator ?? _proxyDecorator,
            autoScrollerVelocityScalar: widget.autoScrollerVelocityScalar,
          ),
        ),
        if (widget.footer != null)
          material.SliverPadding(
            padding: footerPadding,
            sliver: material.SliverToBoxAdapter(child: widget.footer),
          ),
      ],
    );
  }
}

// A global key that takes its identity from the object and uses a value of a
// particular type to identify itself.
//
// The difference with GlobalObjectKey is that it uses [==] instead of [identical]
// of the objects used to generate widgets.
@material.optionalTypeArgs
class _ReorderableListViewChildGlobalKey extends material.GlobalObjectKey {
  const _ReorderableListViewChildGlobalKey(this.subKey, this.state)
      : super(subKey);

  final material.Key subKey;
  final material.State state;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _ReorderableListViewChildGlobalKey &&
        other.subKey == subKey &&
        other.state == state;
  }

  @override
  int get hashCode => Object.hash(subKey, state);
}
