import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_prefs.g.dart';

/// Local database.
@Riverpod(keepAlive: true)
SharedPreferencesAsync sharedPref(Ref ref) {
  return SharedPreferencesAsync();
}
