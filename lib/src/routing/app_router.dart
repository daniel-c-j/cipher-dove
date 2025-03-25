import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../common_widgets/hud_overlay.dart';
import '../core/_core.dart';
import '../features/about/presentation/about_screen.dart';
import '../features/cipher/presentation/algorithm_selection_screen.dart';
import '../features/home/presentation/home_screen.dart';
import 'not_found_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  algorithmSelection,
  about,
  license,
  unknown;

  const AppRoute();
}

extension AppRouteExtension on AppRoute {
  String get path => "/$name";
}

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  return GoRouter(
    debugLogDiagnostics: !kReleaseMode,
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/',
    redirect: (context, state) {
      // Placeholder
      return;
    },
    routes: [
      GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) {
          return const HudOverlay(child: HomeScreen());
        },
        routes: [],
      ),
      GoRoute(
        path: AppRoute.algorithmSelection.path,
        name: AppRoute.algorithmSelection.name,
        builder: (context, state) {
          return const HudOverlay(child: AlgorithmSelectionScreen());
        },
        onExit: (context, state) {
          // Prevent keyboard suddenly opens when going back to home screen after
          // once focused on one of the textfields.
          FocusScope.of(context).unfocus();
          return true;
        },
        routes: [],
      ),
      GoRoute(
          path: AppRoute.about.path,
          name: AppRoute.about.name,
          builder: (context, state) {
            return const HudOverlay(child: AboutScreen());
          },
          onExit: (context, state) {
            // Prevent keyboard suddenly opens when going back to home screen after
            // once focused on one of the textfields.
            FocusScope.of(context).unfocus();
            return true;
          },
          routes: [
            GoRoute(
              path: AppRoute.license.path,
              name: AppRoute.license.name,
              builder: (context, state) {
                return const LicensePage();
              },
            ),
          ]),
      GoRoute(
        path: "/404",
        name: AppRoute.unknown.name,
        builder: (context, state) {
          return const NotFoundScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return const NotFoundScreen();
    },
  );
}
