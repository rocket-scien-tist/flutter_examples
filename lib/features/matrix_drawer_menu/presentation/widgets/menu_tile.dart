import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback? onPressed;

  const MenuTile({
    super.key,
    required this.title,
    required this.iconData,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: ListTileStyle.drawer,
      onTap: onPressed,
      leading: Icon(
        iconData,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
