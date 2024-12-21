import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ihep/views/home_screen/home_screen.dart';
import 'package:ihep/views/paper_screen/paper_screen.dart';

final router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/:pathSegment',
      name: 'home',
      builder: (_, state) {
        final tab = HomeScreenTab.values.firstWhere(
          (e) => state.pathParameters['pathSegment']! == e.pathSegment,
        );

        return HomeScreen(tab);
      },
    ),
    GoRoute(
      path: '/paper/:id',
      name: 'paper',
      builder: (_, state) {
        final paperId = state.pathParameters['id']!;

        return PaperScreen(paperId);
      },
    ),
  ],
);

extension Navigator on BuildContext {
  void goList() =>
      router.goNamed('home', pathParameters: {'pathSegment': 'list'});
  void goDashboard() =>
      router.goNamed('home', pathParameters: {'pathSegment': 'dashboard'});

  void goPaper(String id) => router.goNamed(
        'paper',
        pathParameters: {'id': id},
      );
}
