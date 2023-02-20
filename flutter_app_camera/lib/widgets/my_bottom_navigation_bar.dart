import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final Icon icon;
  TabItem({required this.title, required this.icon});
}

final List<TabItem> tabBars = [
  TabItem(title: 'Camera', icon: const Icon(Icons.camera)),
  TabItem(title: 'Gallery', icon: const Icon(Icons.image)),
];

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    Key? key,
    required this.tabController,
    required this.currentTabIndex,
    required this.onTap,
  }) : super(key: key);
  final TabController tabController;
  final int currentTabIndex;
  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentTabIndex,
      items: [
        for (final item in tabBars)
          BottomNavigationBarItem(
            label: item.title,
            icon: item.icon,
          )
      ],
    );
  }
}
