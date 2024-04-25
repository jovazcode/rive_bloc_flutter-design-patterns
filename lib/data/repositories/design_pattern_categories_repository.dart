import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:rive_bloc/rive_bloc.dart';

import '../../constants/constants.dart';
import '../models/design_pattern.dart';
import '../models/design_pattern_category.dart';

// Migrated:
// @riverpod
// DesignPatternCategoriesRepository designPatternCategoriesRepository(_) {
//   return const DesignPatternCategoriesRepository();
// }
final designPatternCategoriesRepositoryProvider =

    /// A final value provider is used here because the repository is a
    /// constant value, independant from any other provider.
    ///
    /// So the exposed value can be accessed through [FinalValueProvider.value]
    /// without the need of any `RiveBlocRef`.
    RiveBlocProvider.finalValue(DesignPatternCategoriesRepository.new);

// Migrated:
// @riverpod
// Future<List<DesignPatternCategory>> designPatternCategories(
//   DesignPatternCategoriesRef ref,
// ) {
//   final repository = ref.watch(designPatternCategoriesRepositoryProvider);

//   return repository.get();
// }
final designPatternCategoriesProvider = RiveBlocProvider.async(
  /// An async provider is used here because the repository is an async
  /// function which value is not immediately available.
  ///
  /// The returned type of the async function is a `Future` of the value that
  /// will be provided by the provider.
  ///
  /// The provider will automatically handle the loading, and error or data
  /// states through the `AsyncValue` class.
  () => AsyncCubit<List<DesignPatternCategory>>(
    (ref, args) => ref.read(designPatternCategoriesRepositoryProvider).get(),
  ),
);

// Migrated:
// @riverpod
// Future<DesignPattern> designPattern(DesignPatternRef ref, String id) async {
//   final categories = await ref.watch(designPatternCategoriesProvider.future);

//   return categories
//       .expand((category) => category.patterns)
//       .firstWhere((pattern) => pattern.id == id);
// }
final designPatternProvider = RiveBlocProvider.async(
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
  () => AsyncCubit<DesignPattern>(
    (ref, args) async {
      final id = args.get<String?>('id', null);
      assert(id != null, 'Design pattern ID is required');

      final categories =
          await ref.watch(designPatternCategoriesProvider).future;

      return categories
          .expand((category) => category.patterns)
          .firstWhere((pattern) => pattern.id == id);
    },
  ),
);

class DesignPatternCategoriesRepository {
  const DesignPatternCategoriesRepository();

  Future<List<DesignPatternCategory>> get() async {
    final menuJson = await rootBundle.loadString(
      AssetConstants.designPatternsJsonPath,
    );
    final designPatternCategoryJsonList = json.decode(menuJson) as List;
    final mainMenuSections = designPatternCategoryJsonList
        .map(
          (categoryJson) => DesignPatternCategory.fromJson(
            categoryJson as Map<String, dynamic>,
          ),
        )
        .toList();

    return mainMenuSections;
  }
}
