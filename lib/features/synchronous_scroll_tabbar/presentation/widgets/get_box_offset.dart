import 'package:flutter/material.dart';

class GetBoxOffset extends StatefulWidget {
  final Function(Offset offset) offset;

  final Widget child;

  const GetBoxOffset({
    Key? key,
    required this.offset,
    required this.child,
  }) : super(key: key);

  @override
  State<GetBoxOffset> createState() => _GetBoxOffsetState();
}

class _GetBoxOffsetState extends State<GetBoxOffset> {
  late Offset offset;
  GlobalKey widgetKey = GlobalKey<_GetBoxOffsetState>();

  @override
  void didChangeDependencies() {
    // coloredPrint('didChangeDependencies signature: ', widgetKey.currentWidget);
    // widgetKey = GlobalKey<_GetBoxOffsetState>();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant GetBoxOffset oldWidget) {
    // coloredPrint('didUpdateWidget signature',
    //     'old widget key: ${oldWidget.child.key}, new widget key: ${widget.child.key}, ${oldWidget.createState()}');
    // widgetKey = GlobalKey<_GetBoxOffsetState>();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final box = widgetKey.currentContext?.findRenderObject() as RenderBox;
      offset = box.localToGlobal(Offset.zero);
      widget.offset(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: widgetKey,
      child: widget.child,
    );
  }
}
