import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final List<Widget> tabs;
  final TabController? controller;

  const CustomTabBar({
    super.key,
    required this.onChanged,
    required this.tabs,
    this.controller,
  });

  @override
  CustomTabBarState createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(
          22.5,
        ),
      ),
      child: TabBar(
        onTap: (v) {
          widget.onChanged(v == 0);
        },
        controller: widget.controller ?? _tabController,
        // give the indicator a decoration (color and border radius)
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            22.5,
          ),
          color: Colors.greenAccent,
        ),
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        padding: const EdgeInsets.all(3),
        mouseCursor: MouseCursor.uncontrolled,
        indicatorColor: Colors.redAccent,
        indicatorWeight: 0,
        indicatorSize: TabBarIndicatorSize.tab,

        tabs: widget.tabs,
      ),
    );
  }
}
