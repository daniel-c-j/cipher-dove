import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

// TODO ref.watch() this in every class that need to call remote.
// TODO watchout for keepAlive:true
@Riverpod(keepAlive: true)
class ConnectivityNotifier extends _$ConnectivityNotifier {
  @override
  bool build() {
    ref.onDispose(() {
      _subscription.cancel();
    });

    return false;
  }

  final _internetConnectionChecker = InternetConnection();
  late StreamSubscription<InternetStatus> _subscription;

  ConnectivityNotifier() {
    // Continuously listen for internet connection changes.
    _subscription = _internetConnectionChecker.onStatusChange.listen(
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
