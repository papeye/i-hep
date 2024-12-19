import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates and memoizes a resource using [valueBuilder]. On unmount [dispose] is called.
///
/// Preferably not used directly but wrapped in hooks specialized for some [T].
T useDisposableResource<T>({
  required ValueGetter<T> valueBuilder,
  required void Function(T) dispose,
  List<Object?> keys = const <Object>[],
}) {
  final value = useMemoized(valueBuilder, keys);

  useEffect(
    () => () => dispose(value),
    [value],
  );

  return value;
}
