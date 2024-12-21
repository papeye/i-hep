import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/dashboard_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TitleWithNumber(
          title: 'Total papers',
          number: data.totalPapersCount,
        ),
        _TitleWithNumber(
          title: 'Total authors',
          number: data.totalAuthorsCount,
        ),
        _TitleWithNumber(
          title: 'Total institutions',
          number: data.totalInstitutionsCount,
        ),
        _TitleWithNumber(
          title: 'Total conferences',
          number: data.totalConferencesCount,
        ),
      ].spaced(8),
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
    return Text.rich(
      TextSpan(
        text: title,
        children: [
          const TextSpan(text: ': '),
          TextSpan(
            text: '$number',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
