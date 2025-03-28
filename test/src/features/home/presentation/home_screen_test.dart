import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/features/about/presentation/about_screen.dart';
import 'package:cipher_dove/src/features/cipher/presentation/algorithm_selection_screen.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selected.dart';
import 'package:cipher_dove/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../home_robot.dart';

void main() {
  const dummyTextInput = "DUMMY";
  const dummySecretTextInput = "DUMMY-SECRET";

  // * Note: All tests are wrapped with `runAsync` to prevent this error:
  // * A Timer is still pending even after the widget tree was disposed.

  testWidgets('''
    Given in Homescreen,
    When Homescreen is rendered,
    Then layout should be correct.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));
      await r.pumpHomeScreen(container);
      r.expectAppbarTitle();
      r.expectAboutIconButton();
      r.expectThemeIconButton();

      r.expectInputTitle();
      r.expectInputField();
      // Cipher algorithm is AES which is symmetric and require secretkey
      r.expectInputPassField();
      r.expectCensorButton();
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

  testWidgets('''
    Given Homescreen is rendered,
    When about button is tapped,
    Then screen should change into AboutScreen.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      await r.tapAboutIconButton();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(AboutScreen), findsOneWidget);
    });
  });

  testWidgets('''
    Given Homescreen is rendered,
    When changeTheme button is tapped,
    Then app theme should change accordingly.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.setBool(DBKeys.BRIGHTNESS_LIGHT, any())).thenAnswer((_) async => Future.value());
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      // Initial
      await r.pumpHomeScreen(container);
      expect(container.read(platformBrightnessProvider), Brightness.light);
      expect(r.themeBrightness, Brightness.light);

      await r.tapThemeIconButton();
      expect(container.read(platformBrightnessProvider), Brightness.dark);
      expect(r.themeBrightness, Brightness.dark);

      await r.tapThemeIconButton();
      expect(container.read(platformBrightnessProvider), Brightness.light);
      expect(r.themeBrightness, Brightness.light);
    });
  });

  testWidgets('''
    Given InputTextField is empty,
    When inserting text and/or emptying text,
    Then clearInputButton should appear accordingly.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      r.expectNoClearInputButton(); // Initial empty input

      await r.tapInputField();
      r.expectNoClearInputButton();

      await r.enterTextInputField(dummyTextInput);
      r.expectClearInputButton();

      await r.enterTextInputField("");
      r.expectNoClearInputButton();
    });
  });

  testWidgets('''
    Given inputTextField is not empty,
    When clearInputButton is tapped,
    Then input is empty,
    And clearInputButton disappear.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      r.expectNoClearInputButton(); // Initial empty input

      await r.enterTextInputField(dummyTextInput);
      r.expectClearInputButton();

      await r.tapClearInputButton();
      r.expectInputField(content: "", tester: tester);
      r.expectNoClearInputButton();
    });
  });

  testWidgets('''
    Given inputSecretField exist in a default symmetric operation,
    When typing text,
    Then input is by default obscure,
    And can be un-obscured.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      r.expectInputPassField();
      r.expectCensorButton();

      await r.enterInputPassField(dummyTextInput);
      r.expectInputPassField(content: dummyTextInput, isObscure: true, tester: tester);

      await r.tapCensorButton();
      r.expectInputPassField(content: dummyTextInput, isObscure: false, tester: tester);

      await r.tapCensorButton();
      r.expectInputPassField(content: dummyTextInput, isObscure: true, tester: tester);
    });
  });

  testWidgets('''
    Given cipher operation switch is rendered in a default symmetric operation,
    When selecting either one,
    Then switch should be selected.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      r.expectEncryptSwitch(isActive: true, tester: tester); // Init
      r.expectDecryptSwitch(isActive: false, tester: tester);

      await r.tapDecryptSwitch();
      r.expectDecryptSwitch(isActive: true, tester: tester);
      r.expectEncryptSwitch(isActive: false, tester: tester);

      await r.tapEncryptSwitch();
      r.expectEncryptSwitch(isActive: true, tester: tester);
      r.expectDecryptSwitch(isActive: false, tester: tester);
    });
  });

  testWidgets('''
    Given selected algorithm preview widget is rendered,
    When tapping the widget,
    Then user redirected to algorithmSelection screen.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      await r.tapSelectedAlgorithmButton();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(AlgorithmSelectionScreen), findsOneWidget);
    });
  });

  testWidgets('''
    Given selected algorithm preview widget is rendered,
    When tapping the widget,
    Then user redirected to algorithmSelection screen.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = HomeRobot(tester);
      final pref = MockSharedPreferences();
      final container = r.makeProviderContainer(pref);
      when(() => pref.getBool(DBKeys.BRIGHTNESS_LIGHT)).thenAnswer((_) async => Future.value(true));
      when(() => pref.getInt(DBKeys.CIPHER_ALGORITHM_INDEX)).thenAnswer((_) async => Future.value(0));

      await r.pumpHomeScreen(container);
      await r.tapSelectedAlgorithmButton();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(AlgorithmSelectionScreen), findsOneWidget);
    });
  });
}
