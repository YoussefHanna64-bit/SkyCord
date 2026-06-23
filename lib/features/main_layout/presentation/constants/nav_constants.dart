import 'package:flutter/material.dart';
import 'package:sky_cord/core/theme/app_icons.dart';
import 'package:sky_cord/features/main_layout/presentation/ui_models/nav_ui_item.dart';

class NavConstants {
  NavConstants._();
  static final List<NavUIItem> navItems = [
    NavUIItem(label: "Chats", icon: AppIcons.chats, route: Placeholder()),
    NavUIItem(label: "Profile", icon: AppIcons.profile, route: Placeholder()),
  ];
}
