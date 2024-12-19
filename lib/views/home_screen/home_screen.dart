import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/views/home_screen/papers_list.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          tabs: [
            for (final tab in HomeScreenTab.values)
              Tab(icon: Icon(tab.iconData)),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          for (final tab in HomeScreenTab.values)
            switch (tab) {
              HomeScreenTab.list => const PapersList(),
              _ => const Center(child: Text('Dashboard')),
            },
        ],
      ),
    );
  }
}

enum HomeScreenTab {
  dashboard,
  list;

  IconData get iconData => switch (this) {
        dashboard => Icons.dashboard,
        list => Icons.list,
      };

  String get pathSegment => switch (this) {
        dashboard => 'dashboard',
        list => 'list',
      };
}
