import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rive_bloc/rive_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';
import 'data/repositories/design_pattern_categories_repository.dart';
import 'data/repositories/markdown_repository.dart';
import 'navigation/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  setPathUrlStrategy();

  runApp(
    RiveBlocScope(
      providers: [
        designPatternCategoriesRepositoryProvider,
        designPatternCategoriesProvider,
        designPatternProvider,
        markdownRepositoryProvider,
        markdownProvider,
        routerProvider,
      ],
      child: const App(),
    ),
  );
}
