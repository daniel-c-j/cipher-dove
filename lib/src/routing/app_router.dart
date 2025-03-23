import 'package:cipher_dove/src/features/cipher/presentation/algorithm_selection_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cipher_dove/src/common_widgets/hud_overlay.dart';
import 'package:cipher_dove/src/core/app/navigation.dart';
import 'package:cipher_dove/src/features/home/presentation/home_screen.dart';
import 'package:cipher_dove/src/routing/not_found_screen.dart';

part 'app_router.g.dart';

enum AppRoute {
  home,
  algorithmSelection,
  about;

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
        routes: [],
      ),
      GoRoute(
        path: AppRoute.about.path,
        name: AppRoute.about.name,
        pageBuilder: (context, state) {
          return MaterialPage(
              key: state.pageKey, // Recommended
              fullscreenDialog: true,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
              ));
        },
        routes: [],
      ),
    ],
    errorBuilder: (context, state) {
      return const NotFoundScreen();
    },
  );
}
