import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive_bloc/rive_bloc.dart';

import 'pages/pages.dart';

part 'router.g.dart';

// Migrated:
// @riverpod
// GoRouter router(_) => GoRouter(
//       routes: $appRoutes,
//       redirect: (context, state) =>
//           state.location.isEmpty ? const MainMenuRoute().location : null,
//     );
final routerProvider = RiveBlocProvider.finalValue<GoRouter>(
  /// A final value provider is used here because the repository is
  /// independant from any other provider.
  ///
  /// So the exposed value can be accessed through [FinalValueProvider.value]
  /// without the need of any `RiveBlocRef`.
  () => GoRouter(
    routes: $appRoutes,
    redirect: (context, state) =>
        state.location.isEmpty ? const MainMenuRoute().location : null,
  ),
);

@TypedGoRoute<MainMenuRoute>(
  path: '/',
  routes: [
    TypedGoRoute<DesignPatternDetailsRoute>(path: 'pattern/:id'),
  ],
)
@immutable
class MainMenuRoute extends GoRouteData with _CustomTransitionPageMixin {
  const MainMenuRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    const child = MainMenuPage();

    return buildCustomTransitionPage(context, state, child);
  }
}

@immutable
class DesignPatternDetailsRoute extends GoRouteData
    with _CustomTransitionPageMixin {
  const DesignPatternDetailsRoute(this.id);

  final String id;

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final child = DesignPatternDetailsPage(id: id);

    return buildCustomTransitionPage(context, state, child);
  }
}

mixin _CustomTransitionPageMixin on GoRouteData {
  Page<void> buildCustomTransitionPage(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    if (kIsWeb) {
      return CustomTransitionPage(
        key: state.pageKey,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        child: child,
      );
    }

    return MaterialPage(key: state.pageKey, child: child);
  }
}
