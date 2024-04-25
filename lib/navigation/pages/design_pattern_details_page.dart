import 'package:flutter/material.dart';
import 'package:rive_bloc/rive_bloc.dart';

import '../../constants/constants.dart';
import '../../data/repositories/design_pattern_categories_repository.dart';
import '../../modules/design_pattern_details/layouts/layouts.dart';
import '../../themes.dart';

class DesignPatternDetailsPage extends RiveBlocWidget {
  const DesignPatternDetailsPage({
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context, RiveBlocRef ref) {
    final designPattern =
        ref.watch(designPatternProvider(ref, Args({'id': id}))).state;

    return designPattern.when(
      data: (pattern) => LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > LayoutConstants.screenDesktop) {
            return SinglePageLayout(designPattern: pattern);
          }

          return TabsLayout(designPattern: pattern);
        },
      ),
      loading: () => Center(
        child: CircularProgressIndicator(
          backgroundColor: lightBackgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.black.withOpacity(0.65),
          ),
        ),
      ),
      error: (_, __) => Center(
        child: Text(
          'Welcome to the Dart side...',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
