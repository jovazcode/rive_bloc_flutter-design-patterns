import 'package:flutter/services.dart' show rootBundle;
import 'package:rive_bloc/rive_bloc.dart';

import '../../constants/constants.dart';

// Migrated:
// @riverpod
// MarkdownRepository markdownRepository(_) => const MarkdownRepository();
final markdownRepositoryProvider =
    RiveBlocProvider.finalValue(() => const MarkdownRepository());

// Migrated:
// @riverpod
// Future<String> markdown(MarkdownRef ref, String id) {
//   return ref.watch(markdownRepositoryProvider).get(id);
// }
final markdownProvider = RiveBlocProvider.async(
  /// An async provider is used here because the repository is an async
  /// function which value is not immediately available.
  ///
  /// The returned type of the async function is a `Future` of the value that
  /// will be provided by the provider.
  ///
  /// The provider will automatically handle the loading, and error or data
  /// states through the `AsyncValue` class.
  ///
  /// The `args` parameter is used to pass the required ID of the design pattern
  /// to fetch.
  () => AsyncCubit<String>(
    (ref, args) async {
      final id = args.get<String?>('id', null);
      assert(id != null, 'Design pattern ID is required');

      return ref.read(markdownRepositoryProvider).get(id!);
    },
  ),
);

class MarkdownRepository {
  const MarkdownRepository();

  Future<String> get(String designPatternId) async {
    final path = '${AssetConstants.markdownPath}$designPatternId.md';
    final markdownString = await rootBundle.loadString(path);

    return markdownString;
  }
}
