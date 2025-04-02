import 'package:cipher_dove/src/common_widgets/hud_overlay.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/features/about/presentation/about_screen.dart';
import 'package:cipher_dove/src/features/cipher/presentation/algorithm_selection_screen.dart';
import 'package:cipher_dove/src/features/cipher/presentation/cipher_output_controller.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_screen_output.dart';
import 'package:cipher_dove/src/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mocks.dart';
import '../../../../robot.dart';

void main() {
  const dummyTextInput = "DUMMY";
  const dummySecretTextInput = "DUMMY-SECRET";

  late ProviderContainer container;

  setUp(() {
    final cipherOutput = MockCipherOutputController();
    container = ProviderContainer(overrides: [
      cipherOutputControllerProvider.overrideWith(() => cipherOutput),
    ]);
  });

  tearDown(() {
    container.dispose();
  });

  // * Note: All tests are wrapped with `runAsync` to prevent this error:
  // * A Timer is still pending even after the widget tree was disposed.

  testWidgets('''
    Given in Homescreen,
    When Homescreen is rendered,
    Then layout should be correct.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);
      await r.home.expectLayoutIsCorrectByDefault();
    });
  });

  testWidgets('''
    Given Homescreen is rendered,
    When about button is tapped,
    Then screen should change into AboutScreen.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      await r.home.tapAboutIconButton();

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
      final r = Robot(tester);
      await r.pumpApp(container: container);

      // Initial
      expect(container.read(platformBrightnessProvider), Brightness.light);

      await r.home.tapThemeIconButton();
      expect(container.read(platformBrightnessProvider), Brightness.dark);

      await r.home.tapThemeIconButton();
      expect(container.read(platformBrightnessProvider), Brightness.light);
    });
  });

  testWidgets('''
    Given InputTextField is empty,
    When inserting text and/or emptying text,
    Then clearInputButton should appear accordingly.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      // Initial empty input
      r.home.expectNoClearInputButton();

      await r.home.tapInputField();
      r.home.expectNoClearInputButton();

      await r.home.enterTextInputField(dummyTextInput);
      r.home.expectClearInputButton();

      await r.home.enterTextInputField("");
      r.home.expectNoClearInputButton();
    });
  });

  testWidgets('''
    Given inputTextField is not empty,
    When clearInputButton is tapped,
    Then input is empty,
    And clearInputButton disappear.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      r.home.expectNoClearInputButton(); // Initial empty input

      await r.home.enterTextInputField(dummyTextInput);
      r.home.expectClearInputButton();

      await r.home.tapClearInputButton();
      r.home.expectInputField(content: "", tester: tester);
      r.home.expectNoClearInputButton();
    });
  });

  testWidgets('''
    Given inputSecretField exist in a default symmetric operation,
    When typing text,
    Then input is by default obscure,
    And can be un-obscured.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      r.home.expectInputPassField();
      r.home.expectCensorButton();

      await r.home.enterInputPassField(dummyTextInput);
      r.home.expectInputPassField(content: dummyTextInput, isObscure: true, tester: tester);

      await r.home.tapCensorButton();
      r.home.expectInputPassField(content: dummyTextInput, isObscure: false, tester: tester);

      await r.home.tapCensorButton();
      r.home.expectInputPassField(content: dummyTextInput, isObscure: true, tester: tester);
    });
  });

  testWidgets('''
    Given cipher operation switch is rendered in a default symmetric operation,
    When selecting either one,
    Then switch should be selected.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      r.home.expectEncryptSwitch(isActive: true, tester: tester); // Init
      r.home.expectDecryptSwitch(isActive: false, tester: tester);

      await r.home.tapDecryptSwitch();
      r.home.expectDecryptSwitch(isActive: true, tester: tester);
      r.home.expectEncryptSwitch(isActive: false, tester: tester);

      await r.home.tapEncryptSwitch();
      r.home.expectEncryptSwitch(isActive: true, tester: tester);
      r.home.expectDecryptSwitch(isActive: false, tester: tester);
    });
  });

  testWidgets('''
    Given selected algorithm preview widget is rendered,
    When tapping the widget,
    Then user redirected to algorithmSelection screen.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      await r.home.tapSelectedAlgorithmButton();

      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(AlgorithmSelectionScreen), findsOneWidget);
    });
  });

  testWidgets('''
    Given process button is rendered and input is empty,
    When tapping the button,
    Then error snackbar appears.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      await r.home.tapProcessButton();
      r.home.expectEmptyInputErrorSnackbar();
    });
  });

  testWidgets('''
    Given process button is rendered and input is not empty,
    When tapping the button,
    Then Head-Up Display should appear for a moment, and disappear.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      await r.home.enterTextInputField(dummyTextInput);
      await r.home.enterInputPassField(dummySecretTextInput);
      expect(container.read(showHudOverlayProvider), isFalse); // Init

      final states = [];
      container.listen(showHudOverlayProvider, (previous, next) {
        states.add(next);
      }, fireImmediately: true);

      await r.home.tapProcessButton();
      expect(states, const [false, true, false]); // HUD hides, HUD shows, HUD hides again.
    });
  });

  testWidgets('''
    Given outputTextField is rendered and is empty,
    When entering text,
    Then text should not appear since the textfield is read-only.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      await r.pumpApp(container: container);

      await r.home.enterOutputField(dummySecretTextInput);
      r.home.expectOutputField(content: '', tester: tester);
    });
  });

  testWidgets('''
    Given outputTextField is rendered and is empty, 
    When content exist,
    Then text should appear along-side with swap buttons and clearOutput button, vice-versa.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      readOnlyOutputField = false; // Before pumping
      await r.pumpApp(container: container);

      r.home.expectNoSwapButton();
      r.home.expectNoClearOutputButton();

      await r.home.enterOutputField(dummySecretTextInput);
      r.home.expectOutputField(content: dummySecretTextInput, tester: tester);
      r.home.expectSwapButton();
      r.home.expectClearOutputButton();

      await r.home.enterOutputField("");
      r.home.expectOutputField(content: "", tester: tester);
      r.home.expectNoSwapButton();
      r.home.expectNoClearOutputButton();
    });
  });

  testWidgets('''
    Given outputTextField has content,
    When widget is tapped,
    Then output copied feedback snackbar should appear.
  ''', (tester) async {
    await tester.runAsync(() async {
      final r = Robot(tester);
      readOnlyOutputField = false; // Before pumping
      await r.pumpApp(container: container);

      await r.home.enterOutputField(dummySecretTextInput);
      r.home.expectOutputField(content: dummySecretTextInput, tester: tester);

      await r.home.tapOutputField();
      r.home.expectOutputCopiedSnackbar();
    });
  });
}
