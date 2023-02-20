import 'package:flutter/material.dart';

import 'package:flutter_app_camera/widgets/my_bottom_navigation_bar.dart';
import 'package:flutter_app_camera/widgets/my_tab_bar_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final titles = ['Camera preview', 'Images gallery'];
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabBars.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  void onTapBottomNavigationBar(index) {
    setState(() {
      _tabController.index = index;
      _currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(titles[_currentTabIndex]),
        centerTitle: true,
      ),
      body: MyTabBarView(tabController: _tabController),
      bottomNavigationBar: MyBottomNavigationBar(
        tabController: _tabController,
        currentTabIndex: _currentTabIndex,
        onTap: onTapBottomNavigationBar,
      ),
    );
  }
}
