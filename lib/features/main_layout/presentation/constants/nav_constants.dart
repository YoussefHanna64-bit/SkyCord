import 'package:sky_cord/core/theme/app_icons.dart';
import 'package:sky_cord/features/chat/presentation/views/chats_view.dart';
import 'package:sky_cord/features/main_layout/presentation/ui_models/nav_ui_item.dart';
import 'package:sky_cord/features/profile/presentation/views/profile_view.dart';

class NavConstants {
  NavConstants._();
  static final List<NavUIItem> navItems = [
    NavUIItem(label: "Chats", icon: AppIcons.chats, route: ChatsView()),
    NavUIItem(label: "Profile", icon: AppIcons.profile, route: ProfileView()),
  ];
}
