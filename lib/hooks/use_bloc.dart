import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ihep/hooks/use_disposable_resource.dart';

/// Provides a [Cubit] or a [Bloc] that is automatically disposed without having
/// to use BlocProvider.
B useBloc<B extends BlocBase<Object?>>(
  B Function() create, [
  List<Object?> keys = const [],
]) {
  return useDisposableResource(
    valueBuilder: create,
    dispose: (bloc) => bloc.close(),
    keys: keys,
  );
}

/// Provides [Cubit]'s or [Bloc]'s current state. Forces [HookWidget] to
/// rebuild on state change.
S useBlocState<S>(BlocBase<S> bloc) {
  return useStream(
    bloc.stream,
    initialData: bloc.state,
    preserveState: false,
  ).data as S;
}

/// Provides a subset of [Cubit]'s or [Bloc]'s current state.
/// Forces [HookWidget] to rebuild on change of the selected subset.
T useBlocStateSelect<S, T>(
  BlocBase<S> bloc,
  T Function(S) selector,
) {
  return useStream(
    bloc.stream.map(selector).distinct(),
    initialData: selector(bloc.state),
    preserveState: false,
  ).data as T;
}
