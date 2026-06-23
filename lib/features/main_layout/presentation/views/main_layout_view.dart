import 'package:flutter/material.dart';
import 'package:sky_cord/features/main_layout/presentation/constants/nav_constants.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavConstants.navItems[pageIndex].route,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).dividerColor,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        items: NavConstants.navItems
            .map(
              (i) => BottomNavigationBarItem(
                icon: Icon(i.icon),
                label: i.label,
              ),
            )
            .toList(),
      ),
    );
  }
}
