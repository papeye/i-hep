import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/papers_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
import 'package:ihep/models/paper.dart';
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

  static const _defaultPageSize = 10;

  @override
  Widget build(BuildContext context) {
    final page = useState(1);

    final nextPage = useCallback(() => page.value = page.value + 1, [page]);
    final previousPage = useCallback(() => page.value = page.value - 1, [page]);

    final bloc = useBloc(() => PapersBloc(papersRepo: context.read()));

    useEffect(
      () {
        bloc.add(
          PapersFetchRequested(size: _defaultPageSize, page: page.value),
        );
        return null;
      },
      [page.value],
    );

    final state = useBlocState(bloc);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: previousPage,
              icon: const Icon(Icons.arrow_back),
            ),
            Text('Page: ${page.value}'),
            IconButton(
              onPressed: nextPage,
              icon: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        Expanded(
          child: switch (state) {
            final PapersFetchInitial _ =>
              const Center(child: CircularProgressIndicator()),
            final PapersFetchLoading _ =>
              const Center(child: CircularProgressIndicator()),
            final PapersFetchFailure state =>
              Center(child: Text('Error: $state.error')),
            final PapersFetchSuccess state => _PaperListBody(state.papers),
          },
        ),
      ],
    );
  }
}

class _PaperListBody extends StatelessWidget {
  const _PaperListBody(this.papers);

  final List<Paper> papers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: papers.length,
      padding: const EdgeInsets.all(32),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => _PaperTile(papers[index]),
    );
  }
}

class _PaperTile extends StatelessWidget {
  const _PaperTile(this.paper);

  final Paper paper;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      title: Text(paper.metadata.titles.first),
      subtitle: Text(
        paper.metadata.authors.map((e) => e.fullName).join('; '),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
