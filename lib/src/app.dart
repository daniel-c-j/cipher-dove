import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/_constants.dart';
import 'core/_core.dart';
import 'routing/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final brightness = ref.watch(platformBrightnessProvider);

    // Force removal of splash screen.
    FlutterNativeSplash.remove();

    return MaterialApp.router(
      title: AppInfo.TITLE,
      restorationScopeId: "app",
      onGenerateTitle: (context) => AppInfo.TITLE,
      debugShowCheckedModeBanner: false,
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
      color: (brightness == Brightness.light) ? Colors.white : Colors.black,
      themeMode: (brightness == Brightness.light) ? ThemeMode.light : ThemeMode.dark,
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//  TODO When using easy_localization, these are not needed.
      locale: Locale('en', 'US'),
      supportedLocales: [
        ...WidgetsBinding.instance.platformDispatcher.locales,
        const Locale('en' 'US'),
      ],
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
      routerConfig: goRouter,
      // routeInformationParser: goRouter.routeInformationParser,
      // routeInformationProvider: goRouter.routeInformationProvider,
//
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//
    );
  }
}
