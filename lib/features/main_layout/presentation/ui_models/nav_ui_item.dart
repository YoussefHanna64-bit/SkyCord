import 'package:flutter/material.dart';

class NavUIItem {
  final IconData icon;
  final String label;
  final Widget route;

  NavUIItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
