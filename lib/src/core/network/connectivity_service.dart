import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

// TODO ref.watch() this in every class that need to call remote.
// TODO watchout for keepAlive:true

/// Watching this will cause the widget to rebuild based on the internet connectivity status.
@Riverpod(keepAlive: true)
class ConnectivityNotifier extends _$ConnectivityNotifier {
  @override
  bool build() {
    ref.onDispose(() {
      _subscription.cancel();
    });

    return false;
  }

  late StreamSubscription<InternetStatus> _subscription;

  ConnectivityNotifier() {
    final internetConnectionChecker = ref.watch(internetConnectionProvider);

    // Continuously listen for internet connection changes.
    _subscription = internetConnectionChecker.onStatusChange.listen(
      (InternetStatus status) {
        // Updates state to true when the condition is true, vice-versa.
        state = status == InternetStatus.connected;
      },
      onError: (error) {
        state = false;
      },
    );
  }
}

@Riverpod(keepAlive: true)
InternetConnection internetConnection(Ref ref) {
  return InternetConnection();
}
