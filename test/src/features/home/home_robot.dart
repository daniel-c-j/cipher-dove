// ignore_for_file: depend_on_referenced_packages
import 'package:cipher_dove/src/common_widgets/generic_title.dart';
import 'package:cipher_dove/src/common_widgets/hud_overlay.dart';
import 'package:cipher_dove/src/features/about/presentation/components/about_icon_button.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/algorithm_selected.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/cipher_action_switch.dart';
import 'package:cipher_dove/src/features/cipher/presentation/components/process_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_appbar.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_screen_input.dart';
import 'package:cipher_dove/src/features/home/presentation/components/home_screen_output.dart';
import 'package:cipher_dove/src/features/home/presentation/components/icon_buttons/censor_icon_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/icon_buttons/clear_icon_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/icon_buttons/swap_icon_button.dart';
import 'package:cipher_dove/src/features/home/presentation/components/icon_buttons/theme_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

@visibleForTesting
class HomeRobot {
  HomeRobot(this.tester);
  final WidgetTester tester;

  Future<void> expectLayoutIsCorrectByDefault() async {
    expectAppbarTitle();
    expectAboutIconButton();
    expectThemeIconButton();

    expectInputTitle();
    expectInputField();
    // Cipher algorithm is by default AES which is symmetric and require secretkey
    expectInputPassField(isObscure: true, tester: tester);
    expectCensorButton();
    // Since input field is empty by default.
    expectNoClearInputButton();

    expectEncryptSwitch();
    expectDecryptSwitch();

    expectOutputTitle();
    expectOutputField();
    expectNoSwapButton(); // Output is empty
    expectNoClearOutputButton(); // Output is empty
  }

  void expectAppbarTitle() {
    final title = find.byKey(HomeAppBar.titleKey);
    expect(title, findsOneWidget);
  }

  Finder expectAboutIconButton() {
    final finder = find.byKey(AboutIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> tapAboutIconButton() async {
    final finder = expectAboutIconButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectThemeIconButton() {
    final finder = find.byKey(ThemeIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> tapThemeIconButton() async {
    final finder = expectThemeIconButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void expectInputTitle() {
    final finder = find.byKey(HomeScreenInput.titleKey);
    expect(finder, findsOneWidget);
  }

  Finder expectInputField({String? content, WidgetTester? tester}) {
    final finder = find.byKey(HomeScreenInput.inputFieldKey);
    expect(finder, findsOneWidget);
    if (content != null && tester != null) {
      expect(tester.widget<TextFormField>(finder).controller?.text, content);
    }
    return finder;
  }

  Future<void> tapInputField() async {
    final finder = expectInputField();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> enterTextInputField(String text) async {
    await tester.enterText(expectInputField(), text);
    await tester.pumpAndSettle();
  }

  Finder expectInputPassField({String? content, WidgetTester? tester, bool? isObscure}) {
    final finder = find.byKey(HomeScreenInput.inputPassFieldKey);
    expect(finder, findsOneWidget);
    if (content != null && tester != null) {
      expect(tester.widget<TextFormField>(finder).controller?.text, content);
    }

    if (isObscure != null && tester != null) {
      // Access the EditableText through the TextFormField
      final editableTextFinder = find.descendant(
        of: finder,
        matching: find.byType(EditableText),
      );
      expect(tester.widget<EditableText>(editableTextFinder).obscureText, isObscure);
    }
    return finder;
  }

  Future<void> tapInputPassField() async {
    final finder = expectInputPassField();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> enterInputPassField(String text) async {
    await tester.enterText(expectInputPassField(), text);
    await tester.pumpAndSettle();
  }

  Finder expectClearInputButton() {
    final finder = find.byKey(ClearInputIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  void expectNoClearInputButton() {
    final finder = find.byKey(ClearInputIconButton.buttonKey);
    expect(finder, findsNothing);
  }

  Future<void> tapClearInputButton() async {
    final finder = expectClearInputButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectCensorButton() {
    final finder = find.byKey(CensorIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  Finder expectNoCensorButton() {
    final finder = find.byKey(CensorIconButton.buttonKey);
    expect(finder, findsNothing);
    return finder;
  }

  Future<void> tapCensorButton() async {
    final finder = expectCensorButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectEncryptSwitch({bool? isActive, WidgetTester? tester}) {
    final finder = find.byKey(CipherActionSwitch.encryptActionKey);
    expect(finder, findsOneWidget);
    if (isActive != null && tester != null) {
      expect(tester.widget<GenericTitle>(finder).iconColor, (isActive) ? Colors.white : isNot(Colors.white));
    }
    return finder;
  }

  Future<void> tapEncryptSwitch() async {
    final finder = expectEncryptSwitch();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectDecryptSwitch({bool? isActive, WidgetTester? tester}) {
    final finder = find.byKey(CipherActionSwitch.decryptActionKey);
    expect(finder, findsOneWidget);
    if (isActive != null && tester != null) {
      expect(tester.widget<GenericTitle>(finder).iconColor, (isActive) ? Colors.white : isNot(Colors.white));
    }
    return finder;
  }

  Future<void> tapDecryptSwitch() async {
    final finder = expectDecryptSwitch();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void expectHashDecryptErrorSnackbar() {
    final finder = find.byKey(CipherActionSwitch.hashDecyrptError);
    expect(finder, findsOneWidget);
  }

  Finder expectSelectedAlgorithmButton({String? content, WidgetTester? tester}) {
    final finder = find.byKey(AlgorithmSelected.buttonKey);
    expect(finder, findsOneWidget);
    if (content != null && tester != null) {
      final textFinder = find.descendant(
        of: finder,
        matching: find.byType(Text),
      );
      expect(tester.widget<Text>(textFinder).data, content);
    }
    return finder;
  }

  Future<void> tapSelectedAlgorithmButton() async {
    final finder = expectSelectedAlgorithmButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectProcessButton() {
    final finder = find.byKey(ProcessButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  Future<void> tapProcessButton() async {
    final finder = expectProcessButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void expectEmptyInputErrorSnackbar() {
    final finder = find.byKey(ProcessButton.emptyInputSnackbarKey);
    expect(finder, findsOneWidget);
  }

  void expectOutputTitle() {
    final finder = find.byKey(HomeScreenOutput.titleKey);
    expect(finder, findsOneWidget);
  }

  Finder expectOutputField({String? content, WidgetTester? tester}) {
    final finder = find.byKey(HomeScreenOutput.outputFieldKey);
    expect(finder, findsOneWidget);
    if (content != null && tester != null) {
      expect(tester.widget<TextFormField>(finder).controller?.text, content);
    }
    return finder;
  }

  Future<void> tapOutputField() async {
    final finder = expectOutputField();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> enterOutputField(String text) async {
    await tester.enterText(expectOutputField(), text);
    await tester.pumpAndSettle();
  }

  void expectOutputCopiedSnackbar() {
    final finder = find.byKey(HomeScreenOutput.outputFieldSnackbarCopiedKey);
    expect(finder, findsOneWidget);
  }

  Finder expectSwapButton() {
    final finder = find.byKey(SwapIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  void expectNoSwapButton() {
    final finder = find.byKey(SwapIconButton.buttonKey);
    expect(finder, findsNothing);
  }

  Future<void> tapSwapButton() async {
    final finder = expectSwapButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Finder expectClearOutputButton() {
    final finder = find.byKey(ClearOutputIconButton.buttonKey);
    expect(finder, findsOneWidget);
    return finder;
  }

  void expectNoClearOutputButton() {
    final finder = find.byKey(ClearOutputIconButton.buttonKey);
    expect(finder, findsNothing);
  }

  Future<void> tapClearOutputButton() async {
    final finder = expectClearOutputButton();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  void expectHudBackground() {
    final finder = find.byKey(HudOverlay.bgHudKey);
    expect(finder, findsOneWidget);
  }

  void expectLaterHudBackground() {
    final finder = find.byKey(HudOverlay.bgHudKey);
    expectLater(finder, findsOneWidget);
  }

  void expectHudLoading() {
    final finder = find.byKey(HudOverlay.loadingHudKey);
    expect(finder, findsOneWidget);
  }

  void expectLaterHudLoading() {
    final finder = find.byKey(HudOverlay.loadingHudKey);
    expectLater(finder, findsOneWidget);
  }
}
