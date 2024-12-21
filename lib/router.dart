import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ihep/views/home_screen/home_screen.dart';
import 'package:ihep/views/paper_screen/paper_screen.dart';

final router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/:tab',
      name: 'home',
      builder: (_, state) {
        final tabSegment = state.pathParameters['tab']!;
        final tab = HomeScreenTab.values.firstWhere(
          (e) => e.pathSegment == tabSegment,
        );

        return HomeScreen(tab);
      },
      routes: [
        GoRoute(
          path: 'paper:id',
          name: 'paper',
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
  void goList() => router.goNamed('home', pathParameters: {'tab': 'list'});
  void goDashboard() =>
      router.goNamed('home', pathParameters: {'tab': 'dashboard'});

  void goPaperList(String id) =>
      router.goNamed('paper', pathParameters: {'tab': 'list', 'id': id});

  void goPaperDashboard(String id) =>
      router.goNamed('paper', pathParameters: {'tab': 'dashboard', 'id': id});
}
