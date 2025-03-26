// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internetConnectionHash() =>
    r'97ac2700b7886a7909385e8ec534af8523d4f0f4';

/// See also [internetConnection].
@ProviderFor(internetConnection)
final internetConnectionProvider = Provider<InternetConnection>.internal(
  internetConnection,
  name: r'internetConnectionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$internetConnectionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InternetConnectionRef = ProviderRef<InternetConnection>;
String _$connectivityNotifierHash() =>
    r'0dcd578fcb85f21e66359d2914941160b1ba35f1';

/// Watching this will cause the widget to rebuild based on the internet connectivity status.
///
/// Copied from [ConnectivityNotifier].
@ProviderFor(ConnectivityNotifier)
final connectivityNotifierProvider =
    NotifierProvider<ConnectivityNotifier, bool>.internal(
  ConnectivityNotifier.new,
  name: r'connectivityNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$connectivityNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConnectivityNotifier = Notifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
