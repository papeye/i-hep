import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/blocs/dashboard_bloc.dart';
import 'package:ihep/hooks/use_bloc.dart';

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
        DashboardSuccess(:final data) => Column(
            children: [
              Text.rich(
                TextSpan(
                  text: 'Total Papers: ',
                  children: [
                    TextSpan(
                      text: '${data.totalPapersCount}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
      },
    );
  }
}
