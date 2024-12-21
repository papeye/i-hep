import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/router.dart';
import 'package:ihep/views/home_screen/dashboard_view.dart';
import 'package:ihep/views/home_screen/papers_list.dart';

class HomeScreen extends HookWidget {
  const HomeScreen(this.initialTab, {super.key});

  final HomeScreenTab initialTab;

  @override
  Widget build(BuildContext context) {
    final tabController =
        useTabController(initialLength: 2, initialIndex: initialTab.index);

    return Scaffold(
      appBar: AppBar(
        title: const Text('IHEP'),
        centerTitle: false,
        bottom: TabBar(
          controller: tabController,
          onTap: (index) => HomeScreenTab.values[index].onTap(context),
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
              HomeScreenTab.dashboard => const DashboardView(),
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

  void onTap(BuildContext context) => switch (this) {
        dashboard => context.goDashboard(),
        list => context.goList(),
      };
}
