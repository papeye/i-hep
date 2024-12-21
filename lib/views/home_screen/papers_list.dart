import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/papers_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
import 'package:ihep/models/paper_data.dart';
import 'package:ihep/shared/paper_data_tile.dart';

class PapersList extends HookWidget {
  const PapersList({super.key});

  static const _defaultPageSize = 10;

  @override
  Widget build(BuildContext context) {
    final page = useState(1);
    final pageSize = useState(_defaultPageSize);

    final switchSize = useCallback(
      (int size) {
        pageSize.value = size;
        page.value = 1;
      },
      [pageSize, page],
    );

    final nextPage = useCallback(() => page.value = page.value + 1, [page]);
    final previousPage = useCallback(() => page.value = page.value - 1, [page]);

    final bloc = useBloc(() => PapersBloc(papersRepo: context.read()));

    useEffect(
      () {
        bloc.add(
          PapersFetchRequested(size: pageSize.value, page: page.value),
        );
        return null;
      },
      [page.value, pageSize.value],
    );

    final state = useBlocState(bloc);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Column(
        children: [
          const Text('Most recent papers', style: TextStyle(fontSize: 24)),
          _ResultsPerPage(current: pageSize.value, onPressed: switchSize),
          const SizedBox(height: 16),
          Expanded(
            child: switch (state) {
              PapersFetchInitial() =>
                const Center(child: CircularProgressIndicator()),
              PapersFetchLoading() =>
                const Center(child: CircularProgressIndicator()),
              PapersFetchFailure(:final error) =>
                Center(child: Text('Error: $error')),
              PapersFetchSuccess(:final papers) => _PaperListBody(papers),
            },
          ),
          _PageSwitcher(
            page: page.value,
            nextPage: nextPage,
            previousPage: previousPage,
          ),
        ],
      ),
    );
  }
}

class _ResultsPerPage extends StatelessWidget {
  const _ResultsPerPage({
    required this.current,
    required this.onPressed,
  });

  final int current;
  final void Function(int size) onPressed;

  static const _allowedSizes = [10, 20, 50];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Results per page:'),
        for (final size in _allowedSizes)
          TextButton(
            onPressed: () => onPressed(size),
            child: Text(
              '$size',
              style: TextStyle(color: size == current ? Colors.blue : null),
            ),
          ),
      ],
    );
  }
}

class _PageSwitcher extends StatelessWidget {
  const _PageSwitcher({
    required this.page,
    required this.nextPage,
    required this.previousPage,
  });

  final VoidCallback nextPage;
  final VoidCallback previousPage;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (page > 1)
          IconButton(
            onPressed: previousPage,
            icon: const Icon(Icons.arrow_back),
          ),
        Text('Page: $page'),
        IconButton(
          onPressed: nextPage,
          icon: const Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}

class _PaperListBody extends StatelessWidget {
  const _PaperListBody(this.papers);

  final List<PaperData> papers;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: papers.length,
      padding: const EdgeInsets.all(32),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => PaperDataTile(papers[index]),
    );
  }
}
