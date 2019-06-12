import 'package:flutter/material.dart';

class ColoredTabBar extends Container implements PreferredSizeWidget {

  final Color color;
  final TabBar tabBar;

  ColoredTabBar({
    this.color,
    this.tabBar,
  });

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) => Container(
    color: color,
    child: tabBar,
    foregroundDecoration: BoxDecoration(
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          spreadRadius: 1,
          offset: Offset(0, 2),
        ),
      ],
    ),
  );

}