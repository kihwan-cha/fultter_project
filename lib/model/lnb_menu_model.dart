import 'package:flutter/material.dart';

class LnbMenuItem {
  final IconData icon;
  final String title;
  final List<LnbSubMenuItem>? subItems;
  final WidgetBuilder? destination; // 하위 메뉴가 없는 경우 사용

  LnbMenuItem({
    required this.icon,
    required this.title,
    this.subItems,
    this.destination,
  });
}

class LnbSubMenuItem {
  final String title;
  final WidgetBuilder destination;

  LnbSubMenuItem({
    required this.title,
    required this.destination,
  });
}
