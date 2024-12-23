import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ihep/blocs/paper_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
import 'package:ihep/models/paper.dart';
import 'package:ihep/utils/spaced.dart';

class PaperScreen extends HookWidget {
  const PaperScreen(this.paperId, {super.key});

  final String paperId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(paperId),
        leading: IconButton(
          onPressed: context.pop,
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _PaperScreenBody(paperId),
    );
  }
}

class _PaperScreenBody extends HookWidget {
  const _PaperScreenBody(this.paperId);

  final String paperId;

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc(
      () => PaperBloc(papersRepo: context.read())
        ..add(PaperFetchRequested(id: paperId)),
    );
    final state = useBlocState(bloc);

    return Center(
      child: switch (state) {
        PaperFetchInitial() ||
        PaperFetchLoading() =>
          const CircularProgressIndicator(),
        PaperFetchFailure(:final error) => Text('Error: $error'),
        PaperFetchSuccess(:final paper) => _PaperScreenSuccess(paper),
      },
    );
  }
}

class _PaperScreenSuccess extends StatelessWidget {
  const _PaperScreenSuccess(this.paper);

  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Wrap(
          children: [
            Text(
              paper.title,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 8),
            if (paper.metadata.inspireCategories.isNotEmpty)
              Text('[${paper.metadata.inspireCategories.join('; ')}]'),
          ],
        ),
        Text(paper.metadata.authors.map((e) => e.fullName).join('; ')),
        if (paper.metadata.dois.isNotEmpty)
          Text.rich(
            TextSpan(
              text: 'DOI: ',
              children: [
                TextSpan(text: paper.metadata.dois.first),
              ],
            ),
          ),
        if (paper.metadata.journalTitle.isNotEmpty)
          Text(paper.metadata.journalTitle),
        if (paper.metadata.abstracts.isNotEmpty)
          Text(paper.metadata.abstracts.first),
      ].spaced(16),
    );
  }
}
