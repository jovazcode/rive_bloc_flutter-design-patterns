import 'package:flutter/material.dart';
import 'package:rive_bloc/rive_bloc.dart';

import 'navigation/router.dart';
import 'themes.dart';

class App extends RiveBlocWidget {
  const App();

  @override
  Widget build(context, ref) {
    final router = ref.read(routerProvider);

    return MaterialApp.router(
      title: 'Flutter Design Patterns',
      routerConfig: router,
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}
