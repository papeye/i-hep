import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ihep/models/paper.dart';
import 'package:ihep/views/home_screen/home_screen.dart';
import 'package:ihep/views/paper_screen/paper_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomeScreen(),
    ),
    GoRoute(
      path: '/paper',
      builder: (_, state) {
        final paper = state.extra! as Paper;

        return PaperScreen(paper);
      },
    ),
  ],
);

extension Navigator on BuildContext {
  void goHome() => router.go('/');
  void goPaper(Paper paper) => router.go(
        '/paper',
        extra: paper,
      );
}
