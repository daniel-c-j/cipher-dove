// ignore_for_file: depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:cipher_dove/src/constants/_constants.dart';
import 'package:cipher_dove/src/core/_core.dart';
import 'package:cipher_dove/src/core/local_db/hive_registrar.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';

import 'goldens/golden_robot.dart';
import 'src/features/home/home_robot.dart';

@visibleForTesting
class Robot {
  Robot(this.tester)
      : home = HomeRobot(tester),
        golden = GoldenRobot(tester);

  final WidgetTester tester;
  final HomeRobot home;
  final GoldenRobot golden;

  Future<void> _necessaryIntializations() async {
    try {
      await EasyLocalization.ensureInitialized();
      Default.init();
      NetConsts.init();
      await AppInfo.init(const PackageInfoWrapper());

      // Hive-specific
      if (Default.LOCAL_DB == LocalDB.hive) {
        Hive.init((Directory('/mock/path')).path);
        Hive.registerAdapters();
        await Hive.initBoxes();
      }
    } catch (e) {
      // Simply put, they're all initialized.
      log(e.toString());
    }
  }

  Future<void> pumpApp({bool isGolden = false, ProviderContainer? container}) async {
    WidgetsFlutterBinding.ensureInitialized();

    // Simulation requirements.
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
    canListenToNetworkStatusChange = false;

    // Easy_localization test requirement.
    SharedPreferences.setMockInitialValues({});

    await _necessaryIntializations(); // Must be before rootWidget.

    // Creating app startup instance for initialization.
    const appStartup = AppStartup();
    final container_ = await appStartup.initializeProviderContainer();
    final root = await appStartup.createRootWidget(container: container ?? container_, minimumTest: true);

    // * Entry point of the app
    await tester.pumpWidget(root);
    await tester.pumpAndSettle();
  }

  Future<void> defaultCipherOperation() async {
    const input = "My Input";
    const inputSecret = "Input Secret";
    const output = "ÓáMÝV/¹IÈê?";

    home.expectLayoutIsCorrectByDefault();
    // Inserting input
    await home.enterTextInputField(input);
    await home.enterInputPassField(inputSecret);
    // Process start
    await home.tapProcessButton();
    // Post-processing output
    home.expectOutputField(content: output, tester: tester);
    home.expectSwapButton();
    home.expectClearOutputButton();
    // Swap and decrypt
    await home.tapClearInputButton();
    await home.tapSwapButton();
    await home.tapDecryptSwitch();
    // Process start again
    await home.tapProcessButton();
    // Final output after decrypt is the same as input
    home.expectOutputField(content: input, tester: tester);
    home.expectSwapButton();
    home.expectClearOutputButton();
    // Copying output
    await home.tapOutputField();
    home.expectOutputCopiedSnackbar();
  }
}
