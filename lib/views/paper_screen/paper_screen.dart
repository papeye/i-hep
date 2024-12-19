import 'package:flutter/material.dart';
import 'package:ihep/models/paper.dart';

class PaperScreen extends StatelessWidget {
  const PaperScreen(this.paper, {super.key});

  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Paper ID: ${paper.id}'),
            Text('Created: ${paper.created}'),
          ],
        ),
      ),
    );
  }
}
