import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/dashboard_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
import 'package:ihep/router.dart';
import 'package:ihep/shared/paper_data_tile.dart';
import 'package:ihep/utils/spaced.dart';

class DashboardView extends HookWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = useBloc(
      () => DashboardBloc(papersRepo: context.read())
        ..add(const DashboardRequested()),
    );
    final state = useBlocState(bloc);

    return Center(
      child: switch (state) {
        DashboardInitial() ||
        DashboardLoading() =>
          const CircularProgressIndicator(),
        DashboardFailure(:final error) => Text('Error: $error'),
        DashboardSuccess(:final data) => _DashboardViewBody(data),
      },
    );
  }
}

class _DashboardViewBody extends StatelessWidget {
  const _DashboardViewBody(this.data);

  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('IHEP databse contains astonishing amount of'),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleWithNumber(
                      title: 'papers',
                      number: data.totalPapersCount,
                    ),
                    _TitleWithNumber(
                      title: 'authors',
                      number: data.totalAuthorsCount,
                    ),
                    _TitleWithNumber(
                      title: 'institutions',
                      number: data.totalInstitutionsCount,
                    ),
                    _TitleWithNumber(
                      title: 'conferences',
                      number: data.totalConferencesCount,
                    ),
                  ].spaced(8),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          'Top cited papers',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 16),
        for (final paper in data.topCited) ...[
          SizedBox(
            width: 400,
            child: PaperDataTile(
              paper,
              onTap: (paper) => context.goPaperDashboard(paper.id),
              showCitations: true,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _TitleWithNumber extends StatelessWidget {
  const _TitleWithNumber({
    required this.title,
    required this.number,
    super.key,
  });

  final String title;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _Bullet(),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$number',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' '),
              TextSpan(text: title),
            ],
          ),
        ),
      ],
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet({super.key});

  static const _size = 6.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.deepPurple,
      ),
    );
  }
}
