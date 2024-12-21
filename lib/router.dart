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
  void goHome() => router.go('/');
  void goPaper(String id) => router.goNamed(
        'paper',
        pathParameters: {'id': id},
      );
}
