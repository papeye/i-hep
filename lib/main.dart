import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihep/repositories/papers_repository.dart';
import 'package:ihep/router.dart';
import 'package:ihep/services/ihep_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => const PapersRepository(apiService: IHepApiService()),
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}
