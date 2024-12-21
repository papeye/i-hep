import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ihep/views/home_screen/home_screen.dart';
import 'package:ihep/views/paper_screen/paper_screen.dart';

final router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (_, __) => const HomeScreen(HomeScreenTab.dashboard),
      routes: [
        GoRoute(
          path: 'paper:id',
          name: 'paperDashboard',
          builder: (_, state) {
            final paperId = state.pathParameters['id']!;

            return PaperScreen(paperId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/list',
      name: 'list',
      builder: (_, __) => const HomeScreen(HomeScreenTab.list),
      routes: [
        GoRoute(
          path: 'paper:id',
          name: 'paperList',
          builder: (_, state) {
            final paperId = state.pathParameters['id']!;

            return PaperScreen(paperId);
          },
        ),
      ],
    ),
  ],
);

extension Navigator on BuildContext {
  void goList() => router.goNamed('list');
  void goDashboard() => router.goNamed('home');

  void goPaperList(String id) =>
      router.goNamed('paperList', pathParameters: {'id': id});

  void goPaperDashboard(String id) =>
      router.goNamed('paperDashboard', pathParameters: {'id': id});
}
