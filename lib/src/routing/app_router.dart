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
  about,
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
          // Placeholder
          return const HudOverlay(child: HomeScreen());
        },
        routes: [],
      ),
      GoRoute(
        path: '/about',
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
