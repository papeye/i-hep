import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/papers_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
import 'package:ihep/repositories/papers_repository.dart';
import 'package:ihep/services/ihep_service.dart';

class PapersList extends StatelessWidget {
  const PapersList({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => const PapersRepository(
        apiService: IHepApiService(),
      ),
      child: const _PapersList(),
    );
  }
}

class _PapersList extends HookWidget {
  const _PapersList();

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc(
      () => PapersBloc(
        papersRepo: context.read(),
      )..add(const PapersFetchRequested()),
    );

    final state = useBlocState(bloc);

    return switch (state) {
      final PapersFetchInitial _ =>
        const Center(child: CircularProgressIndicator()),
      final PapersFetchLoading _ =>
        const Center(child: CircularProgressIndicator()),
      final PapersFetchFailure state =>
        Center(child: Text('Error: $state.error')),
      final PapersFetchSuccess state => Center(
          child: ListView.builder(
            itemCount: state.papers.length,
            itemBuilder: (context, index) {
              final paper = state.papers[index];

              return ListTile(
                title: Text(paper.metadata.titles.first),
              );
            },
          ),
        )
    };
  }
}
