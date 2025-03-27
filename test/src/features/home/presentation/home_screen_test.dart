import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../home_robot.dart';

void main() {
  testWidgets('Homescreen successfully loaded', (tester) async {
    // * Note: All tests are wrapped with `runAsync` to prevent this error:
    // * A Timer is still pending even after the widget tree was disposed.
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));
      await r.pumpHomeScreen(pref);
      r.expectAppbarTitle();
      r.expectAboutIconButton();
      r.expectThemeIconButton();

      r.expectInputTitle();
      r.expectInputField();
      // Cipher algorithm is AES which is symmetric and require secretkey
      r.expectInputPassField();
      // Since input field is empty by default.
      r.expectNoClearInputButton();

      r.expectEncryptSwitch();
      r.expectDecryptSwitch();

      r.expectOutputTitle();
      r.expectOutputField();
      r.expectNoSwapButton(); // Output is empty
      r.expectNoClearOutputButton(); // Output is empty
    });
  });
}
