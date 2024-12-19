import 'package:go_router/go_router.dart';
import 'package:ihep/views/home_screen/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
